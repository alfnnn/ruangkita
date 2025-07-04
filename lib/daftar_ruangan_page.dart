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
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: daftarRuangan.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isWide ? 1.7 : 2.7,
                  ),
                  itemCount: daftarRuangan.length,
                  itemBuilder: (context, index) {
                    final ruangan = daftarRuangan[index];
                    final jadwal = jadwalRuangan[ruangan['nama']] ?? [];
                    final tersedia = jadwal.isEmpty;
                    final statusColor = tersedia ? Colors.blue[700] : Colors.red[700];
                    final statusBg = tersedia ? Colors.blue[50] : Colors.red[50];
                    final statusText = tersedia ? 'Tersedia' : 'Terpakai';
                    return Card(
                      elevation: 6,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: statusBg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.meeting_room,
                                    color: statusColor,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    ruangan['nama'] ?? '-',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: statusBg,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.people, size: 16, color: Colors.blueGrey),
                                const SizedBox(width: 4),
                                Text('Kapasitas: ${ruangan['kapasitas'] ?? '-'}', style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.blueGrey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text('Lokasi: ${ruangan['lokasi'] ?? '-'}', style: const TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue[800],
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                icon: const Icon(Icons.schedule),
                                label: const Text('Lihat Jadwal'),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Jadwal Terpakai - ${ruangan['nama'] ?? '-'}'),
                                      content: jadwal.isEmpty
                                          ? const Text('Belum ada jadwal terpakai', style: TextStyle(color: Colors.green))
                                          : SizedBox(
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
