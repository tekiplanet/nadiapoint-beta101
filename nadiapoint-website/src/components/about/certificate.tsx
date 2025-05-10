"use client"

import { motion } from "@/lib/framer"
import Image from "next/image"

export function Certificate() {
  return (
    <section className="relative overflow-hidden bg-background py-24 sm:py-32">
      {/* Background gradient and grid */}
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
        <div className="mx-auto max-w-4xl text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-gradient mb-6 text-3xl font-bold sm:text-4xl">
              Licensed & Regulated
            </h2>
            <p className="mb-12 text-lg text-muted-foreground">
              NadiaPoint Investment Limited is duly registered with the Corporate Affairs Commission (CAC) 
              of Nigeria under the Companies and Allied Matters Act 2020.
            </p>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative mx-auto max-w-2xl overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
          >
            <div className="relative aspect-[3/4] w-full">
              <Image
                src="/images/certificate.png"
                alt="NadiaPoint Investment Limited CAC Certificate"
                fill
                className="object-contain"
                priority
              />
            </div>
            <div className="mt-6 flex flex-col gap-2 text-left">
              <p className="text-sm text-muted-foreground">
                <span className="font-semibold">Registration Number:</span> RC 8363941
              </p>
              <p className="text-sm text-muted-foreground">
                <span className="font-semibold">Date of Incorporation:</span> March 24th, 2023
              </p>
              <p className="text-sm text-muted-foreground">
                <span className="font-semibold">Tax Identification Number:</span> 33003923-0001
              </p>
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  )
} 