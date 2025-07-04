import 'package:flutter/material.dart';
import 'services/supabase_service.dart';

class DaftarRuanganPage extends StatefulWidget {
  const DaftarRuanganPage({super.key});

  @override
  State<DaftarRuanganPage> createState() => _DaftarRuanganPageState();
}

class _DaftarRuanganPageState extends State<DaftarRuanganPage> {
  List<Map<String, dynamic>> daftarRuangan = [];
  Map<String, List<Map<String, dynamic>>> jadwalRuangan = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRuangan();
  }

  Future<void> fetchRuangan() async {
    final supabase = SupabaseService.client;
    final ruanganData = await supabase.from('ruangan').select();
    final reservasiData = await supabase.from('reservasi_ruangan')
        .select('ruangan, tanggal, jam, status')
        .eq('status', 'Disetujui');
    setState(() {
      daftarRuangan = List<Map<String, dynamic>>.from(ruanganData);
      jadwalRuangan = {};
      for (var reservasi in reservasiData) {
        final nama = reservasi['ruangan'] as String;
        if (!jadwalRuangan.containsKey(nama)) {
          jadwalRuangan[nama] = [];
        }
        jadwalRuangan[nama]!.add(reservasi);
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Daftar Ruangan'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: daftarRuangan.length,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              itemBuilder: (context, index) {
                final ruangan = daftarRuangan[index];
                final jadwal = jadwalRuangan[ruangan['nama']] ?? [];
                final isKosong = jadwal.isEmpty;
                final statusColor = isKosong ? Colors.green[600] : Colors.red[600];
                final statusText = isKosong ? 'Tersedia' : 'Terpakai';
                final statusBg = isKosong ? Colors.blue[50] : Colors.red[50];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isKosong ? Colors.blue[100] : Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            isKosong ? Icons.meeting_room : Icons.meeting_room_outlined,
                            color: isKosong ? Colors.blue[700] : Colors.red[700],
                            size: 36,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ruangan['nama'] ?? '-',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: statusBg,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      statusText,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Status: ${isKosong ? 'Kosong' : 'Isi'}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Kapasitas: ${ruangan['kapasitas'] ?? '-'}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                'Lokasi: ${ruangan['lokasi'] ?? '-'}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              if (jadwal.isNotEmpty)
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Jadwal Terpakai - ${ruangan['nama'] ?? '-'}'),
                                        content: SizedBox(
                                          width: 300,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              ...jadwal.map((j) => ListTile(
                                                    leading: const Icon(Icons.schedule, color: Colors.red),
                                                    title: Text('${j['tanggal']} | ${j['jam']}', style: const TextStyle(color: Colors.red)),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Tutup'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('Lihat Jadwal'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
