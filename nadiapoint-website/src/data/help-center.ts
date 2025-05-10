import { HelpCenterContent } from "@/types/help"

export const helpCenterContent: HelpCenterContent = {
  faqs: [
    {
      question: "How do I create an account?",
      answer: "To create an account, click the 'Sign Up' button on the top right of the homepage. Fill in your details including email, password, and complete the verification process.",
      category: "Account Management"
    },
    {
      question: "How secure is NadiaPoint Exchange?",
      answer: "We implement industry-standard security measures including 2FA, encryption, and regular security audits. Your funds and data are protected by multiple layers of security.",
      category: "Security"
    },
    {
      question: "How do I start trading?",
      answer: "After creating and verifying your account, deposit funds, navigate to the trading page, select your desired trading pair, and place your first order.",
      category: "Trading"
    }
  ],
  guides: [
    {
      title: "Getting Started with NadiaPoint Exchange",
      description: "A complete guide for new users to start their journey with NadiaPoint Exchange",
      steps: [
        "Create and verify your account",
        "Complete your profile setup",
        "Set up 2FA security",
        "Add your first payment method",
        "Make your first deposit"
      ],
      category: "Beginners Guide"
    },
    {
      title: "Mobile App Setup Guide",
      description: "Learn how to set up and use the NadiaPoint Exchange mobile app",
      steps: [
        "Download the app from your device's app store",
        "Log in with your existing account or create new",
        "Configure biometric authentication",
        "Customize your trading interface",
        "Set up price alerts"
      ],
      category: "Mobile App"
    }
  ],
  contactMethods: [
    {
      type: "Email Support",
      value: "support@nadiapoint.com",
      availabilityHours: "24/7",
      responseTime: "Within 24 hours"
    },
    {
      type: "Live Chat",
      value: "Available in-app",
      availabilityHours: "Monday-Friday, 9:00 AM - 5:00 PM UTC",
      responseTime: "Within 1 hour during business hours"
    }
  ],
  documentation: [
    {
      title: "Security Best Practices",
      description: "Learn about our security features and how to keep your account safe",
      category: "Security",
      link: "/docs/security"
    },
    {
      title: "Trading Guide",
      description: "Comprehensive guide to trading on NadiaPoint Exchange",
      category: "Trading",
      link: "/docs/trading"
    },
    {
      title: "Mobile App Manual",
      description: "Detailed guide for using the NadiaPoint Exchange mobile app",
      category: "Mobile App",
      link: "/docs/mobile-app"
    }
  ]
} 