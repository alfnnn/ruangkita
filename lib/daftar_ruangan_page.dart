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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Ruangan Tersedia'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFF8E1),
      body: daftarRuangan.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: daftarRuangan.length,
              itemBuilder: (context, index) {
                final ruangan = daftarRuangan[index];
                final jadwal = jadwalRuangan[ruangan['nama']] ?? [];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ruangan['nama'] ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('Kapasitas: ${ruangan['kapasitas'] ?? '-'}'),
                        Text('Lokasi: ${ruangan['lokasi'] ?? '-'}'),
                        const SizedBox(height: 8),
                        const Text('Jadwal Terpakai:', style: TextStyle(fontWeight: FontWeight.bold)),
                        if (jadwal.isEmpty)
                          const Text('Belum ada jadwal terpakai', style: TextStyle(color: Colors.green)),
                        ...jadwal.map((j) => Text(
                              '- ${j['tanggal']} | ${j['jam']}',
                              style: const TextStyle(color: Colors.red),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
