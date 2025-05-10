"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faShieldHalved, 
  faHandshakeSimple, 
  faMoneyBillTransfer, 
  faGlobe,
  faUserCheck,
  faChartLine
} from "@fortawesome/free-solid-svg-icons"

const features = [
  {
    title: "Secure Escrow Service",
    description: "Our automated escrow system ensures your funds are protected throughout the trading process. Trades are only completed when both parties confirm.",
    icon: faShieldHalved,
    color: "from-green-500 to-emerald-700",
  },
  {
    title: "Multiple Payment Methods",
    description: "Choose from a wide range of payment options including bank transfers, mobile money, and digital wallets to suit your preferences.",
    icon: faMoneyBillTransfer,
    color: "from-blue-500 to-indigo-700",
  },
  {
    title: "Global Trading Community",
    description: "Connect with verified traders worldwide. Our platform supports multiple currencies and payment methods across different regions.",
    icon: faGlobe,
    color: "from-purple-500 to-violet-700",
  },
  {
    title: "Verified Traders",
    description: "Trade with confidence. All traders undergo strict verification processes, and you can view their reputation scores and trading history.",
    icon: faUserCheck,
    color: "from-red-500 to-rose-700",
  },
  {
    title: "Competitive Rates",
    description: "Get the best rates in the market. Our P2P platform allows traders to set their own prices, ensuring competitive rates for everyone.",
    icon: faChartLine,
    color: "from-yellow-500 to-amber-700",
  },
  {
    title: "Dispute Resolution",
    description: "Our dedicated support team is available 24/7 to help resolve any trading disputes and ensure a smooth trading experience.",
    icon: faHandshakeSimple,
    color: "from-orange-500 to-red-700",
  },
]

export function P2PTrading() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-secondary/10 to-transparent blur-3xl" />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        {/* Section Header */}
        <div className="mx-auto max-w-2xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-4 text-3xl font-bold sm:text-4xl lg:text-5xl">
              Peer-to-Peer Trading Platform
            </h2>
            <p className="text-lg text-muted-foreground">
              Trade cryptocurrencies directly with other users in a secure, flexible, and efficient way.
              Set your own prices and choose your preferred payment methods.
            </p>
          </motion.div>
        </div>

        {/* Features Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto mt-16 grid max-w-5xl gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {features.map((feature, index) => (
            <div
              key={feature.title}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-2xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              {/* Feature icon */}
              <div className={`mb-5 inline-flex rounded-xl bg-gradient-to-r ${feature.color} p-3 text-white shadow-lg`}>
                <FontAwesomeIcon icon={feature.icon} className="h-6 w-6" />
              </div>

              {/* Feature content */}
              <h3 className="mb-3 text-lg font-semibold">{feature.title}</h3>
              <p className="text-sm text-muted-foreground">{feature.description}</p>

              {/* Decorative elements */}
              <div className={`absolute -right-12 -top-12 h-24 w-24 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-2xl transition-all duration-300 group-hover:opacity-20`} />
              <div className="absolute -bottom-12 -left-12 h-24 w-24 rounded-full bg-gradient-to-br from-highlight-primary to-highlight-secondary opacity-10 blur-2xl transition-all duration-300 group-hover:opacity-20" />
            </div>
          ))}
        </motion.div>

        {/* Trading Process */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="mx-auto mt-24 max-w-3xl rounded-2xl bg-gradient-to-r from-gray-50/50 to-white/50 p-8 shadow-lg dark:from-gray-900/50 dark:to-gray-800/50"
        >
          <h3 className="mb-6 text-center text-2xl font-bold">How P2P Trading Works</h3>
          <div className="space-y-6">
            <div className="flex items-start space-x-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-highlight-primary text-sm font-bold text-white">
                1
              </div>
              <div>
                <h4 className="mb-1 font-semibold">Browse Offers</h4>
                <p className="text-sm text-muted-foreground">
                  Find the best offers matching your requirements. Filter by currency, payment method, and price.
                </p>
              </div>
            </div>

            <div className="flex items-start space-x-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-highlight-secondary text-sm font-bold text-white">
                2
              </div>
              <div>
                <h4 className="mb-1 font-semibold">Start Trade</h4>
                <p className="text-sm text-muted-foreground">
                  Select an offer and initiate the trade. The cryptocurrency is automatically locked in escrow.
                </p>
              </div>
            </div>

            <div className="flex items-start space-x-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-accent text-sm font-bold text-white">
                3
              </div>
              <div>
                <h4 className="mb-1 font-semibold">Make Payment</h4>
                <p className="text-sm text-muted-foreground">
                  Send payment using the agreed method. Mark the payment as completed once done.
                </p>
              </div>
            </div>

            <div className="flex items-start space-x-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-green-500 text-sm font-bold text-white">
                4
              </div>
              <div>
                <h4 className="mb-1 font-semibold">Receive Crypto</h4>
                <p className="text-sm text-muted-foreground">
                  Once payment is confirmed, the cryptocurrency is automatically released from escrow to your wallet.
                </p>
              </div>
            </div>
          </div>
        </motion.div>

        {/* CTA Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.6 }}
          className="mx-auto mt-16 text-center"
        >
        </motion.div>
      </div>
    </section>
  )
} 