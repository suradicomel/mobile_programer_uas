import 'package:flutter/material.dart';

class ProfilSekolahScreen extends StatelessWidget {
  const ProfilSekolahScreen({Key? key}) : super(key: key);

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
          Center(
            child: Column(
              children: const [
                const CircleAvatar(
               radius: 60,
               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1600267165683-2f5c980f1a98'),
),

                SizedBox(height: 16),
                Text(
                  'SMA Darul Ulum Pangtenga',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Jl. Pangtenga No. 1, Kota Sampang, Kec. Omben',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          _buildCardWithIcon(context,
              icon: Icons.info_outline,
              title: "Tentang Sekolah",
              content:
                  "SMA Darul Ulum Pangtenga adalah sekolah kejuruan yang berkomitmen mencetak lulusan siap kerja dengan berbagai jurusan unggulan serta fasilitas modern."),

          _buildCardWithIcon(context,
              icon: Icons.visibility,
              title: "Visi & Misi",
              content:
                  "Visi:\nMenjadi sekolah kejuruan unggulan yang mencetak lulusan berdaya saing tinggi di dunia kerja.\n\nMisi:\n1. Menyediakan pendidikan berkualitas\n2. Meningkatkan kompetensi siswa\n3. Bekerja sama dengan industri\n4. Membangun karakter dan soft skill"),

          _buildCardWithIcon(context,
              icon: Icons.category,
              title: "Jurusan Unggulan",
              content:
                  "✅ Teknik Komputer & Jaringan\n✅ Multimedia\n✅ Akuntansi\n✅ Bisnis & Pemasaran"),

          _buildCardWithIcon(context,
              icon: Icons.apartment,
              title: "Fasilitas Sekolah",
              content:
                  "🏫 Gedung modern\n🖥️ Lab Komputer\n📚 Perpustakaan digital\n🎓 Ruang praktik\n⚽ Lapangan olahraga & musala"),

          _buildCardWithIcon(context,
              icon: Icons.star_border,
              title: "Ekstrakurikuler",
              content:
                  "🎨 Seni & Musik\n🤖 Robotika\n⚽ Futsal\n📸 Fotografi\n🗣️ Bahasa Inggris"),

          _buildCardWithIcon(context,
              icon: Icons.emoji_events,
              title: "Prestasi Sekolah",
              content:
                  "🥇 Juara 1 Lomba Desain Nasional\n🥈 Olimpiade Sains Provinsi\n🥉 Juara Umum Futsal SMA"),

          _buildCardWithIcon(context,
              icon: Icons.people_alt,
              title: "Alumni",
              content:
                  "🎓 Alumni bekerja di sektor industri, ASN, dan profesional.\n💼 Banyak juga menjadi wirausahawan."),

          _buildCardWithIcon(context,
              icon: Icons.school,
              title: "Kegiatan Unggulan",
              content:
                  "📚 Bimbingan Karir\n🏭 Kunjungan Industri\n🌐 Magang Perusahaan Mitra\n🎤 Seminar Teknologi"),

          const SizedBox(height: 20),
          ExpansionTile(
            leading: const Icon(Icons.photo_library, color: Colors.indigo),
            title: const Text('Galeri Sekolah',
                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
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
              )
            ],
          ),
          const SizedBox(height: 20),

          _buildCardWithIcon(context,
              icon: Icons.contact_phone,
              title: "Kontak Sekolah",
              content:
                  "📞 Telp: (021) 12345678\n📧 Email: info@darululum.sch.id\n🌐 Website: www.darululum.sch.id"),
        ],
      ),
    );
  }

  static Widget _buildCardWithIcon(BuildContext context,
      {required IconData icon,
      required String title,
      required String content}) {
    return InkWell(
      onTap: () => _showDetailBottomSheet(context, title, content),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      ),
    );
  }

  static Widget _buildGalleryImageNetwork(String url) {
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

  static void _showDetailBottomSheet(BuildContext context, String title, String content) {
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo)),
                const SizedBox(height: 12),
                Text(content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
