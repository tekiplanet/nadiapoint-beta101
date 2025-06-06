import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../auth/entities/user.entity';
import { Repository } from 'typeorm';
import { EmailService } from '../email/email.service';
import axios from 'axios';
import * as crypto from 'crypto';
import * as countryCodes from 'country-codes-list';
import type { CountryData } from 'country-codes-list';
import { KYCLevel } from '../auth/entities/kyc-level.entity';

interface SumsubWebhookPayload {
  type: string;
  applicantId: string;
  externalUserId: string;
  reviewStatus: string;
  reviewResult?: {
    reviewAnswer: 'GREEN' | 'RED';
    rejectLabels?: string[];
    reviewRejectType?: string;
  };
}

@Injectable()
export class SumsubService {
  private readonly baseUrl = 'https://api.sumsub.com';
  private readonly countryList: Array<{
    name: string;
    alpha2: string;
    alpha3: string;
  }>;

  constructor(
    private configService: ConfigService,
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(KYCLevel)
    private kycLevelRepository: Repository<KYCLevel>,
    private emailService: EmailService,
  ) {
    // Initialize country list with correct mappings
    const countries = countryCodes.all();
    this.countryList = countries.map((country: CountryData) => ({
      name: country.countryNameEn,
      alpha2: country.countryCode,
      alpha3: this.getAlpha3Code(country.countryCode), // Convert alpha2 to alpha3
    }));
  }

  // Helper method to convert alpha2 to alpha3
  private getAlpha3Code(alpha2: string): string {
    const alpha3Map: { [key: string]: string } = {
      NG: 'NGA', // Nigeria
      US: 'USA', // United States
      GB: 'GBR', // United Kingdom
      // Add more as needed, or implement a more comprehensive solution
    };
    return alpha3Map[alpha2] || alpha2;
  }

  private generateSignature(
    method: string,
    url: string,
    body: string = '',
  ): string {
    const ts = Math.floor(Date.now() / 1000).toString();
    const secretKey = this.configService.get<string>('SUMSUB_SECRET_KEY');
    const signature = crypto
      .createHmac('sha256', secretKey)
      .update(ts + method + url + body)
      .digest('hex');
    return signature;
  }

  async generateAccessToken(userId: string): Promise<string> {
    try {
      const user = await this.userRepository.findOne({ where: { id: userId } });
      if (!user) {
        throw new HttpException('User not found', HttpStatus.NOT_FOUND);
      }

      console.log('Current user KYC data:', user.kycData);

      // Create applicant if doesn't exist
      if (!user.kycData?.sumsubApplicantId) {
        console.log('No applicant ID found, creating new applicant...');
        const applicantId = await this.createApplicant(userId);
        user.kycData = {
          ...user.kycData,
          sumsubApplicantId: applicantId,
        };
        await this.userRepository.save(user);
      }

      const applicantId = user.kycData?.sumsubApplicantId;
      console.log('Using applicant ID:', applicantId);

      // Add parameters as query string
      const url = `/resources/accessTokens?userId=${userId}&levelName=id-and-liveness`;
      const method = 'POST';

      try {
        console.log('Making request to Sumsub API:', `${this.baseUrl}${url}`);
        const response = await axios({
          method,
          url: `${this.baseUrl}${url}`,
          headers: this.getHeaders(method, url),
        });

        console.log('Sumsub API response:', response.data);
        return response.data.token;
      } catch (error) {
        console.error('Sumsub API Error Details:', {
          error: error.response?.data,
          status: error.response?.status,
          headers: error.response?.headers,
          url: `${this.baseUrl}${url}`,
          method,
          requestHeaders: this.getHeaders(method, url),
        });

        throw new HttpException(
          error.response?.data?.description ||
            'Failed to generate access token',
          error.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    } catch (error) {
      console.error('Error in generateAccessToken:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to generate access token',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async handleWebhook(payload: SumsubWebhookPayload): Promise<void> {
    try {
      const { type, externalUserId, reviewStatus, reviewResult } = payload;

      // Add detailed logging
      console.log('Received Sumsub webhook:', {
        type,
        reviewStatus,
        reviewResult,
        fullPayload: payload,
      });

      const user = await this.userRepository.findOne({
        where: { id: externalUserId },
      });

      if (!user) {
        throw new Error(`User not found for ID: ${externalUserId}`);
      }

      switch (type) {
        case 'applicantReviewed':
        case 'applicantWorkflowCompleted':
          if (reviewResult) {
            const typedReviewResult = {
              ...reviewResult,
              reviewRejectType: reviewResult.reviewRejectType as
                | 'RETRY'
                | 'FINAL',
            };
            await this.handleVerificationComplete(
              user,
              reviewStatus,
              typedReviewResult,
            );
          } else {
            await this.handleVerificationComplete(user, reviewStatus);
          }
          break;

        case 'applicantPending':
          await this.updateVerificationStatus(user, {
            status: 'processing',
            lastAttempt: new Date(),
          });
          break;

        case 'applicantCreated':
          user.kycData = {
            ...user.kycData,
            sumsubApplicantId: payload.applicantId,
          };
          await this.userRepository.save(user);
          break;

        case 'applicantOnHold':
          await this.updateVerificationStatus(user, {
            status: 'pending',
            lastAttempt: new Date(),
            reviewAnswer: 'ON_HOLD',
          });
          break;
      }
    } catch (error) {
      console.error('Error handling webhook:', error);
      throw error;
    }
  }

  private async handleVerificationComplete(
    user: User,
    reviewStatus: string,
    reviewResult?: {
      reviewAnswer: 'GREEN' | 'RED';
      rejectLabels?: string[];
      reviewRejectType?: 'RETRY' | 'FINAL';
      moderationComment?: string;
      clientComment?: string;
      buttonIds?: string[];
    },
    level: 'identity' | 'advanced' = 'identity',
  ): Promise<void> {
    const status =
      reviewResult?.reviewAnswer === 'GREEN' ? 'completed' : 'failed';

    const finalReviewAnswer =
      status === 'completed' ? 'GREEN' : reviewResult?.reviewAnswer;

    await this.updateVerificationStatus(user, {
      status,
      lastAttempt: new Date(),
      reviewAnswer: finalReviewAnswer,
      reviewRejectType: reviewResult?.reviewRejectType as 'RETRY' | 'FINAL',
      reviewRejectDetails: reviewResult?.rejectLabels?.join(', '),
      moderationComment: reviewResult?.moderationComment,
      clientComment: reviewResult?.clientComment,
      level,
    });

    if (status === 'completed') {
      // Get appropriate KYC Level based on verification level
      const kycLevel = await this.kycLevelRepository.findOne({
        where: { level: level === 'advanced' ? 3 : 2 },
      });

      if (!kycLevel) {
        throw new Error(`KYC Level ${level === 'advanced' ? 3 : 2} not found`);
      }

      // Update user's KYC level
      await this.userRepository.update(user.id, {
        kycLevel: level === 'advanced' ? 3 : 2,
        kycLevelDetails: kycLevel,
      });
    }

    // Send email notification
    await this.emailService.sendVerificationStatusEmail(
      user.email,
      user.fullName,
      status as 'completed' | 'failed',
      reviewResult?.clientComment
        ? [reviewResult.clientComment]
        : reviewResult?.rejectLabels,
      level,
    );
  }

  private async updateVerificationStatus(
    user: User,
    status: {
      status: 'pending' | 'processing' | 'completed' | 'failed';
      lastAttempt: Date;
      reviewAnswer?: 'GREEN' | 'RED' | 'ON_HOLD';
      reviewRejectType?: 'RETRY' | 'FINAL';
      reviewRejectDetails?: string;
      moderationComment?: string;
      clientComment?: string;
      level?: 'identity' | 'advanced';
    },
  ): Promise<void> {
    user.kycData = {
      ...user.kycData,
      verificationStatus: {
        ...user.kycData?.verificationStatus,
        [status.level || 'identity']: {
          ...user.kycData?.verificationStatus?.[status.level || 'identity'],
          status: status.status,
          lastAttempt: status.lastAttempt,
          reviewAnswer: status.reviewAnswer,
          reviewRejectType: status.reviewRejectType,
          reviewRejectDetails: status.reviewRejectDetails,
          moderationComment: status.moderationComment,
          clientComment: status.clientComment,
        },
      },
    };

    await this.userRepository.save(user);
  }

  async createApplicant(userId: string): Promise<string> {
    try {
      const user = await this.userRepository.findOne({ where: { id: userId } });
      if (!user) {
        throw new HttpException('User not found', HttpStatus.NOT_FOUND);
      }

      console.log('Creating applicant for user:', {
        userId,
        kycData: user.kycData,
      });

      const countryCode = this.getCountryCode(
        user.kycData?.identityDetails?.country,
      );
      if (!countryCode) {
        throw new HttpException(
          `Invalid or unsupported country: ${user.kycData?.identityDetails?.country}`,
          HttpStatus.BAD_REQUEST,
        );
      }

      const url = '/resources/applicants';
      const method = 'POST';
      const body = JSON.stringify({
        externalUserId: userId,
        levelName: 'id-and-liveness',
        info: {
          firstName: user.kycData?.identityDetails?.firstName,
          lastName: user.kycData?.identityDetails?.lastName,
          dob: user.kycData?.identityDetails?.dateOfBirth,
          country: countryCode,
          phone: user.phone,
          email: user.email,
        },
        requiredIdDocs: {
          docSets: [
            {
              idDocSetType: 'IDENTITY',
              types: ['PASSPORT', 'ID_CARD', 'DRIVERS'],
            },
          ],
        },
      });

      try {
        console.log('Sending applicant creation request:', body);
        const response = await axios({
          method,
          url: `${this.baseUrl}${url}`,
          data: body,
          headers: this.getHeaders(method, url, body),
        });

        console.log('Applicant creation response:', response.data);
        return response.data.id;
      } catch (error) {
        // Check if error is due to existing applicant
        if (error.response?.status === 409) {
          const existingApplicantId =
            error.response.data.description.match(/(\w+)$/)[0];
          console.log('Using existing applicant ID:', existingApplicantId);
          return existingApplicantId;
        }

        console.error('Error creating Sumsub applicant:', {
          error: error.response?.data,
          status: error.response?.status,
          headers: error.response?.headers,
          fullError: error,
        });
        throw new HttpException(
          `Failed to create applicant: ${error.response?.data?.description || error.message}`,
          error.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    } catch (error) {
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to create applicant',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  private getCountryCode(countryName: string): string | null {
    if (!countryName) return null;

    // Try to find the country (case-insensitive)
    const country = this.countryList.find(
      (c) => c.name.toLowerCase() === countryName.toLowerCase(),
    );

    if (country) {
      return country.alpha3;
    }

    // If exact match not found, try fuzzy matching
    const fuzzyMatch = this.countryList.find(
      (c) =>
        c.name.toLowerCase().includes(countryName.toLowerCase()) ||
        countryName.toLowerCase().includes(c.name.toLowerCase()),
    );

    return fuzzyMatch ? fuzzyMatch.alpha3 : null;
  }

  private getHeaders(method: string, url: string, body: string = '') {
    const ts = Math.floor(Date.now() / 1000).toString();
    const appToken = this.configService.get<string>('SUMSUB_APP_TOKEN');

    return {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      'X-App-Token': appToken,
      'X-App-Access-Sig': this.generateSignature(method, url, body),
      'X-App-Access-Ts': ts,
    };
  }

  async getApplicantStatus(applicantId: string): Promise<any> {
    try {
      const url = `/resources/applicants/${applicantId}/status`;
      const method = 'GET';

      const response = await axios({
        method,
        url: `${this.baseUrl}${url}`,
        headers: this.getHeaders(method, url),
      });

      return response.data;
    } catch (error) {
      console.error('Error getting applicant status:', error);
      throw new HttpException(
        'Failed to get applicant status',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  private mapReviewStatus(
    reviewStatus: string,
  ): 'pending' | 'completed' | 'failed' {
    switch (reviewStatus) {
      case 'approved':
        return 'completed';
      case 'rejected':
        return 'failed';
      default:
        return 'pending';
    }
  }

  async verifyWebhookSignature(
    signature: string,
    payload: any,
    rawBody?: string,
  ): Promise<boolean> {
    try {
      const webhookSecret = this.configService.get<string>(
        'SUMSUB_WEBHOOK_SECRET',
      );

      // Important: Use rawBody directly without any modifications
      if (!rawBody) {
        console.error('Raw body is missing');
        return false;
      }

      const calculatedSignature = crypto
        .createHmac('sha256', webhookSecret)
        .update(rawBody) // Use rawBody directly
        .digest('hex');

      console.log('Detailed signature verification:', {
        webhookSecret,
        rawBodyLength: rawBody.length,
        rawBodyPreview: rawBody.substring(0, 100) + '...',
        receivedSignature: signature,
        calculatedSignature,
        match: signature === calculatedSignature,
        // Debug info
        rawBodyType: typeof rawBody,
        signatureType: typeof signature,
        firstFewChars: {
          rawBody: rawBody.substring(0, 20),
          signature: signature.substring(0, 20),
        },
      });

      return signature === calculatedSignature;
    } catch (error) {
      console.error('Error verifying webhook signature:', error);
      console.error('Full error:', {
        name: error.name,
        message: error.message,
        stack: error.stack,
      });
      return false;
    }
  }

  async handleWebhookEvent(payload: SumsubWebhookPayload) {
    try {
      const { type, applicantId, reviewStatus, reviewResult } = payload;
      console.log('Received webhook event:', {
        type,
        applicantId,
        reviewStatus,
        reviewResult,
      });

      const user = await this.userRepository
        .createQueryBuilder('user')
        .where(`"user"."kycData"->>'sumsubApplicantId' = :applicantId`, {
          applicantId,
        })
        .getOne();

      if (!user) {
        throw new Error(`No user found for applicant ID: ${applicantId}`);
      }

      // Determine if this is for advanced verification based on user's KYC level
      const isAdvancedVerification = user.kycLevel >= 2;
      const verificationType = isAdvancedVerification ? 'advanced' : 'identity';

      switch (type) {
        case 'applicantCreated':
        case 'applicantPending':
          await this.updateVerificationStatus(user, {
            status: 'pending',
            lastAttempt: new Date(),
            level: verificationType,
          });
          break;

        case 'applicantOnHold':
          await this.updateVerificationStatus(user, {
            status: 'pending',
            lastAttempt: new Date(),
            reviewAnswer: 'ON_HOLD',
            reviewRejectDetails: 'Application is on hold for review',
            level: verificationType,
          });
          break;

        case 'applicantReviewed':
        case 'applicantWorkflowCompleted':
          if (reviewResult) {
            const typedReviewResult = {
              ...reviewResult,
              reviewRejectType: reviewResult.reviewRejectType as
                | 'RETRY'
                | 'FINAL',
            };
            await this.handleVerificationComplete(
              user,
              reviewStatus,
              typedReviewResult,
              verificationType,
            );
          } else {
            await this.handleVerificationComplete(
              user,
              reviewStatus,
              undefined,
              verificationType,
            );
          }
          break;
      }

      return { success: true };
    } catch (error) {
      console.error('Error handling webhook event:', error);
      throw new HttpException(
        'Failed to process webhook event',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  private getWebhookSecret(): string {
    const secret = this.configService.get<string>('SUMSUB_WEBHOOK_SECRET');
    console.log('Webhook secret details:', {
      original: secret,
      decoded: decodeURIComponent(secret),
      encoded: encodeURIComponent(secret),
    });
    return secret;
  }

  async startAdvancedVerification(userId: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { id: userId } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }

    // Only check kycLevel for advanced verification eligibility
    if (user.kycLevel < 2) {
      throw new HttpException(
        'Complete Level 2 verification first',
        HttpStatus.BAD_REQUEST,
      );
    }

    // Optionally log a warning if the Sumsub fields are missing or not completed
    if (
      !user.kycData?.verificationStatus?.identity ||
      user.kycData.verificationStatus.identity.status !== 'completed' ||
      user.kycData.verificationStatus.identity.reviewAnswer !== 'GREEN'
    ) {
      console.warn(
        `User ${user.id} is proceeding to advanced verification without completed Sumsub identity status.`
      );
    }

    // Generate token for advanced verification
    const url = `/resources/accessTokens?userId=${userId}&levelName=advanced-verification`;
    const method = 'POST';

    try {
      const response = await axios({
        method,
        url: `${this.baseUrl}${url}`,
        headers: this.getHeaders(method, url),
      });
      console.log('[Sumsub] Advanced verification response:', response.data);
      if (!response.data || !response.data.token) {
        console.warn('[Sumsub] No token received from Sumsub for advanced verification:', response.data);
        throw new HttpException('Failed to generate advanced verification token', HttpStatus.INTERNAL_SERVER_ERROR);
      }
      console.log('[Sumsub] Advanced verification token:', response.data.token);
      return response.data.token;
    } catch (error) {
      console.error('[Sumsub] Error in startAdvancedVerification:', error?.response?.data || error);
      throw new HttpException(
        error?.response?.data?.message || 'Failed to start advanced verification',
        error?.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
