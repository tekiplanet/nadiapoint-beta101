"use client"

import { motion, useInView } from "@/lib/framer"
import { useEffect, useRef, useState } from "react"

const stats = [
  {
    value: 5,
    suffix: "B+",
    label: "Trading Volume",
    sublabel: "Monthly volume in USD",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
        />
      </svg>
    ),
  },
  {
    value: 2,
    suffix: "M+",
    label: "Active Users",
    sublabel: "Trusted by millions",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"
        />
      </svg>
    ),
  },
  {
    value: 50,
    suffix: "+",
    label: "Cryptocurrencies",
    sublabel: "Major coins supported",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
        />
      </svg>
    ),
  },
  {
    value: 100,
    suffix: "+",
    label: "Countries",
    sublabel: "Global presence",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064"
        />
      </svg>
    ),
  },
]

function AnimatedCounter({ value, suffix = "" }: { value: number; suffix?: string }) {
  const [count, setCount] = useState(0)
  const ref = useRef(null)
  const isInView = useInView(ref, { once: true })

  useEffect(() => {
    if (isInView) {
      const duration = 2000
      const steps = 60
      const stepDuration = duration / steps
      let currentStep = 0

      const timer = setInterval(() => {
        currentStep += 1
        const progress = currentStep / steps
        const easedProgress = 1 - Math.pow(1 - progress, 3) // Cubic ease-out
        setCount(Math.floor(value * easedProgress))

        if (currentStep >= steps) {
          clearInterval(timer)
          setCount(value)
        }
      }, stepDuration)

      return () => clearInterval(timer)
    }
  }, [isInView, value])

  return (
    <span ref={ref} className="block text-4xl font-bold text-highlight-primary transition-colors duration-300 group-hover:text-highlight-secondary sm:text-5xl">
      {count}
      {suffix}
    </span>
  )
}

export function TradingStats() {
  return (
    <section className="relative overflow-hidden py-24 sm:py-32">
      {/* Background grid pattern */}
      <div className="absolute inset-0 bg-grid-gray-100/[0.02] bg-[size:60px_60px]" />
      
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute -left-[40%] top-0 h-[40rem] w-[80rem] rounded-full bg-highlight-primary/10 blur-[128px]" />
        <div className="absolute -right-[40%] bottom-0 h-[40rem] w-[80rem] rounded-full bg-highlight-secondary/10 blur-[128px]" />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto max-w-2xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-4 text-3xl font-bold sm:text-4xl">
              Leading the Future of Trading
            </h2>
            <p className="text-muted-foreground">
              Join millions of traders worldwide who trust NadiaPoint Exchange
              for their cryptocurrency trading needs.
            </p>
          </motion.div>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto mt-16 grid max-w-7xl grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4"
        >
          {stats.map((stat, index) => (
            <div
              key={index}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 transition-all duration-300 hover:translate-y-[-2px] hover:shadow-2xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              {/* Gradient Overlay */}
              <div className="absolute inset-0 bg-gradient-to-br from-highlight-primary/5 via-highlight-secondary/5 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100 dark:from-highlight-primary/10 dark:via-highlight-secondary/10" />
              
              {/* Content */}
              <div className="relative space-y-4">
                <div className="inline-flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 dark:from-highlight-primary/20 dark:to-highlight-secondary/20">
                  <div className="text-highlight-primary transition-colors duration-300 group-hover:text-highlight-secondary">
                    {stat.icon}
                  </div>
                </div>

                <div className="space-y-2">
                  <AnimatedCounter 
                    value={stat.value} 
                    suffix={stat.suffix} 
                  />
                  
                  <div>
                    <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                      {stat.label}
                    </h3>
                    <p className="mt-1 text-sm text-gray-600 dark:text-gray-400">
                      {stat.sublabel}
                    </p>
                  </div>
                </div>
              </div>

              {/* Border Gradient */}
              <div className="absolute inset-px rounded-2xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 opacity-0 transition-opacity duration-300 group-hover:opacity-100 dark:from-highlight-primary/20 dark:to-highlight-secondary/20" />

              {/* Glow Effect */}
              <div className="absolute -right-10 -top-10 h-24 w-24 rounded-full bg-highlight-primary/5 blur-2xl transition-all duration-300 group-hover:bg-highlight-primary/10 dark:bg-highlight-primary/10 dark:group-hover:bg-highlight-primary/20" />
              <div className="absolute -bottom-10 -left-10 h-24 w-24 rounded-full bg-highlight-secondary/5 blur-2xl transition-all duration-300 group-hover:bg-highlight-secondary/10 dark:bg-highlight-secondary/10 dark:group-hover:bg-highlight-secondary/20" />
            </div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 