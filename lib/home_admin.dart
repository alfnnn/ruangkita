import 'package:flutter/material.dart';
import 'lihat_pengajuan_page.dart';
import 'kelola_kelas_page.dart';
import 'daftar_ruangan.dart';
import 'bantuan_faq.dart';
import 'services/supabase_service.dart';

class HomeAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Beranda Admin'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.blue[100],
                child: const Icon(
                  Icons.admin_panel_settings,
                  size: 54,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Selamat Datang, Admin!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kelola data ruangan, kelas, dan pengajuan dengan mudah.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _adminButton(
                      context,
                      icon: Icons.assignment,
                      label: 'Lihat Pengajuan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LihatPengajuanPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _adminButton(
                      context,
                      icon: Icons.class_,
                      label: 'Kelola Data Kelas',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KelolaKelasPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _adminButton(
                      context,
                      icon: Icons.meeting_room,
                      label: 'Lihat Ruangan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarRuanganPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _adminButton(
                      context,
                      icon: Icons.help_outline,
                      label: 'Pusat Bantuan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BantuanPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await SupabaseService.client.auth.signOut();
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/', (route) => false);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal logout: \n${e.toString()}'),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _adminButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
        ),
        icon: Icon(icon, size: 28),
        label: Text(label),
        onPressed: onTap,
      ),
    );
  }
}
