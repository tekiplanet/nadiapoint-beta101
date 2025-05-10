export interface FAQItem {
  question: string
  answer: string
  category: string
}

export interface GuideItem {
  title: string
  description: string
  steps: string[]
  category: string
}

export interface ContactMethod {
  type: string
  value: string
  availabilityHours: string
  responseTime: string
}

export interface DocumentationItem {
  title: string
  description: string
  category: string
  link: string
}

export interface HelpCenterContent {
  faqs: FAQItem[]
  guides: GuideItem[]
  contactMethods: ContactMethod[]
  documentation: DocumentationItem[]
} 