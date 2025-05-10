"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faRocket,
  faShieldHalved,
  faGlobe,
  faArrowRight
} from "@fortawesome/free-solid-svg-icons"
import Link from "next/link"

const highlights = [
  {
    icon: faRocket,
    title: "Quick Setup",
    description: "Create an account and start trading in minutes",
    color: "from-blue-500 to-indigo-600"
  },
  {
    icon: faShieldHalved,
    title: "Secure Platform",
    description: "Bank-grade security with 95% cold storage",
    color: "from-emerald-500 to-green-600"
  },
  {
    icon: faGlobe,
    title: "Global Access",
    description: "Trade from anywhere with 24/7 market access",
    color: "from-purple-500 to-violet-600"
  }
]

export function FeaturesCTA() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background elements */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-secondary/10 to-transparent blur-3xl" />
        {/* Grid Pattern */}
        <div 
          className="absolute inset-0 bg-[radial-gradient(#80808020_1.5px,transparent_1.5px)] bg-[size:32px_32px]" 
          style={{ maskImage: 'radial-gradient(ellipse 80% 80% at 50% 50%, black 40%, transparent 100%)' }}
        />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto max-w-2xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
              Ready to Start Your<br />Trading Journey?
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Join thousands of traders who have already discovered the power of 
              SafeJet Exchange. Start trading with confidence today.
            </p>
          </motion.div>
        </div>

        {/* Highlights */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto mb-16 grid max-w-5xl gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {highlights.map((highlight, index) => (
            <motion.div
              key={highlight.title}
              initial={{ opacity: 0, scale: 0.95 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 text-center shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className={`mx-auto mb-4 inline-flex rounded-xl bg-gradient-to-br ${highlight.color} p-3 text-white shadow-lg`}>
                <FontAwesomeIcon icon={highlight.icon} className="h-6 w-6" />
              </div>
              <h3 className="mb-2 text-lg font-semibold">{highlight.title}</h3>
              <p className="text-sm text-muted-foreground">{highlight.description}</p>
              {/* Decorative element */}
              <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${highlight.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </motion.div>
          ))}
        </motion.div>

        {/* CTA Buttons */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="mx-auto flex max-w-md flex-col items-center gap-4 text-center"
        >
          <Link
            href="/register"
            className="group inline-flex w-full items-center justify-center gap-2 rounded-xl bg-gradient-to-r from-highlight-primary to-highlight-secondary px-8 py-4 text-lg font-semibold text-white shadow-lg transition-all duration-300 hover:scale-105 hover:shadow-xl"
          >
            Create Free Account
            <FontAwesomeIcon 
              icon={faArrowRight} 
              className="h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" 
            />
          </Link>
          <Link
            href="/login"
            className="inline-flex w-full items-center justify-center rounded-xl border border-gray-200 bg-white/50 px-8 py-4 text-lg font-semibold backdrop-blur-sm transition-all duration-300 hover:bg-white/80 dark:border-gray-800 dark:bg-gray-900/50 dark:hover:bg-gray-900/80"
          >
            Sign In
          </Link>
        </motion.div>

        {/* Trust Indicators */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.6 }}
          className="mx-auto mt-16 flex max-w-2xl flex-wrap items-center justify-center gap-8 text-center text-sm text-muted-foreground"
        >
          <div className="flex items-center gap-2">
            <div className="h-2 w-2 rounded-full bg-green-500" />
            24/7 Support
          </div>
          <div className="flex items-center gap-2">
            <div className="h-2 w-2 rounded-full bg-blue-500" />
            Regulated Exchange
          </div>
          <div className="flex items-center gap-2">
            <div className="h-2 w-2 rounded-full bg-purple-500" />
            Instant Deposits
          </div>
          <div className="flex items-center gap-2">
            <div className="h-2 w-2 rounded-full bg-orange-500" />
            Low Trading Fees
          </div>
        </motion.div>
      </div>
    </section>
  )
} 