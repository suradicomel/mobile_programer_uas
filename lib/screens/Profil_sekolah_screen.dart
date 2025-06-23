import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilSekolahScreen extends StatelessWidget {
  const ProfilSekolahScreen({Key? key}) : super(key: key);

  void _showDetailBottomSheet(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 12),
                Text(content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text("Profil Sekolah"),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Gambar dan Nama Sekolah
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Eo_circle_blue_letter-d.svg/2048px-Eo_circle_blue_letter-d.svg.png',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'SMA Darul Ulum Pangtenga',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Jl. Pangtenga No. 1, Kota Sampang, Kecamatan Omben',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _buildClickableCard(
            context,
            Icons.info_outline,
            'Tentang Sekolah',
            'SMA Darul Ulum Pangtenga adalah sekolah kejuruan unggulan...',
          ),

          _buildClickableCard(
            context,
            Icons.history_edu,
            'Sejarah Sekolah',
            'Didirikan pada tahun 1985, sekolah ini awalnya berfokus pada pengajaran agama dan kejuruan dasar...',
          ),

          _buildClickableCard(
            context,
            Icons.person,
            'Profil Kepala Sekolah',
            'Nama: Drs. Ahmad Zain\nPengalaman: 20+ tahun\nMotto: Pendidikan adalah cahaya kehidupan.',
          ),

          _buildClickableCard(
            context,
            Icons.account_tree,
            'Struktur Organisasi',
            '📌 Kepala Sekolah\n📌 Wakil Kurikulum\n📌 Wakil Kesiswaan\n📌 Guru dan Staf\n📌 Komite Sekolah',
          ),

          _buildClickableCard(
            context,
            Icons.visibility,
            'Visi & Misi',
            'Visi:\nMenjadi sekolah kejuruan unggulan berdaya saing tinggi.\n\nMisi:\n1. Pendidikan berkualitas\n2. Kompetensi kerja\n3. Karakter unggul',
          ),

          _buildClickableCard(
            context,
            Icons.category,
            'Jurusan Unggulan',
            '✅ Teknik Komputer & Jaringan\n✅ Multimedia\n✅ Akuntansi\n✅ Bisnis & Pemasaran',
          ),

          _buildClickableCard(
            context,
            Icons.apartment,
            'Fasilitas Sekolah',
            '🏫 Gedung modern\n🖥️ Lab komputer\n📚 Perpustakaan digital\n⚽ Lapangan olahraga\n🕌 Musala',
          ),

          _buildClickableCard(
            context,
            Icons.star_border,
            'Ekstrakurikuler',
            '🎨 Seni & Musik\n🤖 Robotika\n⚽ Futsal\n📸 Fotografi\n🗣️ Bahasa Inggris',
          ),

          _buildClickableCard(
            context,
            Icons.emoji_events,
            'Prestasi Sekolah',
            '🥇 Juara Desain Nasional\n🥈 Finalis Olimpiade Sains\n🥉 Juara Futsal Antar SMA',
          ),

          _buildClickableCard(
            context,
            Icons.people,
            'Testimoni Alumni',
            '🗣️ “Sekolah ini membentuk masa depan saya!” - Budi (Alumni 2018)\n🗣️ “Saya langsung kerja setelah lulus.” - Siti (Alumni 2020)',
          ),

          _buildClickableCard(
            context,
            Icons.map,
            'Peta Lokasi Sekolah',
            'SMA Darul Ulum Pangtenga',
            onTap: () => _launchURL(
              'https://www.google.com/maps/search/?api=1&query=-7.123456,113.456789',
            ),
          ),

          const SizedBox(height: 20),

          ExpansionTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galeri Sekolah'),
            initiallyExpanded: false,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1577896851231-70ef18881754'),
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1588072432836-e10032774350'),
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1596495577886-d920f1fb7238'),
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1571260899304-425eee4c7efc'),
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1584697964404-6c288fc76115'),
                    _buildGalleryImageNetwork('https://images.unsplash.com/photo-1600267165683-2f5c980f1a98'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildClickableCard(
            context,
            Icons.contact_phone,
            'Kontak Sekolah',
            '📞 (021) 12345678\n📧 info@darululum.sch.id\n🌐 www.darululum.sch.id',
          ),
        ],
      ),
    );
  }

  Widget _buildClickableCard(
    BuildContext context,
    IconData icon,
    String title,
    String content, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () => _showDetailBottomSheet(context, title, content),
      child: _buildCardWithIcon(icon: icon, title: title, content: content),
    );
  }

  Widget _buildCardWithIcon({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.indigo, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImageNetwork(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.red),
          );
        },
      ),
    );
  }
}
