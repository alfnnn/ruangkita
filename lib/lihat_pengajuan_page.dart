import 'package:flutter/material.dart';
import 'services/supabase_service.dart';

class LihatPengajuanPage extends StatefulWidget {
  const LihatPengajuanPage({super.key});

  @override
  _LihatPengajuanPageState createState() => _LihatPengajuanPageState();
}

class _LihatPengajuanPageState extends State<LihatPengajuanPage> {
  List<Map<String, dynamic>> daftarPengajuan = [];

  @override
  void initState() {
    super.initState();
    fetchPengajuan();
  }

  Future<void> fetchPengajuan() async {
    final supabase = SupabaseService.client;
    final data = await supabase.from('reservasi_ruangan').select();
    setState(() {
      daftarPengajuan = List<Map<String, dynamic>>.from(data);
    });
  }

  Future<void> _updateStatus(int index, String status) async {
    final supabase = SupabaseService.client;
    final id = daftarPengajuan[index]['id'];
    await supabase.from('reservasi_ruangan').update({'status': status}).eq('id', id);
    fetchPengajuan();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pengajuan ${status == 'Disetujui' ? 'disetujui' : 'ditolak'}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // warna biru muda
      appBar: AppBar(
        backgroundColor: Colors.blue, // warna biru
        title: const Text('Lihat Pengajuan'),
        centerTitle: true,
      ),
      body: daftarPengajuan.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada pengajuan.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: daftarPengajuan.length,
              itemBuilder: (context, index) {
                final pengajuan = daftarPengajuan[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        Text('Ruangan: ${pengajuan['ruangan']}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Tanggal: ${pengajuan['tanggal']}'),
                        Text('Jam: ${pengajuan['jam']}'),
                        Text('Keperluan: ${pengajuan['keperluan']}'),
                        Text('Status: ${pengajuan['status']}'),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.check, size: 16),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800], // biru tua
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => _updateStatus(index, 'Disetujui'),
                              label: const Text('Setuju'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.close, size: 16),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey, // abu kebiruan
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => _updateStatus(index, 'Ditolak'),
                              label: const Text('Tolak'),
                            ),
                          ],
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
