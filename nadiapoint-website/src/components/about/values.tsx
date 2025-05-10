"use client"

import { motion } from "@/lib/framer"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faShieldHalved,
  faRocket,
  faUserShield
} from "@fortawesome/free-solid-svg-icons"

const values = [
  {
    title: "Security First",
    description: "Your assets' security is our top priority. We implement the highest standards of encryption and protection.",
    icon: faShieldHalved,
    color: "from-blue-500 to-indigo-700",
  },
  {
    title: "Innovation",
    description: "We continuously evolve our platform with cutting-edge technology to provide the best trading experience.",
    icon: faRocket,
    color: "from-purple-500 to-violet-700",
  },
  {
    title: "User-Centric",
    description: "Every feature is designed with our users in mind, ensuring a seamless and intuitive trading experience.",
    icon: faUserShield,
    color: "from-green-500 to-emerald-700",
  },
]

export function Values() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-y-0 left-0 w-1/2 bg-gradient-to-r from-highlight-primary/10 to-transparent blur-3xl" />
        <div className="absolute inset-y-0 right-0 w-1/2 bg-gradient-to-l from-highlight-secondary/10 to-transparent blur-3xl" />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto max-w-2xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-4 text-3xl font-bold sm:text-4xl">Our Core Values</h2>
            <p className="text-lg text-muted-foreground">
              The principles that guide us in building the best crypto trading experience.
            </p>
          </motion.div>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mx-auto mt-16 grid max-w-4xl gap-8 sm:grid-cols-2 lg:grid-cols-3"
        >
          {values.map((value, index) => (
            <div
              key={value.title}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              {/* Icon */}
              <div className={`mb-5 inline-flex rounded-xl bg-gradient-to-r ${value.color} p-3 text-white shadow-lg`}>
                <FontAwesomeIcon icon={value.icon} className="h-6 w-6" />
              </div>

              {/* Content */}
              <h3 className="mb-3 text-lg font-semibold">{value.title}</h3>
              <p className="text-sm text-muted-foreground">{value.description}</p>

              {/* Decorative elements */}
              <div className={`absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br ${value.color} opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20`} />
            </div>
          ))}
        </motion.div>
      </div>
    </section>
  )
} 