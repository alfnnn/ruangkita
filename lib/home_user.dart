import 'package:flutter/material.dart';
import 'login_page.dart';
import 'ajukan_peminjaman.dart';
import 'riwayat_peminjaman.dart';
import 'daftar_ruangan_page.dart';

class UserPage extends StatelessWidget {
  final String namaUser;
  const UserPage({super.key, required this.namaUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Background biru muda modern
      appBar: AppBar(
        title: const Text('USER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
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
                  child: Icon(Icons.person, color: Colors.blue.shade400, size: 44),
                ),
                const SizedBox(height: 12),
                Text(
                  'Halo, $namaUser!',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF1976D2)),
                ),
                const SizedBox(height: 28),
                // Ajukan Peminjaman
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AjukanPage(namaUser: namaUser)),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue, width: 1.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.calendar_month, color: Colors.blue, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Ajukan Peminjaman',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Riwayat Peminjaman
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RiwayatPage(namaUser: namaUser)),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green, width: 1.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.history, color: Colors.green, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Riwayat Peminjaman',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Daftar Ruangan
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DaftarRuanganPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                      margin: const EdgeInsets.only(bottom: 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.deepOrange, width: 1.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.meeting_room, color: Colors.deepOrange, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Daftar Ruangan',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Tombol Logout
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
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                  ),
                ),
                const Divider(height: 30, thickness: 1.2),
                // Kontak Admin/CS
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
}
