"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faMobileScreen,
  faBolt,
  faBell,
  faFingerprint,
  faChartLine,
  faWallet
} from "@fortawesome/free-solid-svg-icons"
import Image from "next/image"

const mobileFeatures = [
  {
    icon: faBolt,
    title: "Quick Trading",
    description: "Execute trades in seconds with our optimized mobile interface",
    color: "from-blue-500 to-indigo-600"
  },
  {
    icon: faBell,
    title: "Instant Alerts",
    description: "Real-time notifications for price alerts and order executions",
    color: "from-purple-500 to-violet-600"
  },
  {
    icon: faFingerprint,
    title: "Secure Access",
    description: "Biometric authentication and advanced security features",
    color: "from-emerald-500 to-green-600"
  },
  {
    icon: faChartLine,
    title: "Live Charts",
    description: "Professional trading charts and analysis tools on the go",
    color: "from-orange-500 to-amber-600"
  },
  {
    icon: faWallet,
    title: "Wallet Management",
    description: "Manage multiple crypto wallets and track your portfolio",
    color: "from-pink-500 to-rose-600"
  },
  {
    icon: faMobileScreen,
    title: "Offline Mode",
    description: "Access key features even without internet connection",
    color: "from-cyan-500 to-teal-600"
  }
]

export function MobileFeatures() {
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
          {/* Left Column - Phone Mockups */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="relative flex items-center justify-center"
          >
            <div className="relative">
              {/* Main Phone */}
              <div className="relative h-[600px] w-[300px]">
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                  <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-t from-highlight-primary/20 to-transparent opacity-50" />
                </div>
                <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                  <Image
                    src="/images/app-screenshoot.png"
                    alt="SafeJet Exchange Mobile App"
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
                    src="/images/wallet-page.png"
                    alt="SafeJet Exchange Wallet Interface"
                    fill
                    className="object-cover"
                    priority
                  />
                </div>
              </div>
            </div>
          </motion.div>

          {/* Right Column - Content */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="flex flex-col justify-center"
          >
            <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
              Trade Anywhere<br />With Our Mobile App
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              Experience the full power of SafeJet Exchange in your pocket. Our mobile app 
              brings professional trading tools and secure asset management to your fingertips.
            </p>

            {/* Features Grid */}
            <div className="grid gap-6 sm:grid-cols-2">
              {mobileFeatures.map((feature, index) => (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
                >
                  <div className={`mb-4 inline-flex rounded-xl bg-gradient-to-br ${feature.color} p-3 text-white shadow-lg`}>
                    <FontAwesomeIcon icon={feature.icon} className="h-5 w-5" />
                  </div>
                  <h3 className="mb-2 text-base font-semibold">{feature.title}</h3>
                  <p className="text-sm text-muted-foreground">{feature.description}</p>
                  {/* Decorative element */}
                  <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
                </motion.div>
              ))}
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 