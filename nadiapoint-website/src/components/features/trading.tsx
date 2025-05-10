"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faChartLine,
  faArrowTrendUp,
  faBell,
  faGears,
  faChartPie,
  faArrowsLeftRight
} from "@fortawesome/free-solid-svg-icons"
import Image from "next/image"

const tradingFeatures = [
  {
    icon: faChartLine,
    title: "Advanced Charts",
    description: "Professional TradingView charts with multiple timeframes and indicators",
    color: "from-blue-500 to-indigo-600",
    borderColor: "border-l-blue-500"
  },
  {
    icon: faArrowTrendUp,
    title: "Market Analysis",
    description: "Real-time market data, depth charts, and order book visualization",
    color: "from-purple-500 to-violet-600",
    borderColor: "border-l-purple-500"
  },
  {
    icon: faBell,
    title: "Price Alerts",
    description: "Customizable price alerts and notifications for market movements",
    color: "from-emerald-500 to-green-600",
    borderColor: "border-l-emerald-500"
  },
  {
    icon: faGears,
    title: "Order Types",
    description: "Multiple order types including limit, market, and stop orders",
    color: "from-orange-500 to-amber-600",
    borderColor: "border-l-orange-500"
  },
  {
    icon: faChartPie,
    title: "Portfolio Tracking",
    description: "Real-time portfolio monitoring with P&L tracking",
    color: "from-pink-500 to-rose-600",
    borderColor: "border-l-pink-500"
  },
  {
    icon: faArrowsLeftRight,
    title: "Quick Swap",
    description: "Instant cryptocurrency swaps at the best market rates",
    color: "from-cyan-500 to-teal-600",
    borderColor: "border-l-cyan-500"
  }
]

export function TradingFeatures() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background elements */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-secondary/10 to-transparent blur-3xl" />
        {/* Grid Pattern */}
        <div 
          className="absolute inset-0 bg-[linear-gradient(to_right,#80808020_1px,transparent_1px),linear-gradient(to_bottom,#80808020_1px,transparent_1px)] bg-[size:24px_24px]" 
          style={{ maskImage: 'linear-gradient(to bottom, transparent, black 10%, black 90%, transparent)' }}
        />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto grid max-w-7xl gap-16 lg:grid-cols-2">
          {/* Left Column - Content */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="flex flex-col justify-center"
          >
            <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
              Professional Trading<br />Tools & Features
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Experience professional-grade trading tools and features designed to give you 
              the edge in cryptocurrency markets. From advanced charting to instant executions, 
              we've got everything you need.
            </p>

            {/* Features Grid */}
            <div className="grid gap-6">
              {tradingFeatures.map((feature, index) => (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className={`flex items-start gap-4 rounded-lg border-l-4 bg-gradient-to-r from-gray-50/50 to-transparent p-4 dark:from-gray-900/50 ${feature.borderColor}`}
                >
                  <div className={`rounded-lg bg-gradient-to-br ${feature.color} p-3 text-white shadow-lg`}>
                    <FontAwesomeIcon icon={feature.icon} className="h-5 w-5" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold">{feature.title}</h3>
                    <p className="text-sm text-muted-foreground">{feature.description}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </motion.div>

          {/* Right Column - Trading Interface Preview */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative flex items-center justify-center lg:justify-end"
          >
            <div className="relative aspect-[4/3] w-full max-w-2xl overflow-hidden rounded-2xl bg-gradient-to-br from-gray-900 to-gray-800 p-2 shadow-2xl">
              <Image
                src="/images/wallet-page.png"
                alt="SafeJet Exchange Trading Interface"
                fill
                className="rounded-xl object-cover"
                priority
              />
              {/* Overlay gradient */}
              <div className="absolute inset-0 rounded-xl bg-gradient-to-t from-gray-900/20 to-transparent" />
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 