import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'splashscreen.dart'; // 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Peminjaman',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SplashScreen(), // Ganti LoginPage ke SplashScreen
    );
  }
}
