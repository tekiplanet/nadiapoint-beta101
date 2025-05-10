"use client"

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faApple, faGooglePlay } from "@fortawesome/free-brands-svg-icons"
import { betaRelease } from "@/data/releases"

export function BetaRelease() {
  return (
    <>
      {/* Header */}
      <div className="mx-auto max-w-2xl text-center">
        <span className="inline-flex items-center rounded-full bg-highlight-primary/10 px-3 py-1 text-sm font-medium text-highlight-primary ring-1 ring-inset ring-highlight-primary/20">
          Latest Release
        </span>
        <h1 className="text-gradient mt-6 text-4xl font-bold sm:text-5xl">
          {betaRelease.version}
        </h1>
        <p className="mt-2 text-lg text-muted-foreground">
          Released on {betaRelease.date}
        </p>
        <p className="mt-6 text-lg text-muted-foreground">
          {betaRelease.description}
        </p>
      </div>

      {/* Download Section */}
      <div className="mx-auto mt-16 grid max-w-4xl gap-8 sm:grid-cols-2">
        {/* iOS Download */}
        <div className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90">
          <div className="mb-6 inline-flex rounded-xl bg-black/50 p-3 text-white">
            <FontAwesomeIcon icon={faApple} className="h-8 w-8" />
          </div>
          <h3 className="mb-2 text-xl font-semibold">iOS App</h3>
          <p className="mb-4 text-sm text-muted-foreground">
            {betaRelease.downloads.ios.requirements}
          </p>
          <div className="mb-6 text-sm text-muted-foreground">
            Size: {betaRelease.downloads.ios.size}
          </div>
          <button
            disabled
            className="inline-flex cursor-not-allowed items-center justify-center gap-2 rounded-xl bg-black/50 px-6 py-3 text-sm font-semibold text-white opacity-70"
          >
            Coming Soon
            <FontAwesomeIcon icon={faApple} className="h-5 w-5" />
          </button>
        </div>

        {/* Android Download */}
        <div className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90">
          <div className="mb-6 inline-flex rounded-xl bg-green-600 p-3 text-white">
            <FontAwesomeIcon icon={faGooglePlay} className="h-8 w-8" />
          </div>
          <h3 className="mb-2 text-xl font-semibold">Android App</h3>
          <p className="mb-4 text-sm text-muted-foreground">
            {betaRelease.downloads.android.requirements}
          </p>
          <div className="mb-6 text-sm text-muted-foreground">
            Size: {betaRelease.downloads.android.size}
          </div>
          <a
            href={betaRelease.downloads.android.url}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center justify-center gap-2 rounded-xl bg-green-600 px-6 py-3 text-sm font-semibold text-white transition-transform duration-300 hover:scale-105"
          >
            Download for Android
            <FontAwesomeIcon icon={faGooglePlay} className="h-5 w-5" />
          </a>
        </div>
      </div>

      {/* Features Grid */}
      <div className="mx-auto mt-24 max-w-7xl">
        <h2 className="mb-12 text-center text-3xl font-bold">Release Features</h2>
        <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
          {betaRelease.features.map((feature) => (
            <div
              key={feature.title}
              className="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-50/90 to-white/90 p-8 shadow-lg transition-all duration-300 hover:shadow-xl dark:from-gray-900/90 dark:to-gray-800/90"
            >
              <div className="mb-6 inline-flex rounded-xl bg-gray-900 p-3 dark:bg-gradient-to-r dark:from-highlight-primary dark:to-highlight-secondary">
                <FontAwesomeIcon icon={feature.icon} className="h-6 w-6 text-white" />
              </div>
              <h3 className="mb-4 text-lg font-semibold">{feature.title}</h3>
              <ul className="space-y-2 text-sm text-muted-foreground">
                {feature.items.map((item) => (
                  <li key={item} className="flex items-center gap-2">
                    <div className="h-1 w-1 rounded-full bg-highlight-primary" />
                    {item}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>

      {/* Beta Notice */}
      <div className="mx-auto mt-24 max-w-3xl rounded-2xl bg-gradient-to-r from-highlight-primary/10 to-highlight-secondary/10 p-8 text-center">
        <h3 className="mb-4 text-xl font-semibold">Beta Testing Phase</h3>
        <p className="text-muted-foreground">
          This is a beta release of the NadiaPoint Exchange mobile app. We welcome your feedback 
          and suggestions as we continue to improve the platform. Please report any issues or 
          share your thoughts through our support channels.
        </p>
      </div>
    </>
  )
} 