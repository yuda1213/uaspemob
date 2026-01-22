-- Supabase Database Setup Script
-- Run this in Supabase SQL Editor to create necessary tables
-- Go to: https://app.supabase.com/projects/[project-id]/sql

-- Create laundries table
CREATE TABLE IF NOT EXISTS public.laundries (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  image TEXT,
  rating NUMERIC DEFAULT 0,
  review_count INTEGER DEFAULT 0,
  distance TEXT,
  is_open BOOLEAN DEFAULT true,
  is_active BOOLEAN DEFAULT true,
  open_time TEXT,
  close_time TEXT,
  services TEXT[] DEFAULT '{}',
  description TEXT,
  latitude NUMERIC,
  longitude NUMERIC,
  phone_number TEXT,
  email TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create services table
CREATE TABLE IF NOT EXISTS public.services (
  id TEXT PRIMARY KEY,
  laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC NOT NULL,
  category TEXT,
  duration_hours INTEGER,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create offers table
CREATE TABLE IF NOT EXISTS public.offers (
  id TEXT PRIMARY KEY,
  laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  discount_percentage NUMERIC,
  discount_amount NUMERIC,
  min_order NUMERIC,
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table (uses auth.uid() for user_id)
CREATE TABLE IF NOT EXISTS public.orders (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
  items JSONB,
  total_price NUMERIC NOT NULL,
  status TEXT DEFAULT 'pending',
  delivery_address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create reviews table (uses auth.uid() for user_id)
CREATE TABLE IF NOT EXISTS public.reviews (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL,
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create favorites table (uses auth.uid() for user_id)
CREATE TABLE IF NOT EXISTS public.favorites (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, laundry_id)
);

-- Enable RLS (Row Level Security)
ALTER TABLE public.laundries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.offers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for public read access (no auth needed)
CREATE POLICY "Enable read access for laundries" ON public.laundries FOR SELECT USING (true);
CREATE POLICY "Enable read access for services" ON public.services FOR SELECT USING (true);
CREATE POLICY "Enable read access for offers" ON public.offers FOR SELECT USING (true);
CREATE POLICY "Enable read access for reviews" ON public.reviews FOR SELECT USING (true);

-- Create RLS policies for authenticated users
CREATE POLICY "Enable insert for authenticated users" ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Enable read for authenticated users" ON public.orders FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Enable insert for authenticated users" ON public.favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Enable read for authenticated users" ON public.favorites FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Enable delete for authenticated users" ON public.favorites FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Enable insert for authenticated users" ON public.reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Enable read for authenticated users" ON public.reviews FOR SELECT USING (true);
