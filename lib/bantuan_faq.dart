import 'package:flutter/material.dart';

class BantuanUserPage extends StatelessWidget {
  const BantuanUserPage({super.key});

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
            'Bantuan Pengguna',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildFeatureSection('Ajukan Peminjaman', [
            {
              'q': 'Bagaimana cara mengajukan peminjaman?',
              'a':
                  'Klik tombol "Ajukan Peminjaman", lalu isi form peminjaman sesuai kebutuhan dan kirimkan.',
            },
            {
              'q': 'Apakah saya bisa memilih tanggal tertentu?',
              'a':
                  'Ya, pilih tanggal dan waktu yang tersedia saat mengisi form.',
            },
            {
              'q': 'Kapan pengajuan saya disetujui?',
              'a':
                  'Pengajuan akan diperiksa oleh admin. Anda akan mendapat notifikasi saat disetujui atau ditolak.',
            },
          ]),

          _buildFeatureSection('Riwayat Peminjaman', [
            {
              'q': 'Apa itu riwayat peminjaman?',
              'a':
                  'Halaman ini menampilkan daftar semua peminjaman yang pernah Anda ajukan.',
            },
            {
              'q': 'Mengapa status saya masih "Menunggu"?',
              'a':
                  'Artinya pengajuan Anda belum diproses oleh admin. Tunggu konfirmasi lebih lanjut.',
            },
            {
              'q': 'Apakah saya bisa membatalkan pengajuan?',
              'a':
                  'Jika fitur tersedia, Anda bisa klik tombol "Batalkan" pada pengajuan yang masih diproses.',
            },
          ]),

          _buildFeatureSection('Daftar Ruangan', [
            {
              'q': 'Apa yang ditampilkan di daftar ruangan?',
              'a':
                  'Anda dapat melihat semua ruangan yang tersedia beserta kapasitas dan fasilitasnya.',
            },
            {
              'q': 'Bagaimana tahu ruangan sedang dipakai?',
              'a':
                  'Biasanya akan ada indikator atau status di tiap ruangan jika sedang digunakan.',
            },
          ]),

          const SizedBox(height: 24),
          const Divider(),
          const Text(
            'Butuh bantuan lebih lanjut? Hubungi:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Email: bantuan@ruangkita.com'),
          const Text('WhatsApp: +62 812 3456 7890'),
        ],
      ),
    );
  }

  Widget _buildFeatureSection(String title, List<Map<String, String>> faqList) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      children:
          faqList.map((faq) {
            return ListTile(
              title: Text(faq['q']!),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(faq['a']!),
              ),
            );
          }).toList(),
    );
  }
}
