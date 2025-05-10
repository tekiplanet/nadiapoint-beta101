"use client"

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import {
  faEnvelope,
  faHeadset,
  faClock,
} from "@fortawesome/free-solid-svg-icons"
import {
  faTwitter,
  faDiscord,
  faTelegram,
  faGithub,
} from "@fortawesome/free-brands-svg-icons"

const contactMethods = [
  {
    name: "Email Support",
    value: "support@nadiapoint.com",
    description: "For general inquiries and support",
    icon: faEnvelope,
    link: "mailto:support@nadiapoint.com",
  },
  {
    name: "Live Chat",
    value: "Available in Mobile App",
    description: "Get instant help through our mobile app",
    icon: faHeadset,
    link: "/release",
  },
]

const supportHours = [
  {
    region: "Global Support",
    hours: "24/7",
    response: "Within 24 hours",
    icon: faClock,
  },
]

const socialLinks = [
  {
    name: "Twitter",
    value: "@NadiaPoint",
    icon: faTwitter,
    link: "https://twitter.com",
    description: "Follow us for updates and announcements",
  },
  {
    name: "Discord",
    value: "NadiaPoint Community",
    icon: faDiscord,
    link: "https://discord.gg",
    description: "Join our community discussions",
  },
  {
    name: "Telegram",
    value: "NadiaPoint Official",
    icon: faTelegram,
    link: "https://t.me",
    description: "Get instant updates and support",
  },
  {
    name: "GitHub",
    value: "NadiaPoint",
    icon: faGithub,
    link: "https://github.com",
    description: "Follow our open-source projects",
  },
]

export function ContactInfo() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-24 sm:px-6 lg:px-8">
      {/* Header */}
      <div className="text-center">
        <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
          Get in Touch
        </h1>
        <p className="mt-6 text-lg leading-8 text-muted-foreground">
          We're here to help! Choose your preferred way to connect with us.
        </p>
      </div>

      {/* Contact Methods Grid */}
      <div className="mt-16 grid gap-8 md:grid-cols-2">
        {contactMethods.map((method) => (
          <a
            key={method.name}
            href={method.link}
            className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
          >
            <div className="mb-6 inline-flex rounded-xl bg-highlight-primary/10 p-3">
              <FontAwesomeIcon
                icon={method.icon}
                className="h-6 w-6 text-highlight-primary"
              />
            </div>
            <h3 className="mb-2 text-xl font-semibold">{method.name}</h3>
            <p className="mb-2 text-highlight-primary">{method.value}</p>
            <p className="text-sm text-muted-foreground">{method.description}</p>
          </a>
        ))}
      </div>

      {/* Support Hours */}
      <div className="mt-16">
        <h2 className="mb-8 text-center text-2xl font-semibold">
          Support Hours
        </h2>
        <div className="grid gap-8 md:grid-cols-1">
          {supportHours.map((hours) => (
            <div
              key={hours.region}
              className="rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 text-center shadow-lg dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className="mx-auto mb-6 inline-flex rounded-xl bg-highlight-primary/10 p-3">
                <FontAwesomeIcon
                  icon={hours.icon}
                  className="h-6 w-6 text-highlight-primary"
                />
              </div>
              <h3 className="mb-2 text-xl font-semibold">{hours.region}</h3>
              <p className="mb-2 text-highlight-primary">Hours: {hours.hours}</p>
              <p className="text-sm text-muted-foreground">
                Response Time: {hours.response}
              </p>
            </div>
          ))}
        </div>
      </div>

      {/* Social Links */}
      <div className="mt-16">
        <h2 className="mb-8 text-center text-2xl font-semibold">
          Connect With Us
        </h2>
        <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
          {socialLinks.map((social) => (
            <a
              key={social.name}
              href={social.link}
              target="_blank"
              rel="noopener noreferrer"
              className="group rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 text-center shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className="mx-auto mb-4 inline-flex rounded-xl bg-highlight-primary/10 p-3">
                <FontAwesomeIcon
                  icon={social.icon}
                  className="h-6 w-6 text-highlight-primary"
                />
              </div>
              <h3 className="mb-1 font-semibold">{social.name}</h3>
              <p className="mb-2 text-sm text-highlight-primary">
                {social.value}
              </p>
              <p className="text-xs text-muted-foreground">
                {social.description}
              </p>
            </a>
          ))}
        </div>
      </div>
    </div>
  )
} 