import { Injectable } from '@nestjs/common';
import { baseTemplate } from './templates/base.template';
import { LoginInfoDto } from '../auth/dto/login-info.dto';
import { format } from 'date-fns';
import { Decimal } from 'decimal.js';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class EmailTemplatesService {
  constructor(private readonly configService: ConfigService) {}

  verificationEmail(code: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Welcome to NadiaPoint Exchange! 🚀</h1>
      <p>Thank you for joining NadiaPoint Exchange. To complete your registration, please use the verification code below:</p>
      
      <div class="code-block">
        ${code}
      </div>
      
      <p>This code will expire in <span class="highlight">15 minutes</span>.</p>
      
      <p>If you didn't create an account with NadiaPoint Exchange, you can safely ignore this email.</p>
      
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;
    return baseTemplate(content, isDark, logoUrl);
  }

  passwordResetEmail(code: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Reset Your Password 🔐</h1>
      <p>We received a request to reset your password. Use the code below to proceed:</p>
      
      <div class="code-block">
        ${code}
      </div>
      
      <p>This code will expire in <span class="highlight">15 minutes</span>.</p>
      
      <p>If you didn't request a password reset, please secure your account immediately.</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  twoFactorAuthEmail(code: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Two-Factor Authentication 🔒</h1>
      <p>Use the following code to complete your login:</p>
      
      <div class="code-block">
        ${code}
      </div>
      
      <p>This code will expire in <span class="highlight">5 minutes</span>.</p>
      
      <p>If you didn't attempt to log in, please secure your account immediately.</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  welcomeEmail(userName: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Welcome to NadiaPoint Exchange! 🎉</h1>
      <p>Congratulations on verifying your account! You're now part of a secure and innovative crypto trading platform.</p>

      <div style="margin: 30px 0;">
        <h2 style="color: #ffc300;">What's Next? 🚀</h2>
        
        <div style="margin: 20px 0;">
          <h3 style="color: ${isDark ? '#ffd60a' : '#003566'};">1. Complete Your Profile</h3>
          <p>➜ Set up 2FA for enhanced security</p>
          <p>➜ Complete KYC verification for higher limits</p>
          <p>➜ Add your preferred payment methods</p>
        </div>

        <div style="margin: 20px 0;">
          <h3 style="color: ${isDark ? '#ffd60a' : '#003566'};">2. Explore Our Features</h3>
          <p>➜ Spot Trading with 100+ trading pairs</p>
          <p>➜ P2P Trading with multiple payment options</p>
          <p>➜ Real-time market data and analytics</p>
        </div>

        <div style="margin: 20px 0;">
          <h3 style="color: ${isDark ? '#ffd60a' : '#003566'};">3. Get Trading Benefits</h3>
          <p>➜ Zero fees on your first trade</p>
          <p>➜ Earn rewards through our referral program</p>
          <p>➜ Access to exclusive trading events</p>
        </div>
      </div>

      <div style="margin: 30px 0;">
        <h2 style="color: #ffc300;">Need Help? 🤝</h2>
        <p>Our support team is available 24/7 to assist you:</p>
        <ul style="list-style: none; padding: 0;">
          <li>📚 <a href="#" style="color: #ffc300;">Documentation</a></li>
          <li>💬 <a href="#" style="color: #ffc300;">Live Chat Support</a></li>
          <li>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></li>
        </ul>
      </div>

      <div style="margin: 30px 0;">
        <h2 style="color: #ffc300;">Stay Connected 🌐</h2>
        <p>Join our community to get the latest updates and trading tips:</p>
        <div style="margin: 15px 0;">
          <a href="#" class="button">Join Our Community</a>
        </div>
      </div>

      <div style="margin-top: 40px;">
        <p>Happy Trading! 📈</p>
        <p>Best regards,<br>The NadiaPoint Team</p>
      </div>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  passwordChangedEmail(userName: string, isDark = true): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Password Changed Successfully 🔒</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your password has been successfully changed. If you did not make this change, please:</p>
        <ol style="margin: 20px 0;">
          <li>Change your password immediately</li>
          <li>Enable 2FA if not already enabled</li>
          <li>Contact our support team</li>
        </ol>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Security Tips 🛡️</h2>
        <ul style="list-style: none; padding: 0;">
          <li>✓ Use a unique password for each account</li>
          <li>✓ Enable 2FA for additional security</li>
          <li>✓ Never share your password with anyone</li>
          <li>✓ Regularly check your account activity</li>
        </ul>
      </div>

      <div style="margin: 20px 0;">
        <p>If you need any assistance, our support team is available 24/7.</p>
        <p>Best regards,<br>The NadiaPoint Team</p>
      </div>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  twoFactorEnabledEmail(isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Two-Factor Authentication Enabled 🔒</h1>
      <p>2FA has been successfully enabled on your account. Your account is now more secure!</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Important Security Tips</h2>
        <ul>
          <li>Keep your backup codes in a safe place</li>
          <li>Don't share your 2FA codes with anyone</li>
          <li>Set up a backup authenticator app if possible</li>
        </ul>
      </div>

      <p>If you didn't enable 2FA, please contact our support team immediately:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  twoFactorDisabledEmail(isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Two-Factor Authentication Disabled ⚠️</h1>
      <p>2FA has been disabled on your account. Your account security is now reduced.</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Security Recommendations</h2>
        <ul>
          <li>Consider re-enabling 2FA for better security</li>
          <li>Make sure you have a strong password</li>
          <li>Monitor your account for suspicious activity</li>
        </ul>
      </div>

      <p>If you didn't disable 2FA, please contact our support team immediately:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  loginNotificationEmail(loginInfo: LoginInfoDto, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New Login Detected 🔔</h1>
      <p>We detected a new login to your NadiaPoint Exchange account.</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Login Details</h2>
        <ul>
          <li>Time: ${loginInfo.timestamp.toLocaleString()}</li>
          <li>Location: ${loginInfo.location.city || 'Unknown'}, ${loginInfo.location.country || 'Unknown'}</li>
          <li>Device: ${loginInfo.device.device || 'Unknown'}</li>
          <li>Browser: ${loginInfo.device.browser || 'Unknown'}</li>
          <li>Operating System: ${loginInfo.device.os || 'Unknown'}</li>
          <li>IP Address: ${loginInfo.ip}</li>
        </ul>
      </div>

      <p>If this wasn't you, please:</p>
      <ol>
        <li>Change your password immediately</li>
        <li>Enable 2FA if not already enabled</li>
        <li>Contact our support team</li>
      </ol>

      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  kycLevelUpgradeEmail(userName: string, newLevel: number, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>KYC Level ${newLevel} Achieved! 🎉</h1>
      <p>Congratulations ${userName}! Your KYC level has been upgraded to Level ${newLevel}.</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">New Benefits 🌟</h2>
        ${this.getKYCLevelBenefits(newLevel)}
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        ${this.getNextStepsContent(newLevel)}
      </div>

      <p>Thank you for choosing NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  private getKYCLevelBenefits(level: number): string {
    const benefits = {
      1: `
        <ul>
          <li>Increased withdrawal limits</li>
          <li>Access to P2P trading</li>
          <li>Basic trading features</li>
        </ul>
      `,
      2: `
        <ul>
          <li>Higher withdrawal limits</li>
          <li>Advanced trading features</li>
          <li>Lower trading fees</li>
          <li>OTC trading access</li>
        </ul>
      `,
      3: `
        <ul>
          <li>Maximum withdrawal limits</li>
          <li>VIP trading features</li>
          <li>Lowest trading fees</li>
          <li>Priority support</li>
          <li>Exclusive market insights</li>
        </ul>
      `,
    };
    return benefits[level] || '';
  }

  private getNextStepsContent(level: number): string {
    const nextSteps = {
      1: `
        <p>To unlock more benefits, consider upgrading to Level 2:</p>
        <ul>
          <li>Submit a valid government ID</li>
          <li>Provide proof of address</li>
          <li>Complete facial verification</li>
        </ul>
      `,
      2: `
        <p>To reach our highest tier (Level 3), you'll need to:</p>
        <ul>
          <li>Complete advanced verification</li>
          <li>Provide additional documentation</li>
          <li>Pass enhanced due diligence</li>
        </ul>
      `,
      3: `
        <p>You've reached our highest KYC level! You now have access to all features and benefits.</p>
        <ul>
          <li>Explore our advanced trading features</li>
          <li>Join our VIP community</li>
          <li>Contact your dedicated account manager</li>
        </ul>
      `,
    };
    return nextSteps[level] || '';
  }

  verificationFailedEmail(
    fullName: string,
    reason: string,
    isDark = true,
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Identity Verification Failed ❌</h1>
      <p>Hello ${fullName},</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Issue Details ⚠️</h2>
        <p>${reason}</p>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ul>
          <li>Please ensure your documents are clear and valid</li>
          <li>Make sure photos are well-lit and not blurry</li>
          <li>Try the verification process again</li>
        </ul>
      </div>

      <p>If you need assistance, our support team is here to help!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  verificationSuccessEmail(fullName: string, isDark = true): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Identity Verification Successful! 🎉</h1>
      <p>Congratulations ${fullName}!</p>
      
      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">What's Next 🌟</h2>
        <ul>
          <li>Access to all platform features</li>
          <li>Higher transaction limits</li>
          <li>Enhanced security features</li>
        </ul>
      </div>

      <p>Thank you for choosing NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  verificationStatusEmail(
    status: string,
    text: string,
    fullName: string,
    isDark = true,
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>${status === 'completed' ? 'Verification Complete! 🎉' : 'Verification Update ⚠️'}</h1>
      <p>Hello ${fullName},</p>
      
      <div style="margin: 20px 0;">
        ${text}
      </div>

      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  paymentMethodAddedEmail(userName: string, methodName: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New Payment Method Added 💳</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A new payment method has been added to your account:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${methodName}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Security Tips 🔒</h2>
        <ul>
          <li>Regularly review your payment methods</li>
          <li>Enable 2FA for enhanced security</li>
          <li>Never share your payment details</li>
        </ul>
      </div>

      <p>If you didn't add this payment method, please contact our support team immediately:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  paymentMethodUpdatedEmail(userName: string, methodName: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Payment Method Updated ✏️</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your payment method has been updated:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${methodName}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>If you didn't make this change, please:</p>
        <ol>
          <li>Review your payment methods immediately</li>
          <li>Change your password</li>
          <li>Contact our support team</li>
        </ol>
      </div>

      <p>Need help? Contact us:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  paymentMethodDeletedEmail(userName: string, methodName: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Payment Method Deleted 🗑️</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A payment method has been removed from your account:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${methodName}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>If you didn't delete this payment method, please:</p>
        <ol>
          <li>Change your password immediately</li>
          <li>Enable 2FA if not already enabled</li>
          <li>Contact our support team</li>
        </ol>
      </div>

      <p>Need assistance? We're here to help:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  depositCreatedEmail(userName: string, amount: string, currency: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New Deposit Received 📥</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A new deposit has been detected in your wallet:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${amount} ${currency}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>The deposit is currently pending confirmation. We'll notify you once it's confirmed and credited to your balance.</p>
      </div>

      <p>Need assistance? Contact our support team:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  depositConfirmedEmail(userName: string, amount: string, currency: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Deposit Confirmed ✅</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your deposit has been confirmed and credited to your balance:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${amount} ${currency}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>You can now use these funds for trading or other services on NadiaPoint Exchange.</p>
      </div>

      <p>Happy trading!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  withdrawalNotificationEmail(userName: string, amount: string, currency: string, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Withdrawal Placed! 💸</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your withdrawal has been successfully placed:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${amount} ${currency}</h3>
        </div>
        <p>If you did not initiate this withdrawal, please contact our support team immediately.</p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  withdrawalProcessedEmail(userName: string, amount: string, currency: string, status: string, txHash: string | null = null, isDark = true) {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    // Format the amount to have proper decimal places and thousand separators
    const formattedAmount = this.formatAmount(amount);

    const statusColor = status === 'completed' ? '#00c853' : 
                       status === 'failed' ? '#d32f2f' : 
                       status === 'cancelled' ? '#ff5722' : '#ff9800';
    const statusEmoji = status === 'completed' ? '✅' : 
                       status === 'failed' ? '❌' : 
                       status === 'cancelled' ? '🚫' : '⏳';
    
    const content = `
      <h1>Withdrawal ${status.charAt(0).toUpperCase() + status.slice(1)} ${statusEmoji}</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your withdrawal request has been processed:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${formattedAmount} ${currency}</h3>
          <p style="margin: 5px 0; color: ${statusColor}; font-weight: bold;">Status: ${status.charAt(0).toUpperCase() + status.slice(1)}</p>
          ${txHash ? `<p style="margin: 5px 0;">Transaction Hash: ${txHash}</p>` : ''}
        </div>
      </div>

      ${this.getWithdrawalStatusMessage(status)}

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;
    
    return baseTemplate(content, isDark, logoUrl);
  }

  private formatAmount(amount: string): string {
    try {
      // Convert to Decimal for precise handling
      const decimal = new Decimal(amount);
      
      // Format with up to 8 decimal places, trimming trailing zeros
      let formatted = decimal.toFixed(8);
      
      // Remove trailing zeros after decimal point
      formatted = formatted.replace(/\.?0+$/, '');
      
      // Add thousand separators
      const parts = formatted.split('.');
      parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      
      return parts.join('.');
    } catch (error) {
      console.error('Error formatting amount:', error);
      return amount; // Return original amount if formatting fails
    }
  }

  private getWithdrawalStatusMessage(status: string): string {
    switch (status.toLowerCase()) {
        case 'completed':
            return `
                <div style="margin: 20px 0;">
                    <h2 style="color: #ffc300;">Transaction Complete! 🎉</h2>
                    <p>Your withdrawal has been successfully processed and sent to your wallet.</p>
                    <p>Please allow some time for the transaction to be confirmed on the blockchain.</p>
                </div>
            `;
        case 'failed':
            return `
                <div style="margin: 20px 0;">
                    <h2 style="color: #ffc300;">Transaction Failed ⚠️</h2>
                    <p>Unfortunately, your withdrawal could not be processed. This could be due to:</p>
                    <ul>
                        <li>Network congestion or technical issues</li>
                        <li>Insufficient blockchain network fees</li>
                        <li>Invalid withdrawal address</li>
                    </ul>
                    <p>Please contact our support team for assistance.</p>
                </div>
            `;
        case 'cancelled':
            return `
                <div style="margin: 20px 0;">
                    <h2 style="color: #ffc300;">Withdrawal Cancelled 🚫</h2>
                    <p>Your withdrawal request has been cancelled by the administrator.</p>
                    <p>The funds have been returned to your account balance.</p>
                    <p>If you did not request this cancellation or have any questions, please contact our support team.</p>
                </div>
            `;
        case 'processing':
            return `
                <div style="margin: 20px 0;">
                    <h2 style="color: #ffc300;">Processing Your Withdrawal 🔄</h2>
                    <p>Your withdrawal is being processed. You will receive another email once it's completed.</p>
                    <p>This process typically takes a few minutes but may take longer during periods of high network congestion.</p>
                </div>
            `;
        default:
            return '';
    }
  }

  private compile(templateName: string, data: any): string {
    switch (templateName) {
      case 'transfer-confirmation':
        return this.transferConfirmationEmail(
          data.amount,
          data.token,
          data.fromType,
          data.toType,
          data.date,
        );
      default:
        throw new Error(`Template ${templateName} not found`);
    }
  }

  private transferConfirmationEmail(
    amount: string,
    token: string,
    fromType: string,
    toType: string,
    date: string,
    isDark = true,
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Transfer Confirmation ✅</h1>
      <p>Your transfer has been completed successfully:</p>
      
      <div style="margin: 20px 0;">
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${amount} ${token}</h3>
          <p style="margin: 5px 0;">From: ${fromType}</p>
          <p style="margin: 5px 0;">To: ${toType}</p>
          <p style="margin: 5px 0; font-size: 0.9em;">Date: ${date}</p>
        </div>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  async getTransferConfirmationTemplate(data: {
    amount: string;
    token: string;
    fromType: string;
    toType: string;
    date: Date;
  }, isDark = true): Promise<string> {
    const logoUrl = this.configService.get<string>('LOGO_URL');
      const content = `
      <h1>Transfer Confirmation ✅</h1>
      <p>Your transfer has been completed successfully:</p>
      
      <div style="margin: 20px 0;">
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">${data.amount} ${data.token}</h3>
          <div style="margin-top: 10px;">
            <p style="margin: 5px 0;">From: <span style="color: #ffc300;">${data.fromType}</span></p>
            <p style="margin: 5px 0;">To: <span style="color: #ffc300;">${data.toType}</span></p>
            <p style="margin: 5px 0; font-size: 0.9em;">Date: ${format(data.date, 'PPpp')}</p>
          </div>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Security Tips 🛡️</h2>
        <ul style="list-style: none; padding: 0;">
          <li>✓ Always verify your transfer details</li>
          <li>✓ Enable 2FA for additional security</li>
          <li>✓ Monitor your account activity regularly</li>
        </ul>
      </div>

      <p>Need assistance? Contact our support team:</p>
      <p>📧 <a href="mailto:support@nadiapoint.com" style="color: #ffc300;">support@nadiapoint.com</a></p>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  async getConversionConfirmationTemplate(data: {
    fromAmount: string;
    fromToken: string;
    toAmount: string;
    toToken: string;
    fee: string;
    feeType: string;
    date: Date;
  }): Promise<string> {
    const isDark = true;
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Conversion Confirmation ✅</h1>
      <p>Your conversion has been completed successfully:</p>
      
      <div style="margin: 20px 0;">
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">
            ${data.fromAmount} ${data.fromToken} → ${data.toAmount} ${data.toToken}
          </h3>
          <div style="margin-top: 10px;">
            <p style="margin: 5px 0;">Fee: ${data.fee} ${data.feeType === 'percentage' ? '%' : data.fromToken}</p>
            <p style="margin: 5px 0; font-size: 0.9em;">Date: ${format(data.date, 'PPpp')}</p>
          </div>
        </div>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, true, logoUrl);
  }

  p2pOrderCreatedBuyerEmail(
    userName: string, 
    trackingId: string, 
    amount: string, 
    currency: string, 
    tokenSymbol: string,
    paymentDeadline: Date,
    isDark = true
  ): string {
    const deadlineFormatted = paymentDeadline.toLocaleString();
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Created - Buy ${tokenSymbol} 🔄</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your P2P buy order has been created successfully:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; font-size: 0.9em; color: ${isDark ? '#ff9800' : '#e65100'};">
            Payment Deadline: ${deadlineFormatted}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>Make the payment using the seller's payment details</li>
          <li>Mark the order as "Paid" on the platform</li>
          <li>Wait for the seller to confirm receipt of payment</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: You must complete payment before the deadline or the order may be cancelled.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderCreatedSellerEmail(
    userName: string, 
    trackingId: string, 
    amount: string, 
    tokenSymbol: string,
    currency: string,
    paymentDeadline: Date,
    isDark = true
  ): string {
    const deadlineFormatted = paymentDeadline.toLocaleString();
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Created - Sell ${tokenSymbol} 🔄</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Your P2P sell order has been created successfully:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; font-size: 0.9em; color: ${isDark ? '#ff9800' : '#e65100'};">
            Payment Deadline: ${deadlineFormatted}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>Wait for the buyer to make payment using your payment details</li>
          <li>Once the buyer marks the order as "Paid", check your payment account</li>
          <li>Confirm receipt of payment to release the ${tokenSymbol}</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: The buyer must complete payment before the deadline.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderReceivedBuyerEmail(
    userName: string, 
    trackingId: string, 
    amount: string, 
    currency: string, 
    tokenSymbol: string,
    paymentDeadline: Date,
    isDark = true
  ): string {
    const deadlineFormatted = paymentDeadline.toLocaleString();
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Received - Buy ${tokenSymbol} 🔄</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A seller has placed an order for your P2P offer:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; font-size: 0.9em; color: ${isDark ? '#ff9800' : '#e65100'};">
            Payment Deadline: ${deadlineFormatted}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>Wait for the seller to confirm the order</li>
          <li>Make payment once the seller confirms</li>
          <li>Wait for the seller to release the ${tokenSymbol}</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: Payment must be completed before the deadline.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderReceivedSellerEmail(
    userName: string, 
    trackingId: string, 
    amount: string, 
    tokenSymbol: string,
    currency: string,
    paymentDeadline: Date,
    isDark = true
  ): string {
    const deadlineFormatted = paymentDeadline.toLocaleString();
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Received - Sell ${tokenSymbol} 🔄</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A buyer has placed an order for your P2P offer:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; font-size: 0.9em; color: ${isDark ? '#ff9800' : '#e65100'};">
            Payment Deadline: ${deadlineFormatted}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>The buyer will make payment using your payment details</li>
          <li>Once the buyer marks the order as "Paid", check your payment account</li>
          <li>Confirm receipt of payment to release the ${tokenSymbol}</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: The buyer must complete payment before the deadline.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pNewMessageEmail(
    userName: string,
    trackingId: string,
    isSystemMessage: boolean = false,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New P2P Message Received 💬</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>${isSystemMessage ? 'A system notification' : 'A new message'} has been sent in your P2P order:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>Please log in to your NadiaPoint Exchange account to view and respond to the message.</p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderPaidEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    confirmationDeadline: Date,
    isDark = true
  ): string {
    const deadlineFormatted = confirmationDeadline.toLocaleString();
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Marked as Paid 💰</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>The buyer has marked the following order as paid:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; font-size: 0.9em; color: ${isDark ? '#ff9800' : '#e65100'};">
            Confirmation Deadline: ${deadlineFormatted}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>Check your payment account for the received payment</li>
          <li>Confirm receipt of payment to release the ${tokenSymbol}</li>
          <li>If payment is not received, raise a dispute</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: You must confirm or dispute the payment before the confirmation deadline.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pDisputeCreatedUserEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    reasonType: string,
    reason: string,
    isDark = true
  ): string {
    // Convert reasonType from snake_case to a more readable format
    const formattedReasonType = reasonType
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
    
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Disputed ⚠️</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A dispute has been raised for the following P2P order:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0;">Reason Type: ${formattedReasonType}</p>
          <p style="margin: 5px 0;">Reason: ${reason}</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <ol>
          <li>Log in to your NadiaPoint Exchange account</li>
          <li>Navigate to the P2P Order Details page</li>
          <li>Respond to the dispute with any relevant information</li>
          <li>Our admin team will review the case and assist with resolution</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: Please respond promptly to ensure a quick resolution.
        </p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pDisputeCreatedAdminEmail(
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    reasonType: string,
    reason: string,
    initiatorName: string,
    respondentName: string,
    isDark = true
  ): string {
    // Convert reasonType from snake_case to a more readable format
    const formattedReasonType = reasonType
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
    
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New P2P Dispute Raised ⚠️</h1>
      <p>Hello Admin,</p>
      
      <div style="margin: 20px 0;">
        <p>A new dispute has been raised for the following P2P order:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0;">Initiator: ${initiatorName}</p>
          <p style="margin: 5px 0;">Respondent: ${respondentName}</p>
          <p style="margin: 5px 0;">Reason Type: ${formattedReasonType}</p>
          <p style="margin: 5px 0;">Reason: ${reason}</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Required Actions 🚀</h2>
        <ol>
          <li>Log in to the admin panel</li>
          <li>Navigate to P2P Disputes section</li>
          <li>Review the dispute details and communication between users</li>
          <li>Mediate and resolve the dispute according to our policies</li>
        </ol>
        <p style="color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
          Important: Please address this dispute promptly as it impacts user satisfaction and platform trust.
        </p>
      </div>

      <p>Thank you for your attention to this matter.</p>
      <p>Best regards,<br>The NadiaPoint System</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pDisputeMessageUserEmail(
    userName: string,
    disputeId: string,
    trackingId: string,
    senderName: string,
    isAdmin: boolean = false,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New Dispute Message Received 💬</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>A new message has been sent in your dispute case:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">From: ${isAdmin ? 'Admin' : senderName}</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <p>Please log in to your NadiaPoint Exchange account to view and respond to the message.</p>
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pDisputeMessageAdminEmail(
    disputeId: string,
    trackingId: string,
    initiatorName: string,
    respondentName: string,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>New Dispute Message Received ⚠️</h1>
      <p>Hello Admin,</p>
      
      <div style="margin: 20px 0;">
        <p>A new message has been sent in a dispute case:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Dispute ID: ${disputeId}</p>
          <p style="margin: 5px 0;">Initiator: ${initiatorName}</p>
          <p style="margin: 5px 0;">Respondent: ${respondentName}</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Required Actions 🚀</h2>
        <ol>
          <li>Log in to the admin panel</li>
          <li>Navigate to P2P Disputes section</li>
          <li>Review the new message and take appropriate action</li>
        </ol>
      </div>

      <p>Thank you for your attention to this matter.</p>
      <p>Best regards,<br>The NadiaPoint System</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pDisputeStatusUpdateEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    newStatus: string,
    statusDetails: string,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>Dispute Status Update ⚠️</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>There has been an update to your dispute:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0; color: ${isDark ? '#ff9800' : '#e65100'}; font-weight: bold;">
            Status: ${newStatus}
          </p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Update Details</h2>
        <p>${statusDetails}</p>
        
        ${this.getNextStepsForStatus(newStatus)}
      </div>

      <p>If you have any questions, please use the in-app messaging feature to communicate with the admin.</p>
      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderCancelledEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    cancelledBy: 'buyer' | 'seller',
    reason: string,
    additionalDetails: string,
    isUserCanceller: boolean,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Cancelled ⚠️</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>${isUserCanceller ? 'You have cancelled' : 'The ' + cancelledBy + ' has cancelled'} the following P2P order:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total: ${currency}</p>
          <p style="margin: 5px 0;">Cancelled By: ${cancelledBy.charAt(0).toUpperCase() + cancelledBy.slice(1)}</p>
          <p style="margin: 5px 0;">Reason: ${reason}</p>
          ${additionalDetails ? `<p style="margin: 5px 0;">Additional Details: ${additionalDetails}</p>` : ''}
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">What Happens Next 🚀</h2>
        ${isUserCanceller ? `
          <p>Since you cancelled this order:</p>
          <ul>
            <li>The counterparty has been notified</li>
            <li>The trade is now marked as cancelled in your order history</li>
            ${cancelledBy === 'seller' ? '<li>Your funds have been returned to your available balance</li>' : ''}
          </ul>
        ` : `
          <p>Since the ${cancelledBy} cancelled this order:</p>
          <ul>
            <li>The trade is now marked as cancelled in your order history</li>
            ${cancelledBy === 'seller' ? '<li>If you are the buyer, no action is required</li>' : '<li>If you are the seller, your funds have been returned to your available balance</li>'}
          </ul>
        `}
      </div>

      <p>Thank you for using NadiaPoint Exchange!</p>
      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  private getNextStepsForStatus(status: string): string {
    status = status.toLowerCase();
    
    if (status === 'in_progress') {
      return `
        <h2 style="color: #ffc300;">Next Steps 🚀</h2>
        <p>An admin has joined your dispute and will assist in the resolution process. Please:</p>
        <ol>
          <li>Check for any admin messages in the dispute chat</li>
          <li>Provide any additional information requested by the admin</li>
          <li>Be responsive to ensure a quick resolution</li>
        </ol>
      `;
    } else if (status.includes('resolved')) {
      return `
        <h2 style="color: #ffc300;">Resolution Outcome 🎯</h2>
        <p>Your dispute has been resolved. Please check your wallet and order status for any changes.</p>
        <p>If you believe this resolution was made in error, please contact our support team within 24 hours.</p>
      `;
    } else if (status === 'closed') {
      return `
        <h2 style="color: #ffc300;">Dispute Closed 📝</h2>
        <p>This dispute has been closed. If you have any further concerns, please open a support ticket.</p>
      `;
    }
    
    return `
      <h2 style="color: #ffc300;">Dispute Progress 🔄</h2>
      <p>Your dispute is being processed. Please continue to monitor your account for further updates.</p>
    `;
  }

  p2pOrderCompletedBuyerEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Completed - Coins Received! 🎉</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>Great news! The seller has released your coins:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount Received: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total Paid: ${currency}</p>
          <p style="margin: 5px 0; color: #00c853; font-weight: bold;">Status: Completed</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">What's Next? 🚀</h2>
        <ul>
          <li>Your ${tokenSymbol} has been added to your funding wallet</li>
          <li>You can now transfer, trade, or withdraw your coins</li>
          <li>Don't forget to rate your trading experience</li>
        </ul>
      </div>

      <div style="margin: 20px 0;">
        <p>Thank you for choosing NadiaPoint for your P2P trading needs!</p>
      </div>

      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }

  p2pOrderCompletedSellerEmail(
    userName: string,
    trackingId: string,
    amount: string,
    tokenSymbol: string,
    currency: string,
    isDark = true
  ): string {
    const logoUrl = this.configService.get<string>('LOGO_URL');
    const content = `
      <h1>P2P Order Completed - Coins Released! ✅</h1>
      <p>Hello ${userName},</p>
      
      <div style="margin: 20px 0;">
        <p>You have successfully released coins to the buyer:</p>
        <div style="background: ${isDark ? '#2a2a2a' : '#f5f5f5'}; padding: 15px; border-radius: 8px; margin: 10px 0;">
          <h3 style="color: #ffc300; margin: 0;">Order #${trackingId}</h3>
          <p style="margin: 5px 0;">Amount Released: ${amount} ${tokenSymbol}</p>
          <p style="margin: 5px 0;">Total Received: ${currency}</p>
          <p style="margin: 5px 0; color: #00c853; font-weight: bold;">Status: Completed</p>
        </div>
      </div>

      <div style="margin: 20px 0;">
        <h2 style="color: #ffc300;">Transaction Summary 📊</h2>
        <ul>
          <li>The ${tokenSymbol} has been successfully transferred to the buyer</li>
          <li>The transaction is now marked as completed</li>
          <li>You can find this order in your completed orders history</li>
        </ul>
      </div>

      <div style="margin: 20px 0;">
        <p>Thank you for being a trusted seller on NadiaPoint Exchange!</p>
      </div>

      <p>Best regards,<br>The NadiaPoint Team</p>
    `;

    return baseTemplate(content, isDark, logoUrl);
  }
}
