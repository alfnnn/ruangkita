import 'package:flutter/material.dart';

import 'services/supabase_service.dart';

class AjukanPage extends StatefulWidget {
  const AjukanPage({super.key});

  @override
  State<AjukanPage> createState() => _AjukanPageState();
}

class _AjukanPageState extends State<AjukanPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController ruanganController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jamController = TextEditingController();
  final TextEditingController keperluanController = TextEditingController();
  final FocusNode tanggalFocus = FocusNode();
  final FocusNode jamFocus = FocusNode();

  List<Map<String, dynamic>> ruanganList = [];
  String? selectedRuangan;

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    kelasController.dispose();
    ruanganController.dispose();
    tanggalController.dispose();
    jamController.dispose();
    keperluanController.dispose();
    tanggalFocus.dispose();
    jamFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchRuangan();
  }

  Future<void> fetchRuangan() async {
    final supabase = SupabaseService.client;
    final data = await supabase.from('ruangan').select('id, nama');
    setState(() {
      ruanganList = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('Ruangan'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField<String>(
                        value: selectedRuangan,
                        items: ruanganList.map<DropdownMenuItem<String>>((r) => DropdownMenuItem<String>(
                          value: r['nama'] as String,
                          child: Text(r['nama'] as String),
                        )).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedRuangan = val;
                            ruanganController.text = val ?? '';
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Pilih Ruangan',
                        ),
                      ),
                    ),
                  ],
                ),
                _buildRow('Tanggal', tanggalController, focusNode: tanggalFocus, onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      tanggalController.text = picked.toIso8601String().split('T')[0];
                    });
                  }
                }),
                _buildRow('Jam', jamController, focusNode: jamFocus, onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      jamController.text = picked.format(context);
                    });
                  }
                }),
                _buildRow('Keperluan', keperluanController),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final nama = namaController.text.trim();
                final nim = nimController.text.trim();
                final kelas = kelasController.text.trim();
                final ruangan = ruanganController.text.trim();
                final tanggal = tanggalController.text.trim();
                final jam = jamController.text.trim();
                final keperluan = keperluanController.text.trim();

                if ([nama, nim, kelas, ruangan, tanggal, jam].any((e) => e.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semua field wajib diisi!')),
                  );
                  return;
                }
                try {
                  final supabase = SupabaseService.client;
                  await supabase.from('reservasi_ruangan').insert({
                    'nama': nama,
                    'nim': nim,
                    'kelas': kelas,
                    'ruangan': ruangan,
                    'tanggal': tanggal,
                    'jam': jam,
                    'keperluan': keperluan,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Peminjaman berhasil diajukan')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal mengajukan: \\${e.toString()}')),
                  );
                }
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

  TableRow _buildRow(String label, TextEditingController controller, {FocusNode? focusNode, VoidCallback? onTap}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(label),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan $label',
          ),
        ),
      ),
    ]);
  }
}
