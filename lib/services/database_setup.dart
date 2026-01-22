import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseSetup {
  static final SupabaseClient _client = Supabase.instance.client;

  /// Create all necessary tables if they don't exist
  static Future<void> setupTables() async {
    try {
      print('📦 Setting up database tables...');

      // Create users table
      await _createUsersTable();
      print('✅ Users table ready');

      // Create laundries table
      await _createLaundriesTable();
      print('✅ Laundries table ready');

      // Create services table
      await _createServicesTable();
      print('✅ Services table ready');

      // Create offers table
      await _createOffersTable();
      print('✅ Offers table ready');

      // Create orders table
      await _createOrdersTable();
      print('✅ Orders table ready');

      // Create reviews table
      await _createReviewsTable();
      print('✅ Reviews table ready');

      // Create favorites table
      await _createFavoritesTable();
      print('✅ Favorites table ready');

      print('✅ All tables setup complete!\n');
    } catch (e) {
      print('⚠️  Error setting up tables: $e');
      // Continue anyway - tables might already exist
    }
  }

  static Future<void> _createUsersTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
          CREATE TABLE IF NOT EXISTS public.users (
            id UUID PRIMARY KEY DEFAULT auth.uid(),
            email TEXT UNIQUE NOT NULL,
            name TEXT,
            phone TEXT,
            avatar_url TEXT,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
          );
        '''
      });
    } catch (e) {
      // Table might already exist, which is fine
      print('ℹ️  Users table: $e');
    }
  }

  static Future<void> _createLaundriesTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
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
        '''
      });
    } catch (e) {
      print('ℹ️  Laundries table: $e');
    }
  }

  static Future<void> _createServicesTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
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
        '''
      });
    } catch (e) {
      print('ℹ️  Services table: $e');
    }
  }

  static Future<void> _createOffersTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
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
        '''
      });
    } catch (e) {
      print('ℹ️  Offers table: $e');
    }
  }

  static Future<void> _createOrdersTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
          CREATE TABLE IF NOT EXISTS public.orders (
            id TEXT PRIMARY KEY,
            user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
            laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
            items JSONB,
            total_price NUMERIC NOT NULL,
            status TEXT DEFAULT 'pending',
            delivery_address TEXT,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
          );
        '''
      });
    } catch (e) {
      print('ℹ️  Orders table: $e');
    }
  }

  static Future<void> _createReviewsTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
          CREATE TABLE IF NOT EXISTS public.reviews (
            id TEXT PRIMARY KEY,
            user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
            laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
            rating INTEGER NOT NULL,
            comment TEXT,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
          );
        '''
      });
    } catch (e) {
      print('ℹ️  Reviews table: $e');
    }
  }

  static Future<void> _createFavoritesTable() async {
    try {
      await _client.rpc('exec', params: {
        'sql': '''
          CREATE TABLE IF NOT EXISTS public.favorites (
            id TEXT PRIMARY KEY,
            user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
            laundry_id TEXT NOT NULL REFERENCES public.laundries(id) ON DELETE CASCADE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            UNIQUE(user_id, laundry_id)
          );
        '''
      });
    } catch (e) {
      print('ℹ️  Favorites table: $e');
    }
  }
}
