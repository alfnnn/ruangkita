import 'package:flutter/material.dart';

class AjukanPage extends StatelessWidget {
  const AjukanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController nimController = TextEditingController();
    final TextEditingController kelasController = TextEditingController();
    final TextEditingController ruanganController = TextEditingController();
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController jamController = TextEditingController();
    final TextEditingController keperluanController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Ajukan Peminjaman'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(100),
                1: FlexColumnWidth(),
              },
              children: [
                _buildRow('Nama', namaController),
                _buildRow('NIM', nimController),
                _buildRow('Kelas', kelasController),
                _buildRow('Ruangan', ruanganController),
                _buildRow('Tanggal', tanggalController),
                _buildRow('Jam', jamController),
                _buildRow('Keperluan', keperluanController),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Peminjaman berhasil diajukan')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text('Ajukan'),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String label, TextEditingController controller) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(label),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan $label',
          ),
        ),
      ),
    ]);
  }
}
