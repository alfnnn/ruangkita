import 'package:flutter/material.dart';

import 'services/supabase_service.dart';

class AjukanPage extends StatefulWidget {
  final String namaUser;
  const AjukanPage({super.key, required this.namaUser});

  @override
  State<AjukanPage> createState() => _AjukanPageState();
}

class _AjukanPageState extends State<AjukanPage> {
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
      backgroundColor: const Color(0xFFE3F2FD),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Ajukan Peminjaman'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 450),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Nama', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(widget.namaUser),
                ),
                const SizedBox(height: 16),
                _buildInputField('NIM', nimController),
                const SizedBox(height: 16),
                _buildInputField('Kelas', kelasController),
                const SizedBox(height: 16),
                Text('Ruangan', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    hintText: 'Pilih Ruangan',
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputField('Tanggal', tanggalController, focusNode: tanggalFocus, onTap: () async {
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
                const SizedBox(height: 16),
                _buildInputField('Jam', jamController, focusNode: jamFocus, onTap: () async {
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
                const SizedBox(height: 16),
                _buildInputField('Keperluan', keperluanController),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final nim = nimController.text.trim();
                    final kelas = kelasController.text.trim();
                    final ruangan = ruanganController.text.trim();
                    final tanggal = tanggalController.text.trim();
                    final jam = jamController.text.trim();
                    final keperluan = keperluanController.text.trim();

                    if ([nim, kelas, ruangan, tanggal, jam].any((e) => e.isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Semua field wajib diisi!')),
                      );
                      return;
                    }
                    try {
                      final supabase = SupabaseService.client;
                      await supabase.from('reservasi_ruangan').insert({
                        'nama': widget.namaUser,
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
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  label: const Text('Ajukan', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {FocusNode? focusNode, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: 'Masukkan $label',
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
