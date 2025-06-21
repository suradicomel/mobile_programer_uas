import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  bool _notifAktif = true;
  String _tema = 'Terang';
  String _username = 'suradi123';
  String _email = 'suradi@email.com';
  String _password = '********';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _tema == 'Gelap' ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pengaturan Aplikasi'),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              setState(() {
                _tema = _tema == 'Terang' ? 'Gelap' : 'Terang';
              });
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('👤 Akun'),
          _buildCard(
            icon: Icons.image,
            title: 'Ubah Foto Profil',
            subtitle: 'Pilih gambar dari galeri atau kamera',
            onTap: _pickImage,
          ),
          if (_image != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_image!),
                ),
              ),
            ),
          _buildCard(
            icon: Icons.person,
            title: 'Edit Profil',
            subtitle: '$_username | $_email',
            onTap: _editProfileDialog,
          ),
          _buildCard(
            icon: Icons.lock,
            title: 'Ubah Kata Sandi',
            subtitle: 'Klik untuk ubah password',
            onTap: _editPasswordDialog,
          ),
          _buildCard(
            icon: Icons.delete_forever,
            title: 'Hapus Akun',
            subtitle: 'Akun akan dihapus secara permanen',
            onTap: _hapusAkunDialog,
          ),
          _buildCard(
            icon: Icons.logout,
            title: 'Keluar Akun',
            subtitle: 'Logout dari aplikasi ini',
            onTap: _logoutDialog,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('⚙️ Preferensi'),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: 'Notifikasi',
            value: _notifAktif,
            onChanged: (val) => setState(() => _notifAktif = val),
          ),
          _buildCard(
            icon: Icons.color_lens,
            title: 'Tema Aplikasi',
            subtitle: _tema,
            onTap: () => _showThemeDialog(context),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('ℹ️ Informasi'),
          _buildCard(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Versi dan info aplikasi',
            onTap: () => _showInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _tema == 'Gelap' ? Colors.white : Colors.indigo)),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: _tema == 'Gelap' ? Colors.grey[850] : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Card(
      color: _tema == 'Gelap' ? Colors.grey[850] : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  void _editProfileDialog() {
    final usernameController = TextEditingController(text: _username);
    final emailController = TextEditingController(text: _email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _username = usernameController.text;
                _email = emailController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _editPasswordDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Kata Sandi'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Kata Sandi Baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _password = '********';
              });
              Navigator.pop(context);
            },
            child: const Text('Ubah'),
          ),
        ],
      ),
    );
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _hapusAkunDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text('Tindakan ini akan menghapus akun Anda secara permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.currentUser?.delete();
                if (mounted) Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menghapus akun: $e')),
                );
              }
            },
            child: const Text('Hapus Akun'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Pilih Tema Aplikasi'),
        children: [
          SimpleDialogOption(
            child: const Text('🌞 Terang'),
            onPressed: () {
              setState(() => _tema = 'Terang');
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: const Text('🌙 Gelap'),
            onPressed: () {
              setState(() => _tema = 'Gelap');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'PPDB Digital',
      applicationVersion: 'v1.0.0',
      applicationIcon: const Icon(Icons.school, size: 48, color: Colors.indigo),
      children: const [
        SizedBox(height: 10),
        Text('Aplikasi ini digunakan untuk memudahkan pendaftaran siswa baru secara online. Dikembangkan oleh Tim Suradi.'),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }
}
