import 'package:flutter/material.dart';
import 'login_page.dart';
import 'ajukan_peminjaman.dart';
import 'riwayat_peminjaman.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Background lembut
      appBar: AppBar(
        title: const Text('USER'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Ajukan Peminjaman
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AjukanPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_month, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'Ajukan Peminjaman',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Riwayat Peminjaman
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RiwayatPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.history, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Riwayat Peminjaman',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Tombol Logout
              TextButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),

              const Divider(height: 40, thickness: 1.5),

              // Kontak Admin/CS
              const Text(
                'Kontak Admin:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text('📞 0812-3456-7890', style: TextStyle(fontSize: 14)),
              const Text('✉️ admin@kampus.ac.id', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
