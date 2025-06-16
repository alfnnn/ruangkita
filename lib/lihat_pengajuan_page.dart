import 'package:flutter/material.dart';

class LihatPengajuanPage extends StatefulWidget {
  const LihatPengajuanPage({super.key});

  @override
  _LihatPengajuanPageState createState() => _LihatPengajuanPageState();
}

class _LihatPengajuanPageState extends State<LihatPengajuanPage> {
  List<Map<String, String>> daftarPengajuan = [
    {
      'ruangan': 'R.301',
      'tanggal': '2025-06-10',
      'jam': '09:00 - 11:00',
      'keperluan': 'Rapat Proyek',
      'status': 'Pending'
    },
    {
      'ruangan': 'R.202',
      'tanggal': '2025-06-11',
      'jam': '13:00 - 15:00',
      'keperluan': 'Presentasi',
      'status': 'Pending'
    },
  ];

  void _setujuiPengajuan(int index) {
    setState(() {
      daftarPengajuan.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan disetujui')),
    );
  }

  void _tolakPengajuan(int index) {
    setState(() {
      daftarPengajuan.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan ditolak')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // warna latar belakang
      appBar: AppBar(
        backgroundColor: Colors.orange,
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
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => _setujuiPengajuan(index),
                              label: const Text('Setuju'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.close, size: 16),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => _tolakPengajuan(index),
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
