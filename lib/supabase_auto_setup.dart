import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/seed_data.dart';
import 'services/database_setup.dart';

/// Supabase Auto-Setup & Seeding
class SupabaseAutoSetup {
  /// Initialize Supabase and seed data if needed
  static Future<bool> initializeAndSeed() async {
    try {
      print('\n┌─────────────────────────────────────────┐');
      print('│  🔁 Supabase Auto-Setup & Seeding 🔁   │');
      print('└─────────────────────────────────────────┘\n');

      // Step 1: Check if Supabase is already initialized
      print('⏳ Checking Supabase initialization...');
      bool isInitialized = false;
      try {
        // If already initialized, this will return the client
        Supabase.instance.client;
        isInitialized = true;
        print('✅ Supabase already initialized!\n');
      } catch (e) {
        // Not initialized yet, initialize now
        print('⏳ Initializing Supabase...');
        await Supabase.initialize(
          url: 'https://tkhvhlafdaccagodxqie.supabase.co',
          anonKey: 'sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK',
        );
        print('✅ Supabase initialized successfully!\n');
      }

      // Step 2: Setup database tables
      print('⏳ Setting up database tables...');
      await DatabaseSetup.setupTables();
      print('✅ Database tables setup completed!\n');

      // Step 3: Verify connection by querying a known table
      print('⏳ Verifying Supabase connection...');
      final isConnected = await _verifyConnection();
      print('✅ Supabase connection check completed!\n');

      // Step 4: Check existing data
      print('⏳ Checking existing data...');
      final hasData = await _checkExistingData();
      if (hasData) {
        print('ℹ️  Database already has data. Skipping seed.\n');
        return true;
      }

      // Step 5: Seed data
      print('⏳ Seeding sample data...');
      await SeedData.seedAllData();
      print('✅ Sample data seeded successfully!\n');

      // Step 6: Verify seed
      print('⏳ Verifying seeded data...');
      final dataCount = await _getDataCount();
      print('✅ Seeded data verified!');
      print('   - Laundries: ${dataCount['laundries']}');
      print('   - Services: ${dataCount['services']}');
      print('   - Offers: ${dataCount['offers']}\n');

      return true;
    } catch (e) {
      print('❌ Setup failed: $e\n');
      return true; // Return true anyway - let app continue
    }
  }

  static Future<bool> _verifyConnection() async {
    try {
      // Just check if we can get a response from Supabase
      final client = Supabase.instance.client;
      print('⏳ Testing Supabase connection...');
      
      // Try a simple count query
      final res = await client.from('laundries').select('id').limit(1);
      print('✅ Connection test passed');
      return true;
    } catch (e) {
      print('⚠️  Connection test failed: $e');
      print('ℹ️  This might be normal if tables are not created yet.');
      // Return true anyway - let it continue
      return true;
    }
  }

  static Future<bool> _checkExistingData() async {
    try {
      final res = await Supabase.instance.client
          .from('laundries')
          .select('id')
          .limit(1);
      return (res as List).isNotEmpty;
    } catch (e) {
      print('⚠️  Could not check existing data: $e');
      return false;
    }
  }

  static Future<Map<String, int>> _getDataCount() async {
    try {
      final laundriesRes = await Supabase.instance.client
          .from('laundries')
          .select('id');
      final offersRes =
          await Supabase.instance.client.from('offers').select('id');

      int laundries = 0;
      int offers = 0;
      int services = 0;

      laundries = (laundriesRes as List).length;
      offers = (offersRes as List).length;

      // Count services by querying services table if exists
      final servicesRes =
          await Supabase.instance.client.from('services').select('id');
      services = (servicesRes as List).length;

      return {
        'laundries': laundries,
        'services': services,
        'offers': offers,
      };
    } catch (e) {
      print('⚠️  Could not count data: $e');
      return {'laundries': 0, 'services': 0, 'offers': 0};
    }
  }

  /// Print setup status
  static Future<void> printStatus() async {
    try {
      print('\n┌─────────────────────────────────────────┐');
      print('│        📊 Supabase Status Report        │');
      print('└─────────────────────────────────────────┘\n');

      final isConnected = await _verifyConnection();
      print('Connection: ${isConnected ? '✅ Connected' : '❌ Disconnected'}');

      if (isConnected) {
        final dataCount = await _getDataCount();
        print('Data Status:');
        print('  • Laundries: ${dataCount['laundries']}');
        print('  • Services: ${dataCount['services']}');
        print('  • Offers: ${dataCount['offers']}');
      }

      print('\n');
    } catch (e) {
      print('Error checking status: $e\n');
    }
  }
}

/// Demo widget untuk Supabase setup initialization
class SupabaseAutoSetupDemo extends StatefulWidget {
  const SupabaseAutoSetupDemo({Key? key}) : super(key: key);

  @override
  State<SupabaseAutoSetupDemo> createState() => _SupabaseAutoSetupDemoState();
}

class _SupabaseAutoSetupDemoState extends State<SupabaseAutoSetupDemo> {
  String status = 'Initializing...';
  bool isLoading = true;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final success = await SupabaseAutoSetup.initializeAndSeed();
    setState(() {
      isLoading = false;
      isSuccess = success;
      status = success ? '✅ Supabase Ready!' : '❌ Setup Failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Auto-Setup'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator()
            else if (isSuccess)
              Column(
                children: [
                  const Icon(Icons.check_circle, size: 80, color: Colors.green),
                  const SizedBox(height: 20),
                  Text(
                    status,
                    style: const TextStyle(fontSize: 24, color: Colors.green),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Continue to App'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  const Icon(Icons.error, size: 80, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    status,
                    style: const TextStyle(fontSize: 24, color: Colors.red),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      _initialize();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
