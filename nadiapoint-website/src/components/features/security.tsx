"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faShieldHalved,
  faFingerprint,
  faVault,
  faLock,
  faUserShield,
  faShieldVirus
} from "@fortawesome/free-solid-svg-icons"

const securityFeatures = [
  {
    icon: faVault,
    title: "95% Cold Storage",
    description: "Majority of assets stored in offline, multi-signature wallets for maximum security",
    color: "from-blue-500 to-indigo-600",
    stat: "95%"
  },
  {
    icon: faFingerprint,
    title: "Biometric Authentication",
    description: "Advanced biometric security for mobile app access and transactions",
    color: "from-purple-500 to-violet-600",
    stat: "2FA"
  },
  {
    icon: faShieldHalved,
    title: "DDoS Protection",
    description: "Enterprise-grade DDoS protection and mitigation systems",
    color: "from-emerald-500 to-green-600",
    stat: "24/7"
  },
  {
    icon: faLock,
    title: "Data Encryption",
    description: "Bank-level AES-256 encryption for all sensitive data and communications",
    color: "from-orange-500 to-amber-600",
    stat: "256bit"
  },
  {
    icon: faUserShield,
    title: "KYC Verification",
    description: "Robust identity verification process to prevent fraud",
    color: "from-pink-500 to-rose-600",
    stat: "100%"
  },
  {
    icon: faShieldVirus,
    title: "Penetration Testing",
    description: "Regular security audits and penetration testing by third parties",
    color: "from-cyan-500 to-teal-600",
    stat: "Monthly"
  }
]

export function SecurityFeatures() {
  return (
    <section id="wallet" className="relative overflow-hidden bg-background py-24 sm:py-32">
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
              Bank-Grade Security<br />For Your Assets
            </h2>
            <p className="mb-16 text-lg text-muted-foreground">
              Your security is our top priority. We implement multiple layers of protection 
              to ensure your assets are safe and your trades are secure.
            </p>
          </motion.div>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto grid max-w-5xl gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {securityFeatures.map((feature, index) => (
            <motion.div
              key={feature.title}
              initial={{ opacity: 0, scale: 0.95 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className="mb-4 flex items-start justify-between">
                <div className={`rounded-xl bg-gradient-to-br ${feature.color} p-3 text-white shadow-lg`}>
                  <FontAwesomeIcon icon={feature.icon} className="h-6 w-6" />
                </div>
                <div className={`rounded-xl bg-gradient-to-br ${feature.color} px-3 py-1 text-sm font-semibold text-white`}>
                  {feature.stat}
                </div>
              </div>
              <h3 className="mb-2 text-lg font-semibold">{feature.title}</h3>
              <p className="text-sm text-muted-foreground">{feature.description}</p>
              {/* Decorative element */}
              <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </motion.div>
          ))}
        </motion.div>

        {/* Additional Security Info */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="mx-auto mt-16 max-w-3xl rounded-2xl bg-gradient-to-r from-gray-900 to-gray-800 p-8 text-center shadow-2xl"
        >
          <h3 className="mb-4 text-xl font-semibold text-white">
            Your Funds Are Protected
          </h3>
          <p className="text-gray-300">
            We maintain a secure asset fund to ensure your cryptocurrency holdings are protected. 
            Our platform undergoes regular security audits and maintains industry-leading 
            security certifications.
          </p>
        </motion.div>
      </div>
    </section>
  )
} 