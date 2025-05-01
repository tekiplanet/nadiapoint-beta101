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
      const duration = 2000 // Animation duration in milliseconds
      const steps = 60 // Number of steps to reach the target value
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
    <span ref={ref} className="text-4xl font-bold sm:text-5xl">
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
              className="card-dark group relative overflow-hidden rounded-2xl p-8 transition-all hover:bg-dark-accent/5"
            >
              {/* Gradient border */}
              <div className="absolute inset-0 rounded-2xl bg-gradient-to-r from-highlight-primary/10 to-highlight-secondary/10 transition-all group-hover:opacity-100" />
              
              {/* Content */}
              <div className="relative space-y-4">
                <div className="inline-flex h-12 w-12 items-center justify-center rounded-xl bg-highlight-primary/10">
                  <div className="text-highlight-primary">{stat.icon}</div>
                </div>

                <AnimatedCounter value={stat.value} suffix={stat.suffix} />
                
                <div>
                  <h3 className="text-xl font-semibold">{stat.label}</h3>
                  <p className="mt-1 text-sm text-muted-foreground">{stat.sublabel}</p>
                </div>
              </div>
            </div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 