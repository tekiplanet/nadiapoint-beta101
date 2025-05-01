"use client"

import { useTheme } from "@/providers/theme-provider"
import { motion } from "@/lib/framer"
import Link from "next/link"
import Image from "next/image"

export function HeroSection() {
  const { theme } = useTheme()

  return (
    <section className={`relative min-h-screen w-full overflow-hidden ${
      theme === "dark" ? "gradient-dark" : "gradient-light"
    }`}>
      {/* Gradient Orbs */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute -left-[10%] top-[20%] h-[40rem] w-[40rem] rounded-full bg-highlight-primary/20 blur-[128px]" />
        <div className="absolute -right-[10%] top-[10%] h-[30rem] w-[30rem] rounded-full bg-highlight-secondary/20 blur-[128px]" />
      </div>

      {/* Content Container */}
      <div className="container relative mx-auto flex min-h-screen items-center px-6 py-32 lg:px-8">
        <div className="grid gap-12 lg:grid-cols-2 lg:gap-8">
          {/* Text Content */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="flex flex-col justify-center space-y-8"
          >
            <h1 className="text-gradient text-4xl font-bold leading-tight sm:text-5xl lg:text-6xl">
              Trade Crypto with
              <br />
              Confidence & Security
            </h1>
            
            <p className="max-w-lg text-lg text-muted-foreground">
              Experience seamless cryptocurrency trading with advanced security features,
              P2P marketplace, and multi-currency support on NadiaPoint Exchange.
            </p>

            {/* CTA Buttons */}
            <div className="flex flex-wrap gap-4">
              <Link
                href="/register"
                className="inline-flex items-center rounded-lg bg-highlight-primary px-6 py-3 font-semibold text-dark-background transition-all hover:bg-highlight-primary/90"
              >
                Get Started
                <svg
                  className="ml-2 h-5 w-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M13 7l5 5m0 0l-5 5m5-5H6"
                  />
                </svg>
              </Link>
              
              <Link
                href="/download"
                className="inline-flex items-center rounded-lg border border-highlight-primary bg-transparent px-6 py-3 font-semibold text-highlight-primary transition-all hover:bg-highlight-primary/10"
              >
                Download App
                <svg
                  className="ml-2 h-5 w-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
                  />
                </svg>
              </Link>
            </div>

            {/* Trust Badges */}
            <div className="flex flex-wrap items-center gap-6">
              <div className="flex items-center gap-2">
                <svg
                  className="h-5 w-5 text-status-success"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
                  />
                </svg>
                <span className="text-sm font-medium">Secure Trading</span>
              </div>
              <div className="flex items-center gap-2">
                <svg
                  className="h-5 w-5 text-status-success"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
                <span className="text-sm font-medium">24/7 Support</span>
              </div>
              <div className="flex items-center gap-2">
                <svg
                  className="h-5 w-5 text-status-success"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064"
                  />
                </svg>
                <span className="text-sm font-medium">Global Access</span>
              </div>
            </div>
          </motion.div>

          {/* App Preview */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative flex items-center justify-center lg:justify-end"
          >
            <div className="relative h-[600px] w-[300px]">
              <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl" />
              {/* TODO: Replace with actual app screenshot */}
              <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                <div className="h-full w-full">
                  {/* Placeholder for app screenshot */}
                  <div className="h-full w-full bg-dark-secondary/50" />
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 