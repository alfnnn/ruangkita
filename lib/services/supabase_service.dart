import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://atzoxkghjwbddeaapynm.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0em94a2doandiZGRlYWFweW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA2OTM3MTQsImV4cCI6MjA2NjI2OTcxNH0.N_0j-A--DstkeRyOwRs5RiLZGFrVEiw9BNXoIw4WCJs';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
