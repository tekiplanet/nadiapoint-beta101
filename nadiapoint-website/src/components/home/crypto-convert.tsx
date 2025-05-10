"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faArrowRightArrowLeft,
  faGaugeHigh,
  faCoins,
  faShieldHalved
} from "@fortawesome/free-solid-svg-icons"

const features = [
  {
    title: "Instant Conversion",
    description: "Convert between cryptocurrencies instantly with real-time market rates and minimal slippage.",
    icon: faArrowRightArrowLeft,
    color: "from-blue-500 to-indigo-700",
  },
  {
    title: "Best Market Rates",
    description: "Get the most competitive rates in the market with our advanced price aggregation system.",
    icon: faGaugeHigh,
    color: "from-green-500 to-emerald-700",
  },
  {
    title: "Wide Range of Coins",
    description: "Support for hundreds of cryptocurrencies, from major coins to emerging tokens.",
    icon: faCoins,
    color: "from-purple-500 to-violet-700",
  },
  {
    title: "Secure Transactions",
    description: "Every conversion is protected by our advanced security protocols and real-time monitoring.",
    icon: faShieldHalved,
    color: "from-red-500 to-rose-700",
  },
]

export function CryptoConvert() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-secondary/10 to-transparent blur-3xl" />
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
              Seamless Crypto Conversion
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Convert between cryptocurrencies with ease. Our platform offers instant conversions at the best market rates, with no hidden fees.
            </p>

            {/* Features Grid */}
            <div className="grid gap-6 sm:grid-cols-2">
              {features.map((feature) => (
                <div
                  key={feature.title}
                  className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
                >
                  {/* Feature icon */}
                  <div className={`mb-4 inline-flex rounded-xl bg-gradient-to-r ${feature.color} p-3 text-white shadow-lg`}>
                    <FontAwesomeIcon icon={feature.icon} className="h-5 w-5" />
                  </div>

                  {/* Feature content */}
                  <h3 className="mb-2 text-base font-semibold">{feature.title}</h3>
                  <p className="text-sm text-muted-foreground">{feature.description}</p>

                  {/* Decorative elements */}
                  <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
                </div>
              ))}
            </div>

            {/* CTA Button */}
            <div className="mt-12">
              <a
                href="/convert"
                className="inline-flex items-center space-x-2 rounded-xl bg-highlight-primary px-6 py-3 text-sm font-medium text-white transition-all hover:bg-highlight-primary/90"
              >
                <span>Try Instant Convert</span>
                <svg
                  className="h-4 w-4"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M9 5l7 7-7 7"
                  />
                </svg>
              </a>
            </div>
          </motion.div>

          {/* Screenshot */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative mx-auto flex items-center justify-center lg:justify-end"
          >
            {/* Phone Mockup */}
            <div className="relative h-[600px] w-[280px]">
              <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                {/* Inner glow */}
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-t from-highlight-primary/20 to-transparent opacity-50" />
              </div>
              <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                <Image
                  src="/images/convert-crypto.png"
                  alt="Crypto conversion interface"
                  fill
                  className="object-cover object-top"
                  priority
                />
              </div>
              {/* Phone Details */}
              <div className="absolute left-1/2 top-4 h-6 w-20 -translate-x-1/2 rounded-full bg-dark-background/90">
                <div className="absolute right-4 top-1/2 h-2.5 w-2.5 -translate-y-1/2 rounded-full bg-highlight-primary/50" />
              </div>
              <div className="absolute bottom-6 left-1/2 h-1 w-32 -translate-x-1/2 rounded-full bg-white/10" />
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 