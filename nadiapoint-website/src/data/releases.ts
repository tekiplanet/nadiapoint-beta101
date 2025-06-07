import { ReleaseData } from "@/types/release"
import {
  faRocket,
  faCode,
  faShieldHalved,
  faGears,
  faBug,
  faUserShield,
  faMessage,
  faLink
} from "@fortawesome/free-solid-svg-icons"

export const betaRelease: ReleaseData = {
  version: "Beta 1.0.1",
  date: "June 07, 2025",
  type: "Beta Release",
  description: "Enhanced user experience with improved authentication, KYC process, and support features.",
  features: [
    {
      icon: faBug,
      title: "Bug Fixes",
      items: [
        "Resolved token persistence issue in authentication flow",
        "Fixed session management to maintain login state between app launches",
        "Improved error handling in registration and login processes"
      ]
    },
    {
      icon: faUserShield,
      title: "KYC Improvements",
      items: [
        "Enhanced KYC verification process with better error handling",
        "Added user-friendly error messages for KYC verification steps",
        "Integrated direct support access during KYC process"
      ]
    },
    {
      icon: faMessage,
      title: "Support Features",
      items: [
        "Integrated in-app live chat support system",
        "Added quick access to support from login and registration screens",
        "Improved error message clarity and user guidance"
      ]
    },
    {
      icon: faLink,
      title: "UI/UX Updates",
      items: [
        "Added company branding and logo throughout the app",
        "Integrated privacy policy and terms of service links in registration",
        "Enhanced overall user interface consistency"
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
      url: "https://nadiapoint.com/downloads/nadiapoint_beta_1_0_1.apk",
      requirements: "Android 8.0 or later",
      size: "62.1 MB"
    }
  }
}

export const previousBetaRelease: ReleaseData = {
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