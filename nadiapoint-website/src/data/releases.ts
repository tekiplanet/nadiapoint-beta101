import { ReleaseData } from "@/types/release"
import {
  faRocket,
  faCode,
  faShieldHalved,
  faGears
} from "@fortawesome/free-solid-svg-icons"

export const betaRelease: ReleaseData = {
  version: "Beta 1.0.0",
  date: "May 10, 2025",
  type: "Beta Release",
  description: "Initial beta release of NadiaPoint Exchange mobile app with core trading features and security implementations.",
  features: [
    {
      icon: faRocket,
      title: "Core Features",
      items: [
        "Cryptocurrency trading interface",
        "Real-time market data",
        "Portfolio management",
        "Price alerts"
      ]
    },
    {
      icon: faShieldHalved,
      title: "Security",
      items: [
        "Biometric authentication",
        "2FA implementation",
        "Secure wallet integration",
        "Transaction encryption"
      ]
    },
    {
      icon: faCode,
      title: "Technical",
      items: [
        "Performance optimizations",
        "Real-time data sync",
        "Offline capability",
        "Low latency trading"
      ]
    },
    {
      icon: faGears,
      title: "Infrastructure",
      items: [
        "Cloud infrastructure setup",
        "Load balancing",
        "Auto-scaling support",
        "24/7 monitoring"
      ]
    }
  ],
  downloads: {
    ios: {
      url: "#",
      requirements: "Coming Soon",
      size: "TBA"
    },
    android: {
      url: "https://nadiapoint.com/downloads/nadiapoint_v_0_0_1.apk",
      requirements: "Android 8.0 or later",
      size: "59.7 MB"
    }
  }
} 