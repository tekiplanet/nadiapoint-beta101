"use client"

import { motion } from "@/lib/framer"

const features = [
  {
    title: "P2P Trading",
    description: "Trade directly with other users using multiple payment methods and currencies",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"
        />
      </svg>
    ),
  },
  {
    title: "Secure Wallet",
    description: "Store your crypto assets securely with advanced encryption and multi-factor authentication",
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
    title: "Multi-Currency",
    description: "Support for multiple cryptocurrencies and fiat currencies worldwide",
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
    title: "Advanced KYC",
    description: "Quick and secure identity verification process for enhanced security",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
        />
      </svg>
    ),
  },
  {
    title: "Mobile App",
    description: "Trade on the go with our powerful mobile application",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"
        />
      </svg>
    ),
  },
  {
    title: "24/7 Support",
    description: "Round-the-clock customer support to assist you with any issues",
    icon: (
      <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"
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
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0 },
}

export function FeaturesGrid() {
  return (
    <section className="relative overflow-hidden py-24 sm:py-32">
      <div className="absolute inset-0 bg-grid-gray-100/[0.02] bg-[size:60px_60px]" />
      
      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-gradient mb-4 text-3xl font-bold sm:text-4xl">
            Advanced Trading Features
          </h2>
          <p className="text-muted-foreground">
            Experience the next generation of cryptocurrency trading with our
            comprehensive suite of features.
          </p>
        </div>

        <motion.div
          variants={container}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true }}
          className="mx-auto mt-16 max-w-7xl grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {features.map((feature, index) => (
            <motion.div
              key={index}
              variants={item}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 transition-all duration-300 hover:translate-y-[-2px] hover:shadow-2xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              {/* Gradient Overlay */}
              <div className="absolute inset-0 bg-gradient-to-br from-highlight-primary/5 via-highlight-secondary/5 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100 dark:from-highlight-primary/10 dark:via-highlight-secondary/10" />
              
              {/* Content */}
              <div className="relative space-y-4">
                <div className="inline-flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 dark:from-highlight-primary/20 dark:to-highlight-secondary/20">
                  <div className="text-highlight-primary transition-colors duration-300 group-hover:text-highlight-secondary">
                    {feature.icon}
                  </div>
                </div>

                <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                  {feature.title}
                </h3>
                
                <p className="text-gray-600 dark:text-gray-400">
                  {feature.description}
                </p>
              </div>

              {/* Border Gradient */}
              <div className="absolute inset-px rounded-2xl bg-gradient-to-br from-highlight-primary/10 to-highlight-secondary/10 opacity-0 transition-opacity duration-300 group-hover:opacity-100 dark:from-highlight-primary/20 dark:to-highlight-secondary/20" />

              {/* Hover Arrow */}
              <div className="absolute right-6 top-6 flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-r from-highlight-primary/10 to-highlight-secondary/10 opacity-0 transition-all duration-300 group-hover:opacity-100 dark:from-highlight-primary/20 dark:to-highlight-secondary/20">
                <svg
                  className="h-4 w-4 text-gray-900 transition-transform duration-300 group-hover:translate-x-0.5 dark:text-white"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M14 5l7 7m0 0l-7 7m7-7H3"
                  />
                </svg>
              </div>

              {/* Glow Effect */}
              <div className="absolute -right-10 -top-10 h-24 w-24 rounded-full bg-highlight-primary/5 blur-2xl transition-all duration-300 group-hover:bg-highlight-primary/10 dark:bg-highlight-primary/10 dark:group-hover:bg-highlight-primary/20" />
              <div className="absolute -bottom-10 -left-10 h-24 w-24 rounded-full bg-highlight-secondary/5 blur-2xl transition-all duration-300 group-hover:bg-highlight-secondary/10 dark:bg-highlight-secondary/10 dark:group-hover:bg-highlight-secondary/20" />
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 