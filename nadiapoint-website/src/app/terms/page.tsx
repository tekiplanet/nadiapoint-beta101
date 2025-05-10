import { Metadata } from "next"

export const metadata: Metadata = {
  title: "Terms of Service | NadiaPoint",
  description: "Read about the terms and conditions that govern your use of NadiaPoint's cryptocurrency trading platform and services.",
}

export default function TermsOfService() {
  return (
    <div className="container mx-auto px-6 py-24 lg:px-8">
      <div className="mx-auto max-w-3xl">
        <h1 className="mb-8 text-4xl font-bold">Terms of Service</h1>
        <div className="prose prose-gray max-w-none dark:prose-invert">
          <p className="text-muted-foreground">
            Last updated: {new Date().toLocaleDateString()}
          </p>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">1. Agreement to Terms</h2>
            <p>
              By accessing or using NadiaPoint's services, including our website, mobile application, API, and cryptocurrency trading platform (collectively, the "Services"), you agree to be bound by these Terms of Service ("Terms"). If you disagree with any part of these terms, you may not access our Services.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">2. Eligibility</h2>
            <p>To use our Services, you must:</p>
            <ul>
              <li>Be at least 18 years old</li>
              <li>Have the legal capacity to enter into these Terms</li>
              <li>Not be a resident of restricted jurisdictions</li>
              <li>Complete our identity verification process</li>
              <li>Maintain accurate and up-to-date account information</li>
            </ul>
            <p>
              We reserve the right to refuse service, terminate accounts, or remove content at our sole discretion.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">3. Account Registration and Security</h2>
            <p>
              When you create an account with us, you must provide accurate, complete, and current information. You are responsible for:
            </p>
            <ul>
              <li>Maintaining the confidentiality of your account credentials</li>
              <li>Restricting access to your account</li>
              <li>All activities that occur under your account</li>
              <li>Implementing strong security practices (e.g., 2FA)</li>
              <li>Notifying us immediately of any unauthorized access</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">4. Trading Rules and Guidelines</h2>
            <p>When using our trading platform, you agree to:</p>
            <ul>
              <li>Not engage in market manipulation or fraudulent activities</li>
              <li>Not use automated trading systems without our explicit approval</li>
              <li>Accept all executed trades as final</li>
              <li>Maintain sufficient funds to cover your trading activities</li>
              <li>Comply with all applicable trading limits and restrictions</li>
            </ul>
            <p>
              We reserve the right to suspend trading, cancel orders, or close positions in cases of market volatility, technical issues, or suspected violations of these terms.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">5. Fees and Payments</h2>
            <p>
              By using our Services, you agree to pay all applicable fees, including:
            </p>
            <ul>
              <li>Trading fees</li>
              <li>Withdrawal fees</li>
              <li>Network transaction fees</li>
              <li>Any other fees specified on our fee schedule</li>
            </ul>
            <p>
              Fee schedules are subject to change with notice. You are responsible for all taxes applicable to your trading activities.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">6. Risk Disclosure</h2>
            <p>
              Cryptocurrency trading involves significant risks, including:
            </p>
            <ul>
              <li>Price volatility and potential for complete loss of funds</li>
              <li>Technical risks related to blockchain networks</li>
              <li>Regulatory uncertainty and compliance requirements</li>
              <li>Cybersecurity risks</li>
              <li>Market manipulation risks</li>
            </ul>
            <p>
              You acknowledge these risks and agree that you trade at your own risk. We are not responsible for any losses incurred through trading.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">7. Prohibited Activities</h2>
            <p>You agree not to engage in any of the following activities:</p>
            <ul>
              <li>Violating any applicable laws or regulations</li>
              <li>Market manipulation or fraudulent trading</li>
              <li>Unauthorized access to our systems</li>
              <li>Interference with other users' access to the Services</li>
              <li>Distribution of malware or harmful code</li>
              <li>Money laundering or terrorist financing</li>
              <li>Trading with funds derived from illegal activities</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">8. Intellectual Property Rights</h2>
            <p>
              All content, features, and functionality of our Services, including but not limited to text, graphics, logos, and software, are owned by NadiaPoint and protected by intellectual property laws. You may not:
            </p>
            <ul>
              <li>Copy or reproduce any part of our Services</li>
              <li>Modify or create derivative works</li>
              <li>Distribute or publicly display content</li>
              <li>Reverse engineer or decompile our software</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">9. Service Availability and Modifications</h2>
            <p>
              We strive to maintain high availability of our Services but do not guarantee uninterrupted access. We reserve the right to:
            </p>
            <ul>
              <li>Modify or discontinue any part of our Services</li>
              <li>Implement system maintenance or upgrades</li>
              <li>Restrict access during emergencies or technical issues</li>
              <li>Add or remove features without notice</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">10. Limitation of Liability</h2>
            <p>
              To the maximum extent permitted by law, NadiaPoint and its affiliates shall not be liable for:
            </p>
            <ul>
              <li>Trading losses or missed opportunities</li>
              <li>System downtime or technical failures</li>
              <li>Loss of data or security breaches</li>
              <li>Actions of third parties</li>
              <li>Any indirect, consequential, or special damages</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">11. Termination</h2>
            <p>
              We may terminate or suspend your account and access to our Services:
            </p>
            <ul>
              <li>For violations of these Terms</li>
              <li>To comply with legal requirements</li>
              <li>Due to suspicious account activity</li>
              <li>At our discretion with reasonable notice</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">12. Governing Law</h2>
            <p>
              These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law provisions.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">13. Changes to Terms</h2>
            <p>
              We may modify these Terms at any time. We will notify you of material changes through our platform or via email. Your continued use of our Services after such modifications constitutes acceptance of the updated Terms.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">14. Contact Information</h2>
            <p>
              For questions about these Terms, please contact us at:
            </p>
            <ul>
              <li>Email: legal@nadiapoint.com</li>
              {/* <li>Address: [Your Company Address]</li> */}
            </ul>
          </section>
        </div>
      </div>
    </div>
  )
} 