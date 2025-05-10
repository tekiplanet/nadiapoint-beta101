"use client"

import { motion } from "@/lib/framer"

export function AboutCTA() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-secondary/10 to-transparent blur-3xl" />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="mx-auto max-w-2xl text-center"
        >
          <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
            Ready to Start Trading?
          </h2>
          <p className="mb-8 text-lg text-muted-foreground">
            Join thousands of traders who have already discovered the power of SafeJet Exchange.
            Start your crypto journey today.
          </p>
          
          <div className="flex flex-col items-center justify-center gap-4 sm:flex-row">
            <motion.a
              href="/download"
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
              className="inline-flex w-full items-center justify-center rounded-lg bg-gradient-to-r from-orange-500 to-amber-500 px-6 py-3 text-sm font-medium text-white shadow-lg transition-all duration-300 hover:shadow-xl sm:w-auto"
            >
              Download App
            </motion.a>
            <motion.a
              href="/contact"
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
              className="inline-flex w-full items-center justify-center rounded-lg border border-input bg-background px-6 py-3 text-sm font-medium transition-all duration-300 hover:bg-accent hover:text-accent-foreground sm:w-auto"
            >
              Contact Us
            </motion.a>
          </div>
        </motion.div>
      </div>
    </section>
  )
}