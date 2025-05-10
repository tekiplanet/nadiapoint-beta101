"use client"

import Link from "next/link"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faTwitter, faDiscord, faTelegram, faGithub } from "@fortawesome/free-brands-svg-icons"

const navigation = {
  product: [
    { name: "Exchange", href: "/exchange" },
    { name: "P2P Trading", href: "/p2p" },
    { name: "Markets", href: "/markets" },
    { name: "Wallet", href: "/wallet" },
  ],
  company: [
    { name: "About", href: "/about" },
    { name: "Careers", href: "/careers" },
    { name: "Blog", href: "/blog" },
    { name: "Press", href: "/press" },
  ],
  support: [
    { name: "Help Center", href: "/help" },
    { name: "Contact", href: "/contact" },
    { name: "App Releases", href: "/releases" },
    { name: "Status", href: "/status" },
  ],
  legal: [
    { name: "Privacy Policy", href: "/privacy" },
    { name: "Terms of Service", href: "/terms" },
    { name: "Cookie Policy", href: "/cookies" },
    { name: "Compliance", href: "/compliance" },
  ],
  social: [
    { name: "Twitter", href: "https://twitter.com", icon: faTwitter },
    { name: "Discord", href: "https://discord.gg", icon: faDiscord },
    { name: "Telegram", href: "https://t.me", icon: faTelegram },
    { name: "GitHub", href: "https://github.com", icon: faGithub },
  ],
}

export function Footer() {
  return (
    <footer className="border-t border-muted bg-background">
      <div className="container mx-auto px-6 py-12 lg:px-8">
        {/* Main Footer Content */}
        <div className="grid grid-cols-2 gap-8 lg:grid-cols-5">
          {/* Logo and Description */}
          <div className="col-span-2">
            <Link href="/" className="flex items-center space-x-2">
              <div className="relative h-8 w-8">
                <div className="absolute inset-0 rounded-full bg-gradient-to-r from-highlight-primary to-highlight-secondary opacity-20" />
                <div className="absolute inset-[2px] rounded-full bg-background" />
                <span className="relative flex h-full w-full items-center justify-center font-bold text-highlight-primary">
                  N
                </span>
              </div>
              <span className="text-xl font-bold">NadiaPoint</span>
            </Link>
            <p className="mt-4 max-w-md text-sm text-muted-foreground">
              A secure and user-friendly cryptocurrency exchange platform. Trade, invest, and manage your digital assets with confidence.
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
            <h3 className="text-sm font-semibold">Product</h3>
            <ul className="mt-4 space-y-3">
              {navigation.product.map((item) => (
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