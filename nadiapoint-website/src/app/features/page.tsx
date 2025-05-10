import { FeaturesHero } from "@/components/features/hero"
import { TradingFeatures } from "@/components/features/trading"
import { SecurityFeatures } from "@/components/features/security"
import { MobileFeatures } from "@/components/features/mobile"
import { P2PFeatures } from "@/components/features/p2p"
import { UserExperience } from "@/components/features/experience"
import { FeaturesCTA } from "@/components/features/cta"

export default function FeaturesPage() {
  return (
    <main className="relative">
      <FeaturesHero />
      <TradingFeatures />
      <SecurityFeatures />
      <MobileFeatures />
      <P2PFeatures />
      <UserExperience />
      <FeaturesCTA />
    </main>
  )
} 