import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

@Injectable()
export class TermiiService {
  private readonly apiKey: string;
  private readonly senderId: string;
  private readonly baseUrl: string = 'https://api.ng.termii.com/api';

  constructor(private configService: ConfigService) {
    this.apiKey = this.configService.get('TERMII_API_KEY') || 'TLGWqhhYracCYvuvDJXbWklbGDidGcEmqcSANILXeUwbIVVHenpTuYGkCDEgTF';
    this.senderId = this.configService.get('TERMII_SENDER_ID') || 'UNIAlert';
  }

  async sendVerificationCode(phoneNumber: string): Promise<string> {
    try {
      const verificationCode = Math.floor(100000 + Math.random() * 900000).toString();

      const response = await axios.post(
        `${this.baseUrl}/sms/send`,
        {
          to: phoneNumber,
          from: this.senderId,
          sms: `Your NadiaPoint verification code is: ${verificationCode}`,
          type: 'plain',
          channel: 'generic',
          api_key: this.apiKey,
        },
        {
          headers: {
            'Content-Type': 'application/json',
          },
        },
      );

      if (response.data.code !== 'ok') {
        throw new Error('Failed to send SMS via Termii');
      }

      return verificationCode;
    } catch (error) {
      console.error('Termii error:', error);
      throw new Error('Failed to send verification code via Termii');
    }
  }
} 