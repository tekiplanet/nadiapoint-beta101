import { IconDefinition } from "@fortawesome/free-solid-svg-icons"

export interface ReleaseFeature {
  icon: IconDefinition
  title: string
  items: string[]
}

export interface ReleaseDownload {
  url: string
  requirements: string
  size: string
}

export interface ReleaseData {
  version: string
  date: string
  type: string
  description: string
  features: ReleaseFeature[]
  downloads: {
    ios: ReleaseDownload
    android: ReleaseDownload
  }
} 