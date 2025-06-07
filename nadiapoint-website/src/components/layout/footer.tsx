"use client"

import Link from "next/link"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faTwitter, faDiscord, faTelegram, faGithub } from "@fortawesome/free-brands-svg-icons"
import { Smartsupp } from "@/components/smartsupp"
import Image from "next/image"
import { useTheme } from "@/providers/theme-provider"

const navigation = {
  features: [
    { name: "Instant Convert", href: "/features#convert" },
    { name: "P2P Trading", href: "/features#p2p" },
    { name: "Secure Wallet", href: "/features#wallet" },
    { name: "Portfolio Tracking", href: "/features#portfolio" },
  ],
  company: [
    { name: "About", href: "/about" },
    { name: "Contact", href: "/contact" },
  ],
  support: [
    { name: "Help Center", href: "/help" },
    { name: "FAQs", href: "/help" },
    { name: "App Releases", href: "/release" },
  ],
  legal: [
    { name: "Privacy Policy", href: "/privacy" },
    { name: "Terms of Service", href: "/terms" },
    { name: "Cookie Policy", href: "/cookies" },
    { name: "Security", href: "/security" },
  ],
  social: [
    { name: "Twitter", href: "https://twitter.com", icon: faTwitter },
    { name: "Discord", href: "https://discord.gg", icon: faDiscord },
    { name: "Telegram", href: "https://t.me", icon: faTelegram },
    { name: "GitHub", href: "https://github.com", icon: faGithub },
  ],
}

export function Footer() {
  const { theme } = useTheme();
  return (
    <footer className="border-t border-muted bg-background">
      <Smartsupp />
      <div className="container mx-auto px-6 py-12 lg:px-8">
        {/* Main Footer Content */}
        <div className="grid grid-cols-2 gap-8 lg:grid-cols-5">
          {/* Logo and Description */}
          <div className="col-span-2">
            <Link href="/" className="flex items-center">
              <Image
                src={theme === "dark" ? "/logo/logo-2c.png" : "/logo/logo-2b.png"}
                alt="NadiaPoint Logo"
                width={160}
                height={40}
                priority
                className="h-8 max-w-[120px] sm:h-10 sm:max-w-[160px] w-auto object-contain"
              />
            </Link>
            <p className="mt-4 max-w-md text-sm text-muted-foreground">
              Download our mobile app and experience the future of cryptocurrency trading. Fast, secure, and user-friendly crypto trading at your fingertips.
            </p>
            {/* Social Links */}
            <div className="mt-6 flex space-x-6">
              {navigation.social.map((item) => (
                <a
                  key={item.name}
                  href={item.href}
                  className="text-muted-foreground transition-colors hover:text-foreground"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <span className="sr-only">{item.name}</span>
                  <FontAwesomeIcon icon={item.icon} className="h-5 w-5" />
                </a>
              ))}
            </div>
          </div>

          {/* Navigation Links */}
          <div>
            <h3 className="text-sm font-semibold">Features</h3>
            <ul className="mt-4 space-y-3">
              {navigation.features.map((item) => (
                <li key={item.name}>
                  <Link
                    href={item.href}
                    className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                  >
                    {item.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h3 className="text-sm font-semibold">Company</h3>
            <ul className="mt-4 space-y-3">
              {navigation.company.map((item) => (
                <li key={item.name}>
                  <Link
                    href={item.href}
                    className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                  >
                    {item.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h3 className="text-sm font-semibold">Support</h3>
            <ul className="mt-4 space-y-3">
              {navigation.support.map((item) => (
                <li key={item.name}>
                  <Link
                    href={item.href}
                    className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                  >
                    {item.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="mt-12 border-t border-muted pt-8">
          <div className="flex flex-col items-center justify-between space-y-4 md:flex-row md:space-y-0">
            <div className="flex space-x-6">
              {navigation.legal.map((item) => (
                <Link
                  key={item.name}
                  href={item.href}
                  className="text-xs text-muted-foreground transition-colors hover:text-foreground"
                >
                  {item.name}
                </Link>
              ))}
            </div>
            <p className="text-xs text-muted-foreground">
              © {new Date().getFullYear()} NadiaPoint. All rights reserved.
            </p>
          </div>
        </div>
      </div>
    </footer>
  )
} 