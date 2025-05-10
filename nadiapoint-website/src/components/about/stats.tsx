"use client"

import { motion } from "@/lib/framer"

const stats = [
  { name: "Active Users", value: "100K+" },
  { name: "Countries", value: "150+" },
  { name: "App Rating", value: "4.8/5" },
  { name: "Downloads", value: "500K+" },
]

export function Stats() {
  return (
    <section className="relative bg-background py-16 sm:py-24">
      {/* Grid Pattern Background */}
      <div className="absolute inset-0">
        <div 
          className="absolute inset-0 bg-[linear-gradient(to_right,#80808020_1px,transparent_1px),linear-gradient(to_bottom,#80808020_1px,transparent_1px)] bg-[size:24px_24px]" 
          style={{ maskImage: 'linear-gradient(to bottom, transparent, black 10%, black 90%, transparent)' }}
        />
      </div>

      <div className="container relative mx-auto px-6 lg:px-8">
        <div className="mx-auto max-w-5xl">
          <dl className="grid grid-cols-2 gap-8 lg:grid-cols-4">
            {stats.map((stat, index) => (
              <motion.div
                key={stat.name}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 text-center shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
              >
                <dt className="text-sm font-medium text-muted-foreground">{stat.name}</dt>
                <dd className="text-gradient mt-2 text-4xl font-bold">{stat.value}</dd>
                {/* Decorative elements */}
                <div className="absolute -right-8 -top-8 h-16 w-16 rounded-full bg-gradient-to-br from-highlight-primary to-highlight-secondary opacity-10 blur-xl transition-all duration-300 group-hover:opacity-20" />
              </motion.div>
            ))}
          </dl>
        </div>
      </div>
    </section>
  )
} 