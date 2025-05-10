"use client"

import { useState } from "react"
import { helpCenterContent } from "@/data/help-center"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { 
  faSearch, 
  faQuestionCircle,
  faBook,
  faHeadset,
  faChevronDown
} from "@fortawesome/free-solid-svg-icons"

export function HelpCenter() {
  const [searchQuery, setSearchQuery] = useState("")
  const [activeCategory, setActiveCategory] = useState("all")

  return (
    <div className="mx-auto max-w-7xl px-4 py-24 sm:px-6 lg:px-8">
      {/* Header */}
      <div className="text-center">
        <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
          How can we help you?
        </h1>
        <p className="mt-6 text-lg leading-8 text-muted-foreground">
          Find answers to common questions and learn how to make the most of NadiaPoint Exchange
        </p>
      </div>

      {/* Search Bar */}
      <div className="mx-auto mt-8 max-w-2xl">
        <div className="relative">
          <div className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
            <FontAwesomeIcon icon={faSearch} className="h-5 w-5 text-muted-foreground" />
          </div>
          <input
            type="text"
            className="block w-full rounded-xl border-0 py-4 pl-10 pr-4 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-highlight-primary dark:bg-gray-900 dark:ring-gray-700"
            placeholder="Search for answers..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
        </div>
      </div>

      {/* Main Content Grid */}
      <div className="mt-16 grid gap-8 md:grid-cols-2 lg:grid-cols-3">
        {/* FAQs Section */}
        <div className="rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg dark:from-gray-900/90 dark:to-gray-800/90">
          <div className="mb-6 flex items-center gap-3">
            <FontAwesomeIcon icon={faQuestionCircle} className="h-6 w-6 text-highlight-primary" />
            <h2 className="text-xl font-semibold">Frequently Asked Questions</h2>
          </div>
          <div className="space-y-4">
            {helpCenterContent.faqs.map((faq, index) => (
              <details
                key={index}
                className="group rounded-lg border border-gray-200 dark:border-gray-700"
              >
                <summary className="flex cursor-pointer items-center justify-between p-4 font-medium">
                  {faq.question}
                  <FontAwesomeIcon
                    icon={faChevronDown}
                    className="h-5 w-5 transform transition-transform group-open:rotate-180"
                  />
                </summary>
                <div className="p-4 pt-0 text-muted-foreground">
                  {faq.answer}
                </div>
              </details>
            ))}
          </div>
        </div>

        {/* Guides Section */}
        <div className="rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg dark:from-gray-900/90 dark:to-gray-800/90">
          <div className="mb-6 flex items-center gap-3">
            <FontAwesomeIcon icon={faBook} className="h-6 w-6 text-highlight-primary" />
            <h2 className="text-xl font-semibold">Guides</h2>
          </div>
          <div className="space-y-4">
            {helpCenterContent.guides.map((guide, index) => (
              <div
                key={index}
                className="rounded-lg border border-gray-200 p-4 dark:border-gray-700"
              >
                <h3 className="mb-2 font-medium">{guide.title}</h3>
                <p className="mb-4 text-sm text-muted-foreground">
                  {guide.description}
                </p>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  {guide.steps.map((step, stepIndex) => (
                    <li key={stepIndex} className="flex items-center gap-2">
                      <div className="h-1.5 w-1.5 rounded-full bg-highlight-primary" />
                      {step}
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {/* Contact & Documentation Section */}
        <div className="space-y-8">
          {/* Contact Methods */}
          <div className="rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg dark:from-gray-900/90 dark:to-gray-800/90">
            <div className="mb-6 flex items-center gap-3">
              <FontAwesomeIcon icon={faHeadset} className="h-6 w-6 text-highlight-primary" />
              <h2 className="text-xl font-semibold">Contact Support</h2>
            </div>
            <div className="space-y-4">
              {helpCenterContent.contactMethods.map((method, index) => (
                <div
                  key={index}
                  className="rounded-lg border border-gray-200 p-4 dark:border-gray-700"
                >
                  <h3 className="mb-2 font-medium">{method.type}</h3>
                  <p className="text-sm text-highlight-primary">{method.value}</p>
                  <div className="mt-2 space-y-1 text-sm text-muted-foreground">
                    <p>Hours: {method.availabilityHours}</p>
                    <p>Response Time: {method.responseTime}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Documentation Links */}
          <div className="rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-6 shadow-lg dark:from-gray-900/90 dark:to-gray-800/90">
            <div className="mb-6 flex items-center gap-3">
              <FontAwesomeIcon icon={faBook} className="h-6 w-6 text-highlight-primary" />
              <h2 className="text-xl font-semibold">Documentation</h2>
            </div>
            <div className="space-y-4">
              {helpCenterContent.documentation.map((doc, index) => (
                <a
                  key={index}
                  href={doc.link}
                  className="block rounded-lg border border-gray-200 p-4 transition-colors hover:border-highlight-primary dark:border-gray-700"
                >
                  <h3 className="mb-1 font-medium">{doc.title}</h3>
                  <p className="text-sm text-muted-foreground">
                    {doc.description}
                  </p>
                </a>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 