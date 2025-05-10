import { Overview } from "@/components/about/overview"
import { Stats } from "@/components/about/stats"
import { Values } from "@/components/about/values"
import { AboutCTA } from "@/components/about/cta"
import { Certificate } from "@/components/about/certificate"

export default function AboutPage() {
  return (
    <main className="relative">
      <Overview />
      <Stats />
      <Values />
      <Certificate />
      <AboutCTA />
    </main>
  )
} 