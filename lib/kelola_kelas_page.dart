import 'package:flutter/material.dart';

class KelolaKelasPage extends StatefulWidget {
  @override
  _KelolaKelasPageState createState() => _KelolaKelasPageState();
}

class _KelolaKelasPageState extends State<KelolaKelasPage> {
  List<Map<String, String>> daftarKelas = [
    {'nama': 'R.301', 'kapasitas': '30'},
    {'nama': 'R.202', 'kapasitas': '25'},
  ];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  int? editIndex;

  void _simpanData() {
    final nama = namaController.text.trim();
    final kapasitas = kapasitasController.text.trim();

    if (nama.isEmpty || kapasitas.isEmpty) return;

    setState(() {
      if (editIndex == null) {
        daftarKelas.add({'nama': nama, 'kapasitas': kapasitas});
      } else {
        daftarKelas[editIndex!] = {'nama': nama, 'kapasitas': kapasitas};
        editIndex = null;
      }
      namaController.clear();
      kapasitasController.clear();
    });
  }

  void _editKelas(int index) {
    final data = daftarKelas[index];
    namaController.text = data['nama']!;
    kapasitasController.text = data['kapasitas']!;
    setState(() {
      editIndex = index;
    });
  }

  void _hapusKelas(int index) {
    setState(() {
      daftarKelas.removeAt(index);
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    kapasitasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Kelola Data Kelas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Kelas (misal: R.101)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: kapasitasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kapasitas',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(editIndex == null ? Icons.add : Icons.save),
              label: Text(editIndex == null ? 'Tambah Kelas' : 'Simpan Perubahan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _simpanData,
            ),
            const SizedBox(height: 20),
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
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                              kelas['nama']!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Kapasitas: ${kelas['kapasitas']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => _editKelas(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _hapusKelas(index),
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
