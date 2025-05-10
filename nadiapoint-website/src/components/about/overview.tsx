"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faShieldHalved, faRocket, faGlobe } from "@fortawesome/free-solid-svg-icons"

const highlights = [
  {
    icon: faShieldHalved,
    title: "Security First",
    description: "Enterprise-grade security protocols protecting your assets 24/7"
  },
  {
    icon: faRocket,
    title: "Innovation Driven",
    description: "Cutting-edge technology powering seamless trading experiences"
  },
  {
    icon: faGlobe,
    title: "Global Access",
    description: "Trade from anywhere with our mobile-first platform"
  }
]

export function Overview() {
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
            <h1 className="text-gradient mb-6 text-4xl font-bold sm:text-5xl lg:text-6xl">
              Revolutionizing<br />Crypto Trading
            </h1>
            <p className="mb-8 text-lg text-muted-foreground sm:text-xl">
              NadiaPoint Exchange is your gateway to the future of cryptocurrency trading. 
              We've built a mobile-first platform that combines security, speed, and simplicity 
              to make crypto trading accessible to everyone.
            </p>

            {/* Highlights */}
            <div className="grid gap-6">
              {highlights.map((highlight, index) => (
                <motion.div
                  key={highlight.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className="flex items-start gap-4"
                >
                  <div className="rounded-lg bg-gradient-to-br from-highlight-primary to-highlight-secondary p-3 text-white">
                    <FontAwesomeIcon icon={highlight.icon} className="h-5 w-5" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold">{highlight.title}</h3>
                    <p className="text-sm text-muted-foreground">{highlight.description}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </motion.div>

          {/* Right Column - Image */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative flex items-center justify-center lg:justify-end"
          >
            {/* Phone Mockup */}
            <div className="relative h-[600px] w-[300px]">
              <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-br from-highlight-primary/20 to-highlight-secondary/20 backdrop-blur-xl">
                {/* Inner glow */}
                <div className="absolute inset-0 rounded-[3rem] bg-gradient-to-t from-highlight-primary/20 to-transparent opacity-50" />
              </div>
              <div className="absolute inset-2 overflow-hidden rounded-[2.75rem] bg-dark-background">
                <Image
                  src="/images/app-screenshoot.png"
                  alt="NadiaPoint Exchange Mobile App"
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
          </motion.div>
        </div>
      </div>
    </section>
  )
} 