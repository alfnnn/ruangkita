import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'services/supabase_service.dart';

class KelolaKelasPage extends StatefulWidget {
  @override
  _KelolaKelasPageState createState() => _KelolaKelasPageState();
}

class _KelolaKelasPageState extends State<KelolaKelasPage> {
  List<Map<String, dynamic>> daftarKelas = [];
  String? editId;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchKelas();
  }

  Future<void> fetchKelas() async {
    final supabase = SupabaseService.client;
    final data = await supabase.from('ruangan').select('id, nama, kapasitas');
    setState(() {
      daftarKelas = List<Map<String, dynamic>>.from(data);
    });
  }

  void _simpanData() async {
    final nama = namaController.text.trim();
    final kapasitas = kapasitasController.text.trim();
    final lokasi = lokasiController.text.trim();

    if (nama.isEmpty || kapasitas.isEmpty || lokasi.isEmpty) return;

    final supabase = SupabaseService.client;
    try {
      if (editId == null) {
        final response = await supabase.from('ruangan').insert({
          'nama': nama,
          'kapasitas': int.tryParse(kapasitas) ?? 0,
          'lokasi': lokasi,
        }).select();
        debugPrint('Insert response: ' + response.toString());
      } else {
        final response = await supabase.from('ruangan').update({
          'nama': nama,
          'kapasitas': int.tryParse(kapasitas) ?? 0,
          'lokasi': lokasi,
        }).eq('id', editId ?? '').select();
        debugPrint('Update response: ' + response.toString());
        editId = null;
      }
      namaController.clear();
      kapasitasController.clear();
      lokasiController.clear();
      fetchKelas();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data kelas berhasil disimpan!')),
      );
    } catch (e) {
      debugPrint('Supabase error: ' + e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: ${e.toString()}')),
      );
    }
  }

  void _editKelas(int index) {
    final data = daftarKelas[index];
    namaController.text = data['nama'] ?? '';
    kapasitasController.text = (data['kapasitas'] ?? '').toString();
    lokasiController.text = data['lokasi'] ?? '';
    setState(() {
      editId = data['id'] as String?;
    });
  }

  void _hapusKelas(int index) async {
    final id = daftarKelas[index]['id'];
    final supabase = SupabaseService.client;
    await supabase.from('ruangan').delete().eq('id', id);
    fetchKelas();
  }

  @override
  void dispose() {
    namaController.dispose();
    kapasitasController.dispose();
    lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // biru muda
      appBar: AppBar(
        backgroundColor: Colors.blue, // biru
        title: const Text('Kelola Data Kelas'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Kelas (misal: R.101)',
                      prefixIcon: const Icon(Icons.class_, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: kapasitasController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Kapasitas',
                      prefixIcon: const Icon(Icons.people, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: lokasiController,
                    decoration: InputDecoration(
                      labelText: 'Lokasi',
                      prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: Icon(editId == null ? Icons.add : Icons.save),
                    label: Text(editId == null ? 'Tambah Kelas' : 'Simpan Perubahan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                    ),
                    onPressed: _simpanData,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            Expanded(
              child: daftarKelas.isEmpty
                  ? const Center(child: Text('Belum ada data kelas.'))
                  : ListView.builder(
                      itemCount: daftarKelas.length,
                      itemBuilder: (context, index) {
                        final kelas = daftarKelas[index];
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.blue[100]!, width: 1),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: const Icon(Icons.class_, color: Colors.blue),
                            ),
                            title: Text(
                              kelas['nama'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text('Kapasitas: ${kelas['kapasitas'] ?? ''}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editKelas(index),
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () => _hapusKelas(index),
                                  tooltip: 'Hapus',
                                ),
                              ],
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
