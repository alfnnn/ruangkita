import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'RuangKita',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Aplikasi ini dibuat untuk memudahkan proses peminjaman ruangan secara online di lingkungan kampus.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text('Versi Aplikasi: 1.0.0', style: TextStyle(fontSize: 16)),
            Text('Dibuat oleh: Tim RuangKita', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
