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

// Avoid hydration mismatch by checking for window in a separate function
const getInitialTheme = (defaultTheme: Theme): Theme => {
  if (typeof window !== 'undefined') {
    try {
      const storedTheme = window.localStorage.getItem('nadiapoint-theme') as Theme
      if (storedTheme) {
        return storedTheme
      }
      
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
      return prefersDark ? 'dark' : 'light'
    } catch (e) {
      console.warn('Failed to get initial theme:', e)
    }
  }
  return defaultTheme
}

export function ThemeProvider({
  children,
  defaultTheme = "dark",
  storageKey = "nadiapoint-theme",
  ...props
}: ThemeProviderProps) {
  const [theme, setTheme] = useState<Theme>(() => defaultTheme)
  const [mounted, setMounted] = useState(false)

  // Update theme when component mounts
  useEffect(() => {
    const initialTheme = getInitialTheme(defaultTheme)
    setTheme(initialTheme)
    setMounted(true)
  }, [defaultTheme])

  // Update document class when theme changes
  useEffect(() => {
    if (mounted) {
      const root = document.documentElement
      const classList = root.classList

      if (theme === 'dark') {
        classList.remove('light')
        classList.add('dark')
      } else {
        classList.remove('dark')
        classList.add('light')
      }
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