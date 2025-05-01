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
            <h1 className="text-gradient max-w-2xl bg-gradient-to-r from-highlight-primary via-highlight-secondary to-highlight-primary bg-clip-text text-4xl font-bold leading-[1.15] text-transparent sm:text-5xl lg:text-6xl">
              Trade Crypto with
              <br />
              Confidence & Security
            </h1>
            
            <p className="max-w-lg text-lg leading-relaxed text-muted-foreground">
              Experience seamless cryptocurrency trading with advanced security features,
              P2P marketplace, and multi-currency support on NadiaPoint Exchange.
            </p>

            {/* CTA Buttons */}
            <div className="flex flex-wrap gap-4">
              <Link
                href="/download"
                className="group relative inline-flex items-center overflow-hidden rounded-full bg-gradient-to-r from-highlight-primary to-highlight-secondary px-8 py-4 font-medium text-dark-background transition-all hover:scale-105"
              >
                Download App
                <svg
                  className="ml-2 h-5 w-5 transition-transform duration-200 group-hover:translate-x-1"
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
                <div className="absolute inset-0 bg-white/20 transition-opacity duration-300 group-hover:opacity-0" />
              </Link>
            </div>

            {/* Trust Badges */}
            <div className="flex flex-wrap items-center gap-8">
              <div className="group flex items-center gap-3 transition-transform hover:scale-105">
                <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 p-2.5">
                  <svg
                    className="h-full w-full text-highlight-primary"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
                    />
                  </svg>
                </div>
                <div>
                  <span className="block font-semibold">Secure Trading</span>
                  <span className="text-sm text-muted-foreground">Bank-grade security</span>
                </div>
              </div>
              <div className="group flex items-center gap-3 transition-transform hover:scale-105">
                <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 p-2.5">
                  <svg
                    className="h-full w-full text-highlight-primary"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                </div>
                <div>
                  <span className="block font-semibold">24/7 Support</span>
                  <span className="text-sm text-muted-foreground">Always available</span>
                </div>
              </div>
              <div className="group flex items-center gap-3 transition-transform hover:scale-105">
                <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 p-2.5">
                  <svg
                    className="h-full w-full text-highlight-primary"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064"
                    />
                  </svg>
                </div>
                <div>
                  <span className="block font-semibold">Global Access</span>
                  <span className="text-sm text-muted-foreground">Trade anywhere</span>
                </div>
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
            <div className="relative h-[600px] w-[300px] drop-shadow-2xl">
              {/* Phone Frame */}
              <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                {/* Add subtle inner shadow */}
                <div className="absolute inset-0 rounded-[3rem] shadow-inner" />
                {/* Add subtle border */}
                <div className="absolute inset-0 rounded-[3rem] border border-white/10" />
              </div>
              
              {/* Phone Screen */}
              <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background shadow-lg">
                <div className="relative h-full w-full">
                  {/* Screen Glare Effect */}
                  <div className="absolute inset-0 bg-gradient-to-tr from-transparent via-white/5 to-transparent" />
                  <Image
                    src="/images/app-screenshoot.png"
                    alt="NadiaPoint Exchange App"
                    fill
                    className="object-cover"
                    priority
                  />
                </div>
              </div>

              {/* Reflection Effect */}
              <div className="absolute inset-2 rounded-[2.75rem] bg-gradient-to-b from-white/5 via-transparent to-white/10" />
              
              {/* Phone Details */}
              <div className="absolute left-1/2 top-4 h-6 w-20 -translate-x-1/2 rounded-full bg-dark-background/90">
                {/* Camera Dot */}
                <div className="absolute right-4 top-1/2 h-2.5 w-2.5 -translate-y-1/2 rounded-full bg-highlight-primary/50" />
              </div>
              <div className="absolute bottom-6 left-1/2 h-1 w-32 -translate-x-1/2 rounded-full bg-white/10" />

              {/* Decorative Elements */}
              <div className="absolute -right-6 -top-6 h-32 w-32 rounded-full bg-highlight-primary/20 blur-2xl" />
              <div className="absolute -bottom-8 -left-8 h-40 w-40 rounded-full bg-highlight-secondary/20 blur-3xl" />
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 