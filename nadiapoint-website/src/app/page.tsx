import { HeroSection } from "@/components/home/hero-section"
import { FeaturesGrid } from "@/components/home/features-grid"
import { TradingStats } from "@/components/home/trading-stats"
import { MobileShowcase } from "@/components/home/mobile-showcase"
import { SecurityFeatures } from "@/components/home/security-features"
import { P2PTrading } from "@/components/home/p2p-trading"

export default function Home() {
  return (
    <main className="relative">
      <HeroSection />
      <FeaturesGrid />
      <TradingStats />
      <MobileShowcase />
      <SecurityFeatures />
      <P2PTrading />
    </main>
  )
}
