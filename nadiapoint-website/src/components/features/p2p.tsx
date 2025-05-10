"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faShieldHalved, 
  faHandshakeSimple, 
  faMoneyBillTransfer, 
  faGlobe,
  faUserCheck,
  faChartLine
} from "@fortawesome/free-solid-svg-icons"
import Image from "next/image"

const p2pFeatures = [
  {
    icon: faShieldHalved,
    title: "Secure Escrow",
    description: "Automated escrow system protects both buyers and sellers throughout the trading process",
    color: "from-emerald-500 to-green-600",
    stat: "100%"
  },
  {
    icon: faMoneyBillTransfer,
    title: "Payment Options",
    description: "Wide range of payment methods including bank transfers, mobile money, and digital wallets",
    color: "from-blue-500 to-indigo-600",
    stat: "50+"
  },
  {
    icon: faGlobe,
    title: "Global Trading",
    description: "Connect with verified traders worldwide with multi-currency support",
    color: "from-purple-500 to-violet-600",
    stat: "180+"
  },
  {
    icon: faUserCheck,
    title: "Verified Traders",
    description: "Trade with confidence through our strict verification process and reputation system",
    color: "from-orange-500 to-amber-600",
    stat: "KYC"
  },
  {
    icon: faChartLine,
    title: "Market Rates",
    description: "Competitive rates with real-time market price tracking and alerts",
    color: "from-pink-500 to-rose-600",
    stat: "24/7"
  },
  {
    icon: faHandshakeSimple,
    title: "Support Team",
    description: "Dedicated support team available 24/7 for dispute resolution and assistance",
    color: "from-cyan-500 to-teal-600",
    stat: "1hr"
  }
]

const tradingSteps = [
  {
    number: 1,
    title: "Browse Offers",
    description: "Find the best offers matching your requirements. Filter by currency, payment method, and price.",
    color: "bg-highlight-primary"
  },
  {
    number: 2,
    title: "Start Trade",
    description: "Select an offer and initiate the trade. The cryptocurrency is automatically locked in escrow.",
    color: "bg-highlight-secondary"
  },
  {
    number: 3,
    title: "Make Payment",
    description: "Send payment using the agreed method and mark the payment as completed once done.",
    color: "bg-accent"
  },
  {
    number: 4,
    title: "Receive Crypto",
    description: "Once payment is confirmed, the cryptocurrency is automatically released to your wallet.",
    color: "bg-green-500"
  }
]

export function P2PFeatures() {
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
              Peer-to-Peer Trading<br />Made Simple & Secure
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Trade cryptocurrencies directly with other users in a secure, flexible, and 
              efficient way. Set your own prices and choose your preferred payment methods.
            </p>

            {/* Features Grid */}
            <div className="grid gap-6">
              {p2pFeatures.map((feature, index) => (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
                >
                  <div className="mb-4 flex items-start justify-between">
                    <div className={`rounded-xl bg-gradient-to-br ${feature.color} p-3 text-white shadow-lg`}>
                      <FontAwesomeIcon icon={feature.icon} className="h-5 w-5" />
                    </div>
                    <div className={`rounded-xl bg-gradient-to-br ${feature.color} px-3 py-1 text-sm font-semibold text-white`}>
                      {feature.stat}
                    </div>
                  </div>
                  <h3 className="mb-2 text-base font-semibold">{feature.title}</h3>
                  <p className="text-sm text-muted-foreground">{feature.description}</p>
                  {/* Decorative element */}
                  <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
                </motion.div>
              ))}
            </div>
          </motion.div>

          {/* Right Column - Trading Process */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative flex items-center justify-center lg:justify-end"
          >
            <div className="w-full max-w-xl">
              {/* Interface Preview */}
              <div className="relative mb-12 w-[300px] mx-auto">
                <div className="relative h-[600px] w-full">
                  <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                    <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-t from-highlight-primary/20 to-transparent opacity-50" />
                  </div>
                  <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                    <Image
                      src="/images/p2p.png"
                      alt="SafeJet Exchange P2P Trading Interface"
                      fill
                      className="object-cover"
                      priority
                    />
                  </div>
                  {/* Phone Details */}
                  <div className="absolute left-1/2 top-4 h-6 w-20 -translate-x-1/2 rounded-full bg-dark-background/90">
                    <div className="absolute right-4 top-1/2 h-2.5 w-2.5 -translate-y-1/2 rounded-full bg-highlight-primary/50" />
                  </div>
                  <div className="absolute bottom-6 left-1/2 h-1 w-32 -translate-x-1/2 rounded-full bg-white/10" />
                </div>

                {/* Background Phone */}
                <div className="absolute -right-32 top-12 h-[500px] w-[250px] -rotate-6 opacity-40">
                  <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl" />
                  <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                    <Image
                      src="/images/p2p.png"
                      alt="SafeJet Exchange P2P Trading Interface"
                      fill
                      className="object-cover"
                      priority
                    />
                  </div>
                </div>
              </div>

              {/* Trading Steps */}
              <div className="space-y-6">
                {tradingSteps.map((step, index) => (
                  <motion.div
                    key={step.title}
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    transition={{ duration: 0.5, delay: 0.4 + index * 0.1 }}
                    className="flex items-start space-x-4"
                  >
                    <div className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full ${step.color} text-sm font-bold text-white`}>
                      {step.number}
                    </div>
                    <div>
                      <h4 className="mb-1 font-semibold">{step.title}</h4>
                      <p className="text-sm text-muted-foreground">{step.description}</p>
                    </div>
                  </motion.div>
                ))}
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 