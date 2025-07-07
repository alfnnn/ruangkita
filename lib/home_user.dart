import 'package:flutter/material.dart';
import 'login_page.dart';
import 'ajukan_peminjaman.dart';
import 'riwayat_peminjaman.dart';
import 'daftar_ruangan_page.dart';
import 'bantuan_faq.dart';
import 'tentang_aplikasi_page.dart'; // ✅ Tambahan import

class UserPage extends StatelessWidget {
  final String namaUser;
  const UserPage({super.key, required this.namaUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text(
          'USER',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.person,
                    color: Colors.blue.shade400,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Halo, $namaUser!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 28),

                // Ajukan Peminjaman
                _menuButton(
                  icon: Icons.calendar_month,
                  label: 'Ajukan Peminjaman',
                  borderColor: Colors.blue,
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AjukanPage(namaUser: namaUser),
                      ),
                    );
                  },
                ),

                // Riwayat Peminjaman
                _menuButton(
                  icon: Icons.history,
                  label: 'Riwayat Peminjaman',
                  borderColor: Colors.green,
                  iconColor: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RiwayatPage(namaUser: namaUser),
                      ),
                    );
                  },
                ),

                // Daftar Ruangan
                _menuButton(
                  icon: Icons.meeting_room,
                  label: 'Daftar Ruangan',
                  borderColor: Colors.deepOrange,
                  iconColor: Colors.deepOrange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DaftarRuanganPage(),
                      ),
                    );
                  },
                ),

                // Pusat Bantuan
                _menuButton(
                  icon: Icons.help_outline,
                  label: 'Pusat Bantuan',
                  borderColor: Colors.deepPurple,
                  iconColor: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BantuanUserPage(),
                      ),
                    );
                  },
                ),

                // ✅ Tambahan: Tentang Aplikasi
                _menuButton(
                  icon: Icons.info_outline,
                  label: 'Tentang Aplikasi',
                  borderColor: Colors.indigo,
                  iconColor: Colors.indigo,
                  onTap: () {
                    Navigator.pushNamed(context, '/tentang');
                  },
                ),

                // Logout
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),

                const Divider(height: 30, thickness: 1.2),

                // Kontak Admin
                const Text(
                  'Kontak Admin:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, size: 16, color: Colors.black54),
                    SizedBox(width: 6),
                    Text('0812-3456-7890', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email, size: 16, color: Colors.black54),
                    SizedBox(width: 6),
                    Text('admin@kampus.ac.id', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Komponen tombol menu
  Widget _menuButton({
    required IconData icon,
    required String label,
    required Color borderColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.3),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
