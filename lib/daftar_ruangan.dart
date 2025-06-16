import 'package:flutter/material.dart';

class DaftarRuanganPage extends StatelessWidget {
  const DaftarRuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data ruangan dan status (bisa kamu ganti sesuai database/API nantinya)
    final List<Map<String, String>> ruanganList = [
      {'nama': 'R.101', 'status': 'Kosong'},
      {'nama': 'R.202', 'status': 'Isi'},
      {'nama': 'R.303', 'status': 'Kosong'},
      {'nama': 'R.404', 'status': 'Isi'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Ruangan'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: ruanganList.length,
        itemBuilder: (context, index) {
          final ruangan = ruanganList[index];
          final isKosong = ruangan['status'] == 'Kosong';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                isKosong ? Icons.check_circle : Icons.close,
                color: isKosong ? Colors.green : Colors.red,
              ),
              title: Text(ruangan['nama']!),
              subtitle: Text('Status: ${ruangan['status']}'),
              trailing: Chip(
                label: Text(
                  ruangan['status']!,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: isKosong ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
