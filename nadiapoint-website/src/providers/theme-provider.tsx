"use client"

import { createContext, useContext, useEffect, useState } from "react"

type Theme = "dark" | "light"

type ThemeProviderProps = {
  children: React.ReactNode
  defaultTheme?: Theme
  storageKey?: string
}

type ThemeProviderState = {
  theme: Theme
  setTheme: (theme: Theme) => void
}

const initialState: ThemeProviderState = {
  theme: "dark",
  setTheme: () => null,
}

const ThemeProviderContext = createContext<ThemeProviderState>(initialState)

const getSystemTheme = (): Theme => {
  if (typeof window === 'undefined') return 'dark'
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
}

export function ThemeProvider({
  children,
  defaultTheme = "dark",
  storageKey = "nadiapoint-theme",
  ...props
}: ThemeProviderProps) {
  // Initialize with defaultTheme for SSR
  const [theme, setTheme] = useState<Theme>(defaultTheme)
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
    try {
      const savedTheme = localStorage.getItem(storageKey) as Theme
      const systemTheme = getSystemTheme()
      setTheme(savedTheme || systemTheme)
    } catch (e) {
      console.warn('Failed to get theme from localStorage:', e)
    }
  }, [storageKey])

  useEffect(() => {
    if (!mounted) return

    try {
      const root = window.document.documentElement
      root.classList.remove("light", "dark")
      root.classList.add(theme)
    } catch (e) {
      console.warn('Failed to update theme:', e)
    }
  }, [theme, mounted])

  const value = {
    theme,
    setTheme: (newTheme: Theme) => {
      try {
        localStorage.setItem(storageKey, newTheme)
        setTheme(newTheme)
      } catch (e) {
        console.warn('Failed to save theme:', e)
        setTheme(newTheme)
      }
    },
  }

  // For SSR, render a div that will be replaced on client
  if (!mounted) {
    return (
      <div style={{ visibility: 'hidden' }}>
        {children}
      </div>
    )
  }

  return (
    <ThemeProviderContext.Provider {...props} value={value}>
      {children}
    </ThemeProviderContext.Provider>
  )
}

export const useTheme = () => {
  const context = useContext(ThemeProviderContext)

  if (context === undefined)
    throw new Error("useTheme must be used within a ThemeProvider")

  return context
} 