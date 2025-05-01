"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"

const features = [
  {
    title: "Real-time Trading",
    description: "Execute trades instantly with real-time market data and price updates",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M13 10V3L4 14h7v7l9-11h-7z"
        />
      </svg>
    ),
  },
  {
    title: "Secure Wallet",
    description: "Store and manage your crypto assets with military-grade security",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
        />
      </svg>
    ),
  },
  {
    title: "Portfolio Tracking",
    description: "Monitor your investments and track performance in real-time",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"
        />
      </svg>
    ),
  },
  {
    title: "Instant Notifications",
    description: "Stay updated with price alerts and transaction notifications",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
        />
      </svg>
    ),
  },
]

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1,
    },
  },
}

const item = {
  hidden: { opacity: 0, x: -20 },
  show: { opacity: 1, x: 0 },
}

export function MobileShowcase() {
  return (
    <section className="relative overflow-hidden bg-dark-background py-24 sm:py-32">
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute left-1/2 top-0 h-[40rem] w-[80rem] -translate-x-1/2 bg-highlight-primary/10 blur-[128px]" />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="grid gap-12 lg:grid-cols-2 lg:gap-8">
          {/* Content */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="flex flex-col justify-center"
          >
            <h2 className="text-gradient mb-4 text-3xl font-bold sm:text-4xl lg:text-5xl">
              Trade Anywhere, Anytime
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Experience the power of NadiaPoint Exchange in your pocket. Our mobile app
              brings professional trading tools to your fingertips.
            </p>

            <motion.div
              variants={container}
              initial="hidden"
              whileInView="show"
              viewport={{ once: true }}
              className="grid gap-8 sm:grid-cols-2"
            >
              {features.map((feature, index) => (
                <motion.div key={index} variants={item} className="relative space-y-4">
                  <div className="inline-flex h-10 w-10 items-center justify-center rounded-lg bg-highlight-primary/10">
                    <div className="text-highlight-primary">{feature.icon}</div>
                  </div>

                  <div>
                    <h3 className="text-lg font-semibold">{feature.title}</h3>
                    <p className="mt-2 text-sm text-muted-foreground">
                      {feature.description}
                    </p>
                  </div>
                </motion.div>
              ))}
            </motion.div>

            {/* App Store Buttons */}
            <div className="mt-12 flex flex-wrap gap-4">
              <a
                href="#"
                className="inline-flex items-center space-x-4 rounded-xl bg-white px-6 py-3 transition-all hover:bg-white/90"
              >
                <svg className="h-8 w-8" viewBox="0 0 24 24" fill="black">
                  <path d="M17.05 20.28c-.98.954-2.054.954-3.097.954-1.043 0-2.147-.954-3.145-.954-1.043 0-2.147.954-3.145.954-1.043 0-2.117 0-3.097-.954-2.117-2.117-2.264-7.017 0-9.134.98-.954 2.735-1.542 3.778-.477.954.954 2.117.954 3.145.954 1.043 0 2.147-.954 3.145-.954.954 0 2.798.477 3.778 1.431.637.637 1.043 1.542 1.043 2.483-2.798 1.671-2.324 5.752.595 6.697zm-5.214-15.52c.98-1.19.98-2.735 0-3.925-.954.477-1.671 1.19-2.147 2.117-.477.954-.477 2.147 0 3.145 1.043-.477 1.76-1.19 2.147-2.117v.78z" />
                </svg>
                <div className="flex flex-col">
                  <span className="text-xs text-gray-600">Download on the</span>
                  <span className="text-sm font-semibold text-gray-900">
                    App Store
                  </span>
                </div>
              </a>

              <a
                href="#"
                className="inline-flex items-center space-x-4 rounded-xl bg-white px-6 py-3 transition-all hover:bg-white/90"
              >
                <svg className="h-8 w-8" viewBox="0 0 24 24" fill="black">
                  <path d="M3.609 1.814L13.792 12l-10.183 10.186L3.609 22.186 13.792 12 3.609 1.814zM14.209 1.814L24.392 12 14.209 22.186l10.183-10.186L14.209 1.814z" />
                </svg>
                <div className="flex flex-col">
                  <span className="text-xs text-gray-600">GET IT ON</span>
                  <span className="text-sm font-semibold text-gray-900">
                    Google Play
                  </span>
                </div>
              </a>
            </div>
          </motion.div>

          {/* Phone Mockups */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative mx-auto flex items-center justify-center lg:justify-end"
          >
            <div className="relative grid grid-cols-2 gap-6">
              {/* Phone 1 */}
              <div className="relative h-[600px] w-[280px] translate-y-12">
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl" />
                <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                  <div className="h-full w-full">
                    {/* TODO: Replace with actual app screenshot */}
                    <div className="h-full w-full bg-dark-secondary/50" />
                  </div>
                </div>
              </div>

              {/* Phone 2 */}
              <div className="relative h-[600px] w-[280px] -translate-y-12">
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-secondary/20 to-highlight-primary/20 backdrop-blur-xl" />
                <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                  <div className="h-full w-full">
                    {/* TODO: Replace with actual app screenshot */}
                    <div className="h-full w-full bg-dark-secondary/50" />
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 