import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  }
})

// Database types
export interface User {
  id: string
  email: string | null
  name: string | null
  district: string | null
  state: string | null
  created_at: string | null
}

export interface Scan {
  id: string
  user_id: string | null
  crop: string | null
  disease: string | null
  confidence: number | null
  image_url: string | null
  location: string | null
  action_taken: string | null
  created_at: string | null
}

export interface Forecast {
  id: string
  location: string | null
  date: string | null
  temperature: number | null
  humidity: number | null
  rain_chance: number | null
  disease_risk: number | null
}