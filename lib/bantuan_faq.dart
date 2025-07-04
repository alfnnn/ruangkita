import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pertanyaan yang Sering Diajukan (FAQ)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildFAQItem(
            'Bagaimana cara mengelola data kelas?',
            'Masuk ke menu "Kelola Data Kelas", lalu klik tombol tambah untuk menambah kelas baru, atau klik icon edit untuk mengubah data kelas.',
          ),
          _buildFAQItem(
            'Bagaimana cara menyetujui pengajuan?',
            'Pilih menu "Lihat Pengajuan", lalu klik pengajuan yang ingin diproses. Admin dapat menyetujui atau menolak pengajuan.',
          ),
          _buildFAQItem(
            'Apa itu menu Lihat Ruangan?',
            'Menu ini digunakan untuk melihat daftar ruangan yang tersedia beserta kapasitas dan fasilitasnya.',
          ),
          _buildFAQItem(
            'Siapa yang bisa mengakses aplikasi ini?',
            'Saat ini hanya admin dan pengguna terdaftar yang bisa mengakses aplikasi ini.',
          ),
          _buildFAQItem(
            'Bagaimana jika saya lupa logout?',
            'Sistem akan otomatis mengeluarkan pengguna setelah waktu tertentu atau Anda bisa tekan tombol Logout secara manual.',
          ),

          const SizedBox(height: 24),
          const Divider(),
          const Text(
            'Butuh bantuan lebih lanjut? Hubungi:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Email: support@ruangkita.com'),
          const Text('WhatsApp: +62 812 3456 7890'),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Text(answer),
        ),
      ],
    );
  }
}
