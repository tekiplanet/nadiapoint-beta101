"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faChartLine, 
  faShieldHalved, 
  faMobileScreen,
  faHandshake,
  faUserGroup,
  faGraduationCap
} from "@fortawesome/free-solid-svg-icons"

const features = [
  {
    icon: faChartLine,
    title: "Advanced Trading",
    description: "Professional-grade trading tools and charts",
    color: "from-blue-500 to-indigo-600"
  },
  {
    icon: faShieldHalved,
    title: "Bank-Grade Security",
    description: "Multi-layer security with 95% cold storage",
    color: "from-emerald-500 to-green-600"
  },
  {
    icon: faMobileScreen,
    title: "Mobile First",
    description: "Trade anywhere with our powerful mobile app",
    color: "from-purple-500 to-violet-600"
  },
  {
    icon: faHandshake,
    title: "P2P Trading",
    description: "Safe peer-to-peer cryptocurrency trading",
    color: "from-orange-500 to-amber-600"
  },
  {
    icon: faUserGroup,
    title: "User Friendly",
    description: "Intuitive interface for all experience levels",
    color: "from-pink-500 to-rose-600"
  },
  {
    icon: faGraduationCap,
    title: "Learn & Earn",
    description: "Educational resources and trading guides",
    color: "from-cyan-500 to-teal-600"
  }
]

export function FeaturesHero() {
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
            <h1 className="text-gradient mb-6 text-4xl font-bold sm:text-5xl lg:text-6xl">
              Features That Set<br />Us Apart
            </h1>
            <p className="mb-16 text-lg text-muted-foreground sm:text-xl">
              Experience the next generation of cryptocurrency trading with our 
              comprehensive suite of features designed for both beginners and professionals.
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
          {features.map((feature, index) => (
            <motion.div
              key={feature.title}
              initial={{ opacity: 0, scale: 0.95 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className={`mb-5 inline-flex rounded-xl bg-gradient-to-br ${feature.color} p-3 text-white shadow-lg`}>
                <FontAwesomeIcon icon={feature.icon} className="h-6 w-6" />
              </div>
              <h3 className="mb-2 text-lg font-semibold">{feature.title}</h3>
              <p className="text-sm text-muted-foreground">{feature.description}</p>
              {/* Decorative element */}
              <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 