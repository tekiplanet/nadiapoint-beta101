import { Metadata } from "next"

export const metadata: Metadata = {
  title: "Cookie Policy | NadiaPoint",
  description: "Learn about how NadiaPoint uses cookies and similar technologies to enhance your trading experience.",
}

export default function CookiePolicy() {
  return (
    <div className="container mx-auto px-6 py-24 lg:px-8">
      <div className="mx-auto max-w-3xl">
        <h1 className="mb-8 text-4xl font-bold">Cookie Policy</h1>
        <div className="prose prose-gray max-w-none dark:prose-invert">
          <p className="text-muted-foreground">
            Last updated: {new Date().toLocaleDateString()}
          </p>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">1. Introduction</h2>
            <p>
              This Cookie Policy explains how NadiaPoint ("we", "us", or "our") uses cookies and similar technologies to recognize you when you visit our cryptocurrency trading platform and associated services ("Services"). It explains what these technologies are and why we use them, as well as your rights to control our use of them.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">2. What Are Cookies?</h2>
            <p>
              Cookies are small data files that are placed on your computer or mobile device when you visit a website. They are widely used by website owners to make their websites work, or work more efficiently, as well as to provide reporting information. Cookies set by the website owner (in this case, NadiaPoint) are called "first-party cookies". Cookies set by parties other than the website owner are called "third-party cookies".
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">3. Types of Cookies We Use</h2>
            <h3 className="mt-4 text-xl font-medium">3.1 Essential Cookies</h3>
            <p>These cookies are necessary for the website to function and cannot be switched off. They include:</p>
            <ul>
              <li>Authentication cookies to identify logged-in users</li>
              <li>Security cookies for fraud prevention and platform protection</li>
              <li>Session cookies for maintaining trading functionality</li>
              <li>Load balancing cookies for optimal performance</li>
            </ul>

            <h3 className="mt-4 text-xl font-medium">3.2 Performance Cookies</h3>
            <p>These cookies allow us to monitor and improve website performance:</p>
            <ul>
              <li>Analytics cookies to understand user behavior</li>
              <li>Speed and performance monitoring cookies</li>
              <li>Error tracking cookies</li>
            </ul>

            <h3 className="mt-4 text-xl font-medium">3.3 Functionality Cookies</h3>
            <p>These cookies enable enhanced functionality and personalization:</p>
            <ul>
              <li>Language preference cookies</li>
              <li>Theme and display preferences</li>
              <li>Trading interface customizations</li>
              <li>Feature usage tracking</li>
            </ul>

            <h3 className="mt-4 text-xl font-medium">3.4 Marketing Cookies</h3>
            <p>These cookies help us deliver relevant content and marketing:</p>
            <ul>
              <li>Advertisement tracking cookies</li>
              <li>Social media integration cookies</li>
              <li>Referral tracking cookies</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">4. How We Use Cookies</h2>
            <p>We use cookies for the following purposes:</p>
            <ul>
              <li>To secure your trading account and transactions</li>
              <li>To remember your preferences and settings</li>
              <li>To provide real-time trading functionality</li>
              <li>To analyze platform performance and usage</li>
              <li>To detect and prevent fraud</li>
              <li>To improve our services and user experience</li>
              <li>To deliver relevant marketing content</li>
            </ul>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">5. Third-Party Cookies</h2>
            <p>
              We may use third-party services that employ cookies, including:
            </p>
            <ul>
              <li>Analytics providers (e.g., Google Analytics)</li>
              <li>Security and fraud prevention services</li>
              <li>Payment processors</li>
              <li>Marketing and advertising partners</li>
            </ul>
            <p>
              These third parties may use cookies to collect information about your online activities across different websites and services.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">6. Cookie Management</h2>
            <p>
              You can control and manage cookies in various ways:
            </p>
            <ul>
              <li>Browser Settings: You can modify your browser settings to block or delete cookies</li>
              <li>Platform Preferences: You can adjust cookie preferences through our platform settings</li>
              <li>Third-Party Tools: You can use various tools and add-ons to manage cookies</li>
            </ul>
            <p>
              Please note that blocking certain cookies may impact the functionality of our Services.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">7. Do Not Track</h2>
            <p>
              Some browsers have a "Do Not Track" feature that signals websites not to track your activities. We currently do not respond to Do Not Track signals, but you can control tracking through our cookie management options.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">8. Updates to This Policy</h2>
            <p>
              We may update this Cookie Policy from time to time to reflect changes in our practices or for operational, legal, or regulatory reasons. We will notify you of any material changes through our platform or via email.
            </p>
          </section>

          <section className="mt-8">
            <h2 className="text-2xl font-semibold">9. Contact Us</h2>
            <p>
              If you have questions about our use of cookies or this Cookie Policy, please contact us at:
            </p>
            <ul>
              <li>Email: privacy@nadiapoint.com</li>
            </ul>
          </section>
        </div>
      </div>
    </div>
  )
} 