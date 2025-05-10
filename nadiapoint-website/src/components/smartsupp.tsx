"use client"

import { useEffect } from "react"

declare global {
  interface Window {
    smartsupp: any
    _smartsupp: any
  }
}

export function Smartsupp() {
  useEffect(() => {
    // Initialize Smartsupp configuration
    window._smartsupp = window._smartsupp || {}
    window._smartsupp.key = '49ca712e86e9f8d0e39b83da68ceb4efa45c7eac'

    // Load Smartsupp script
    const script = document.createElement('script')
    script.type = 'text/javascript'
    script.async = true
    script.src = 'https://www.smartsuppchat.com/loader.js'

    // Append script to document
    document.head.appendChild(script)

    // Cleanup function
    return () => {
      document.head.removeChild(script)
      delete window.smartsupp
      delete window._smartsupp
    }
  }, []) // Empty dependency array means this runs once on mount

  return null // This component doesn't render anything visible
} 