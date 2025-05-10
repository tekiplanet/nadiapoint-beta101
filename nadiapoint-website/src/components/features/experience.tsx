"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faUserGroup,
  faCompass,
  faLightbulb,
  faKeyboard,
  faChartSimple,
  faCircleQuestion,
  faMoon,
  faDisplay,
  faBolt
} from "@fortawesome/free-solid-svg-icons"

const experienceFeatures = [
  {
    icon: faCompass,
    title: "Intuitive Navigation",
    description: "Clean and organized interface with easy access to all trading features",
    color: "from-blue-500 to-indigo-600",
    metric: "Simple"
  },
  {
    icon: faLightbulb,
    title: "Smart Defaults",
    description: "Pre-configured settings optimized for both beginners and professionals",
    color: "from-emerald-500 to-green-600",
    metric: "Smart"
  },
  {
    icon: faKeyboard,
    title: "Quick Actions",
    description: "Keyboard shortcuts and quick-access tools for efficient trading",
    color: "from-purple-500 to-violet-600",
    metric: "Fast"
  },
  {
    icon: faChartSimple,
    title: "Clear Analytics",
    description: "Easy-to-understand charts and performance metrics for better decisions",
    color: "from-orange-500 to-amber-600",
    metric: "Visual"
  },
  {
    icon: faUserGroup,
    title: "Personalization",
    description: "Customizable interface and preferences for your trading style",
    color: "from-pink-500 to-rose-600",
    metric: "Custom"
  },
  {
    icon: faCircleQuestion,
    title: "Guided Learning",
    description: "Interactive tutorials and tooltips to help you master the platform",
    color: "from-cyan-500 to-teal-600",
    metric: "Helpful"
  }
]

const interfaceHighlights = [
  {
    icon: faMoon,
    title: "Dark/Light Mode",
    description: "Switch between themes to suit your preference and reduce eye strain",
    color: "from-purple-500 to-violet-600"
  },
  {
    icon: faDisplay,
    title: "Responsive Design",
    description: "Seamless experience across all devices and screen sizes",
    color: "from-blue-500 to-indigo-600"
  },
  {
    icon: faBolt,
    title: "Quick Trading",
    description: "Execute trades in just a few clicks with our optimized interface",
    color: "from-emerald-500 to-green-600"
  }
]

export function UserExperience() {
  return (
    <section id="portfolio" className="relative overflow-hidden bg-background py-24 sm:py-32">
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
        <div className="mx-auto max-w-2xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
              Designed for the Best<br />Trading Experience
            </h2>
            <p className="mb-16 text-lg text-muted-foreground">
              Every aspect of our platform is crafted to provide you with a seamless and 
              intuitive trading experience, whether you're a beginner or a pro.
            </p>
          </motion.div>
        </div>

        {/* Features Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto grid max-w-5xl gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {experienceFeatures.map((feature, index) => (
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
                  {feature.metric}
                </div>
              </div>
              <h3 className="mb-2 text-lg font-semibold">{feature.title}</h3>
              <p className="text-sm text-muted-foreground">{feature.description}</p>
              {/* Decorative element */}
              <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${feature.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </motion.div>
          ))}
        </motion.div>

        {/* Interface Highlights */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="mx-auto mt-24 grid max-w-7xl gap-8 lg:grid-cols-3"
        >
          {interfaceHighlights.map((highlight, index) => (
            <motion.div
              key={highlight.title}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: 0.6 + index * 0.1 }}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 text-center shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className={`mx-auto mb-6 inline-flex rounded-xl bg-gradient-to-br ${highlight.color} p-4 text-white shadow-lg`}>
                <FontAwesomeIcon icon={highlight.icon} className="h-8 w-8" />
              </div>
              <h3 className="mb-3 text-xl font-semibold">{highlight.title}</h3>
              <p className="text-muted-foreground">{highlight.description}</p>
              {/* Decorative element */}
              <div className={`absolute -right-8 -top-8 h-24 w-24 rounded-full bg-gradient-to-br ${highlight.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 