import { Metadata } from "next"

export const metadata: Metadata = {
  title: "Security | NadiaPoint",
  description: "Learn about NadiaPoint's robust security measures to protect your cryptocurrency assets and personal information.",
}

export default function Security() {
  return (
    <div className="container mx-auto px-6 py-24 lg:px-8">
      <div className="mx-auto max-w-3xl">
        <h1 className="mb-8 text-4xl font-bold">Security</h1>
        <div className="prose prose-gray max-w-none dark:prose-invert">
          <p className="text-muted-foreground">
            Last updated: {new Date().toLocaleDateString()}
          </p>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">1. Our Security Commitment</h2>
            <p>
              At NadiaPoint, security is our top priority. We employ industry-leading security measures and best practices to protect your cryptocurrency assets, personal information, and trading activities. Our multi-layered security approach ensures the safety and integrity of our platform.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">2. Asset Security</h2>
            <h3 className="mt-4 text-xl font-medium">2.1 Cold Storage</h3>
            <p>
              The majority of user assets are stored in secure offline cold storage:
            </p>
            <ul>
              <li>Multi-signature technology for all cold wallet transactions</li>
              <li>Geographically distributed storage locations</li>
              <li>Regular security audits and penetration testing</li>
              <li>Insurance coverage for digital assets</li>
            </ul>

            <h3 className="mt-4 text-xl font-medium">2.2 Hot Wallet Security</h3>
            <p>For immediate withdrawals, we maintain a small portion of assets in secure hot wallets with:</p>
            <ul>
              <li>Advanced encryption protocols</li>
              <li>Real-time monitoring systems</li>
              <li>Automated threat detection</li>
              <li>Multi-layer approval process</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">3. Account Security Features</h2>
            <p>We provide multiple security features to protect your account:</p>
            <ul>
              <li>Two-Factor Authentication (2FA)</li>
              <li>Anti-phishing codes</li>
              <li>Advanced login protection</li>
              <li>IP address whitelisting</li>
              <li>Withdrawal address management</li>
              <li>Email and SMS notifications</li>
              <li>Device management</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">4. Platform Security</h2>
            <p>Our trading platform is secured through:</p>
            <ul>
              <li>DDoS protection and mitigation</li>
              <li>SSL/TLS encryption for all data transmission</li>
              <li>Regular security assessments and updates</li>
              <li>24/7 system monitoring</li>
              <li>Automated backup systems</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">5. Data Protection</h2>
            <p>We protect your personal information with:</p>
            <ul>
              <li>End-to-end encryption for sensitive data</li>
              <li>Secure data storage with encryption at rest</li>
              <li>Regular security audits</li>
              <li>Strict access controls</li>
              <li>Employee security training</li>
              <li>Compliance with data protection regulations</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">6. Security Best Practices</h2>
            <p>We recommend following these security practices:</p>
            <ul>
              <li>Enable 2FA on your account</li>
              <li>Use a strong, unique password</li>
              <li>Regularly review your account activity</li>
              <li>Verify withdrawal addresses carefully</li>
              <li>Be cautious of phishing attempts</li>
              <li>Keep your recovery codes safe</li>
              <li>Use secure internet connections</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">7. Incident Response</h2>
            <p>Our security team is prepared to handle any security incidents:</p>
            <ul>
              <li>24/7 security monitoring</li>
              <li>Rapid incident response team</li>
              <li>Regular disaster recovery drills</li>
              <li>Comprehensive incident response plan</li>
              <li>Clear communication protocols</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">8. Compliance and Audits</h2>
            <p>
              We maintain the highest security standards through:
            </p>
            <ul>
              <li>Regular third-party security audits</li>
              <li>Compliance with international security standards</li>
              <li>Ongoing vulnerability assessments</li>
              <li>Partnership with security experts</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">9. Reporting Security Issues</h2>
            <p>
              If you discover a security vulnerability or have concerns, please contact our security team immediately:
            </p>
            <ul>
              <li>Email: security@nadiapoint.com</li>
              <li>Bug Bounty Program: [Link to program]</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">10. Updates and Notifications</h2>
            <p>
              We continuously update our security measures and will notify you of:
            </p>
            <ul>
              <li>Security feature updates</li>
              <li>System maintenance</li>
              <li>Security advisories</li>
              <li>Best practice recommendations</li>
            </ul>
          </section>
        </div>
      </div>
    </div>
  )
} 