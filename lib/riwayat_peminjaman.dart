import 'package:flutter/material.dart';
import 'services/supabase_service.dart';

class RiwayatPage extends StatefulWidget {
  final String namaUser;
  const RiwayatPage({super.key, required this.namaUser});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<Map<String, dynamic>> riwayat = [];

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  Future<void> fetchRiwayat() async {
    final supabase = SupabaseService.client;
    final data = await supabase
        .from('reservasi_ruangan')
        .select('tanggal, ruangan, status, nama')
        .eq('nama', widget.namaUser)
        .order('tanggal', ascending: false);
    setState(() {
      riwayat = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Riwayat Peminjaman', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 90),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
              color: const Color(0xFF1976D2),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.history, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Text(
                      'Riwayat Peminjaman',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: riwayat.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 90, color: Colors.blue.shade200),
                        const SizedBox(height: 20),
                        const Text('Belum ada riwayat peminjaman.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      itemCount: riwayat.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = riwayat[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(color: Colors.blue.shade100, width: 1.2),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFF1976D2),
                                  radius: 26,
                                  child: const Icon(Icons.meeting_room, color: Colors.white, size: 28),
                                ),
                                title: Text(
                                  item['ruangan']?.toString() ?? '-',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1976D2)),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range, size: 16, color: Colors.blue.shade400),
                                      const SizedBox(width: 4),
                                      Text(item['tanggal']?.toString() ?? '-', style: const TextStyle(fontSize: 15)),
                                      const SizedBox(width: 16),
                                      Icon(Icons.verified, size: 16, color: item['status'] == 'Disetujui' ? Colors.green : Colors.orange),
                                      const SizedBox(width: 4),
                                      Text(item['status']?.toString() ?? '-', style: TextStyle(fontSize: 15, color: item['status'] == 'Disetujui' ? Colors.green : Colors.orange)),
                                    ],
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    // Action on trailing icon press
                                  },
                                  icon: const Icon(Icons.more_horiz, color: Color(0xFF1976D2), size: 26),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
