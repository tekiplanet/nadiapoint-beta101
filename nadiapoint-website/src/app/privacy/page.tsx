import { Metadata } from "next"

export const metadata: Metadata = {
  title: "Privacy Policy | NadiaPoint",
  description: "Learn how NadiaPoint protects and handles your personal information.",
}

export default function PrivacyPolicy() {
  return (
    <div className="container mx-auto px-6 py-24 lg:px-8">
      <div className="mx-auto max-w-3xl">
        <h1 className="mb-8 text-4xl font-bold">Privacy Policy</h1>
        <div className="prose prose-gray max-w-none dark:prose-invert">
          <p className="text-muted-foreground">
            Last updated: {new Date().toLocaleDateString()}
          </p>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">1. Introduction</h2>
            <p>
              Welcome to NadiaPoint. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our cryptocurrency trading platform, mobile application, and related services.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">2. Information We Collect</h2>
            <h3 className="mt-4 text-xl font-medium">2.1 Personal Information</h3>
            <p>We collect information that you provide directly to us, including:</p>
            <ul>
              <li>Full name and contact details</li>
              <li>Date of birth and nationality</li>
              <li>Government-issued identification documents</li>
              <li>Residential address</li>
              <li>Email address and phone number</li>
              <li>Banking information and cryptocurrency wallet addresses</li>
              <li>Transaction history and trading activity</li>
            </ul>

            <h3 className="mt-4 text-xl font-medium">2.2 Automatically Collected Information</h3>
            <p>When you use our platform, we automatically collect:</p>
            <ul>
              <li>Device information (IP address, browser type, operating system)</li>
              <li>Usage data and activity logs</li>
              <li>Geographic location data</li>
              <li>Trading patterns and preferences</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">3. How We Use Your Information</h2>
            <p>We use your personal information to:</p>
            <ul>
              <li>Verify your identity and comply with KYC/AML regulations</li>
              <li>Process your transactions and maintain your account</li>
              <li>Provide customer support and respond to inquiries</li>
              <li>Send important updates about our services</li>
              <li>Detect and prevent fraud or suspicious activities</li>
              <li>Improve our platform and user experience</li>
              <li>Comply with legal obligations and regulatory requirements</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">4. Data Security</h2>
            <p>
              We implement robust security measures to protect your information, including:
            </p>
            <ul>
              <li>End-to-end encryption for sensitive data</li>
              <li>Multi-factor authentication</li>
              <li>Regular security audits and penetration testing</li>
              <li>Secure data storage with industry-standard encryption</li>
              <li>Strict access controls and monitoring</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">5. Data Sharing and Disclosure</h2>
            <p>We may share your information with:</p>
            <ul>
              <li>Regulatory authorities and law enforcement agencies</li>
              <li>Third-party service providers who assist in our operations</li>
              <li>Financial institutions for payment processing</li>
              <li>Professional advisors and consultants</li>
            </ul>
            <p>
              We do not sell your personal information to third parties.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">6. Your Rights and Choices</h2>
            <p>You have the right to:</p>
            <ul>
              <li>Access your personal information</li>
              <li>Correct inaccurate or incomplete data</li>
              <li>Request deletion of your data</li>
              <li>Object to certain data processing activities</li>
              <li>Data portability</li>
              <li>Withdraw consent for optional processing</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">7. Cookies and Tracking Technologies</h2>
            <p>
              We use cookies and similar tracking technologies to enhance your experience on our platform. You can control cookie preferences through your browser settings. For more information, please refer to our Cookie Policy.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">8. International Data Transfers</h2>
            <p>
              Your information may be transferred and processed in countries other than your own. We ensure appropriate safeguards are in place to protect your data during such transfers.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">9. Changes to This Policy</h2>
            <p>
              We may update this Privacy Policy from time to time. We will notify you of any material changes through our platform or via email.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">10. Contact Us</h2>
            <p>
              If you have any questions about this Privacy Policy or our data practices, please contact us at:
            </p>
            <ul>
              <li>Email: privacy@nadiapoint.com</li>
              {/* <li>Address: [Your Company Address]</li> */}
            </ul>
          </section>
        </div>
      </div>
    </div>
  )
} 