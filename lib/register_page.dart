import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  void _handleRegister() async {
    final nama = _namaController.text.trim();
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (nama.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError('Semua field harus diisi');
      return;
    }
    if (password != confirmPassword) {
      _showError('Password dan konfirmasi password tidak sama');
      return;
    }

    try {
      final supabase = Supabase.instance.client;
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (authResponse.user == null) {
        _showError('Registrasi gagal: ${authResponse.session?.accessToken == null ? 'Email sudah terdaftar atau format salah' : 'Unknown error'}');
        return;
      }
      // Insert ke tabel users
      await supabase.from('users').insert({
        'id': authResponse.user!.id,
        'email': email,
        'nama': nama,
        'role': 'user',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
      );
      Navigator.pop(context);
    } catch (e) {
      _showError('Registrasi gagal: ${e.toString()}');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // biru muda
      appBar: AppBar(
        backgroundColor: Colors.blue, // biru
        title: const Text('Registrasi'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.person_add, size: 80, color: Colors.blue),
            const SizedBox(height: 10),
            const Text(
              'DAFTAR AKUN USER',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: const Icon(Icons.badge, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.app_registration),
                label: const Text('Daftar'),
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
