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
          // Logo dan Nama Sekolah
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/school_logo.png'),
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
                  'Jl. Pangtenga No. 1, Kota.Sampang. Kecamatan omben',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Tentang Sekolah
          _buildCardWithIcon(
            icon: Icons.info_outline,
            title: "Tentang Sekolah",
            content:
                "SMA Darul Ulum Pangtenga adalah sekolah kejuruan yang berkomitmen mencetak lulusan siap kerja dengan berbagai jurusan unggulan serta fasilitas modern.",
          ),

          // Visi Misi (expandable)
          ExpansionTile(
            initiallyExpanded: true,
            leading: const Icon(Icons.visibility, color: Colors.indigo),
            title: const Text(
              "Visi & Misi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            children: [
              ListTile(
                title: Text(
                  "Visi:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Menjadi sekolah kejuruan unggulan yang mencetak lulusan berdaya saing tinggi di dunia kerja dan industri.",
                ),
              ),
              ListTile(
                title: Text("Misi:"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("1. Menyediakan pendidikan berkualitas dan relevan."),
                    Text("2. Meningkatkan kompetensi melalui praktik nyata."),
                    Text("3. Kerja sama dengan industri dan usaha."),
                    Text("4. Kembangkan karakter dan soft skill siswa."),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Jurusan
          _buildCardWithIcon(
            icon: Icons.category,
            title: "Jurusan Unggulan",
            content:
                "✅ Teknik Komputer & Jaringan\n✅ Multimedia\n✅ Akuntansi\n✅ Bisnis & Pemasaran",
          ),

          const SizedBox(height: 20),

          // Fasilitas
          _buildCardWithIcon(
            icon: Icons.apartment,
            title: "Fasilitas Sekolah",
            content:
                "🏫 Gedung modern & representatif\n🖥️ Laboratorium komputer & multimedia\n📚 Perpustakaan digital\n🎓 Ruang praktik siswa\n⚽ Lapangan olahraga & musala",
          ),

          const SizedBox(height: 20),

          // Ekstrakurikuler
          _buildCardWithIcon(
            icon: Icons.star_border,
            title: "Ekstrakurikuler",
            content:
                "🎨 Seni & Musik\n🤖 Robotika\n⚽ Futsal\n📸 Fotografi\n🗣️ Bahasa Inggris",
          ),

          const SizedBox(height: 20),

          // Prestasi
          _buildCardWithIcon(
            icon: Icons.emoji_events,
            title: "Prestasi Sekolah",
            content:
                "🥇 Juara 1 Lomba Desain Nasional\n🥈 Finalis Olimpiade Sains Provinsi\n🥉 Juara Umum Futsal Antar SMA",
          ),

          const SizedBox(height: 20),

          // Galeri
          ExpansionTile(
            leading: const Icon(Icons.photo_library, color: Colors.indigo),
            title: const Text(
              "Galeri Sekolah",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            children: [
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildGalleryImage('assets/images/gedung.jpg'),
                    _buildGalleryImage('assets/images/lab.jpg'),
                    _buildGalleryImage('assets/images/perpustakaan.jpg'),
                    _buildGalleryImage('assets/images/kelas.jpg'),
                    _buildGalleryImage('assets/images/osis.jpg'),
                    _buildGalleryImage('assets/images/ekstra.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),

          const SizedBox(height: 20),

          // Kontak Penting
          _buildCardWithIcon(
            icon: Icons.contact_phone,
            title: "Kontak Sekolah",
            content:
                "📞 Telp: (021) 12345678\n📧 Email: info@darululum.sch.id\n🌐 Website: www.darululum.sch.id",
          ),
        ],
      ),
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
                  Text(
                    content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String assetPath) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
