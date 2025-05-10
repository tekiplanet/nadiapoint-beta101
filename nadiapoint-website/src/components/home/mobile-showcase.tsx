"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faApple, faGooglePlay } from "@fortawesome/free-brands-svg-icons"

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
        <div className="absolute -right-[40%] bottom-0 h-[40rem] w-[80rem] rounded-full bg-highlight-secondary/10 blur-[128px]" />
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
                <motion.div
                  key={index}
                  variants={item}
                  className={`group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 transition-all duration-300 hover:translate-y-[-2px] hover:shadow-2xl dark:from-gray-900/90 dark:to-gray-800/90 border-l-4 ${
                    index === 0 ? "border-highlight-primary" : 
                    index === 1 ? "border-highlight-secondary" :
                    index === 2 ? "border-accent" :
                    "border-yellow-400"
                  }`}
                >
                  {/* Gradient Overlay */}
                  <div className="absolute inset-0 bg-gradient-to-br from-highlight-primary/5 via-highlight-secondary/5 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100 dark:from-highlight-primary/10 dark:via-highlight-secondary/10" />
                  
                  {/* Content */}
                  <div className="relative space-y-3">
                    <div className={`inline-flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br ${
                      index === 0 ? "from-highlight-primary/10 to-highlight-secondary/10 dark:from-highlight-primary/20" : 
                      index === 1 ? "from-highlight-secondary/10 to-highlight-primary/10 dark:from-highlight-secondary/20" :
                      index === 2 ? "from-accent/10 to-highlight-primary/10 dark:from-accent/20" :
                      "from-yellow-400/10 to-highlight-primary/10 dark:from-yellow-400/20"
                    } dark:to-highlight-secondary/20`}>
                      <div className={`${
                        index === 0 ? "text-highlight-primary" :
                        index === 1 ? "text-highlight-secondary" :
                        index === 2 ? "text-accent" :
                        "text-yellow-400"
                      } transition-colors duration-300 group-hover:text-highlight-secondary`}>
                        {feature.icon}
                      </div>
                    </div>

                    <div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                        {feature.title}
                      </h3>
                      <p className="mt-2 text-sm text-gray-600 dark:text-gray-400">
                        {feature.description}
                      </p>
                    </div>
                  </div>

                  {/* Glow Effect */}
                  <div className={`absolute -right-10 -top-10 h-24 w-24 rounded-full ${
                    index === 0 ? "bg-highlight-primary/5" :
                    index === 1 ? "bg-highlight-secondary/5" :
                    index === 2 ? "bg-accent/5" :
                    "bg-yellow-400/5"
                  } blur-2xl transition-all duration-300 group-hover:bg-highlight-primary/10 dark:bg-highlight-primary/10 dark:group-hover:bg-highlight-primary/20`} />
                  <div className={`absolute -bottom-10 -left-10 h-24 w-24 rounded-full ${
                    index === 0 ? "bg-highlight-secondary/5" :
                    index === 1 ? "bg-highlight-primary/5" :
                    index === 2 ? "bg-highlight-primary/5" :
                    "bg-highlight-secondary/5"
                  } blur-2xl transition-all duration-300 group-hover:bg-highlight-secondary/10 dark:bg-highlight-secondary/10 dark:group-hover:bg-highlight-secondary/20`} />
                </motion.div>
              ))}
            </motion.div>

            {/* App Store Buttons */}
            <div className="mt-12 flex flex-wrap gap-4">
              <a
                href="#"
                className="flex items-center gap-4 rounded-xl bg-gray-900 px-6 py-3 transition-all duration-300 hover:bg-gray-800 dark:bg-gray-800 dark:hover:bg-gray-700"
              >
                <FontAwesomeIcon icon={faApple} className="h-8 w-8 text-white" />
                <div className="flex flex-col">
                  <span className="text-xs text-gray-300">Download on the</span>
                  <span className="text-sm font-semibold text-white">App Store</span>
                </div>
              </a>

              <a
                href="#"
                className="flex items-center gap-4 rounded-xl bg-gray-900 px-6 py-3 transition-all duration-300 hover:bg-gray-800 dark:bg-gray-800 dark:hover:bg-gray-700"
              >
                <FontAwesomeIcon icon={faGooglePlay} className="h-8 w-8 text-white" />
                <div className="flex flex-col">
                  <span className="text-xs text-gray-300">GET IT ON</span>
                  <span className="text-sm font-semibold text-white">Google Play</span>
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
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                  {/* Inner glow */}
                  <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-t from-highlight-primary/20 to-transparent opacity-50" />
                </div>
                <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                  <div className="h-full w-full">
                    {/* TODO: Replace with actual app screenshot */}
                    <div className="h-full w-full bg-dark-secondary/50" />
                  </div>
                </div>
                {/* Phone Details */}
                <div className="absolute left-1/2 top-4 h-6 w-20 -translate-x-1/2 rounded-full bg-dark-background/90">
                  <div className="absolute right-4 top-1/2 h-2.5 w-2.5 -translate-y-1/2 rounded-full bg-highlight-primary/50" />
                </div>
                <div className="absolute bottom-6 left-1/2 h-1 w-32 -translate-x-1/2 rounded-full bg-white/10" />
              </div>

              {/* Phone 2 */}
              <div className="relative h-[600px] w-[280px] -translate-y-12">
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-secondary/20 to-highlight-primary/20 backdrop-blur-xl">
                  {/* Inner glow */}
                  <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-b from-highlight-secondary/20 to-transparent opacity-50" />
                </div>
                <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                  <div className="h-full w-full">
                    {/* TODO: Replace with actual app screenshot */}
                    <div className="h-full w-full bg-dark-secondary/50" />
                  </div>
                </div>
                {/* Phone Details */}
                <div className="absolute left-1/2 top-4 h-6 w-20 -translate-x-1/2 rounded-full bg-dark-background/90">
                  <div className="absolute right-4 top-1/2 h-2.5 w-2.5 -translate-y-1/2 rounded-full bg-highlight-secondary/50" />
                </div>
                <div className="absolute bottom-6 left-1/2 h-1 w-32 -translate-x-1/2 rounded-full bg-white/10" />
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 