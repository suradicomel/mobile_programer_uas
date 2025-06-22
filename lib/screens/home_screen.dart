import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPendaftaranDibuka = true;
  bool isDataSiswaLengkap = false;
  bool isDokumenTerverifikasi = true;

   final List<Map<String, dynamic>> siswaBelumLengkap = [
    {
      'nama': 'Rico',
      'dokumen': ['Kartu Keluarga', 'Pas Foto 3x4', ],
    },
    {
      'nama': 'Faruk',
      'dokumen': ['Akta Kelahiran', 'Data Orang Tua', 'Rapot',],
    },
  ];

  final List<Map<String, dynamic>> DataSiswaSudahVerifikasi = [
    {
      'nama': 'Farhan',
      'dokumen': ['Kartu Keluarga', 'Pas Foto', 'Akta Kelahiran', 'Ijazah', 'Rapot'],
    },
    {
      'nama': 'Suradi',
      'dokumen': ['Akta Kelahiran', 'KK', 'Rapot', 'Ijazah', 'pas foto'],
    },
  ];

  

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }

  void _showJadwalDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Jadwal Lengkap PPDB"),
        content: const Text(
          "📅 Pendaftaran: 1 Juni – 30 Juni\n📝 Tes Seleksi: 3 Juli\n📣 Pengumuman: 5 Juli\n🔁 Daftar Ulang: 6 – 10 Juli",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
        ],
      ),
    );
  }

  void _openMaps() {
    _launchURL("https://maps.google.com/?q=Jl.+Pendidikan+No.+1,+Jakarta+Selatan");
  }

  void _showFormPPDBDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.assignment, color: Colors.orange, size: 40),
              const SizedBox(height: 12),
              const Text("Formulir Pendaftaran Siswa Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              const Text("Lengkapi formulir dan unggah dokumen Anda secara online dengan mudah dan cepat.", textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationScreen()));
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text("Isi Formulir Sekarang"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
            ],
          ),
        ),
      ),
    );
  }

  void _showBukaTutupPPDBDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isPendaftaranDibuka ? Icons.lock_open : Icons.lock,
                  color: isPendaftaranDibuka ? Colors.green : Colors.red, size: 40),
              const SizedBox(height: 12),
              Text(
                isPendaftaranDibuka ? "Pendaftaran saat ini sedang DIBUKA" : "Pendaftaran saat ini DITUTUP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isPendaftaranDibuka ? Colors.green : Colors.red),
              ),
              const SizedBox(height: 10),
              const Text("Anda dapat mengubah status pendaftaran sesuai jadwal atau kebutuhan.", textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => isPendaftaranDibuka = !isPendaftaranDibuka);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.sync_alt),
                label: Text(isPendaftaranDibuka ? "Tutup Pendaftaran" : "Buka Pendaftaran"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPendaftaranDibuka ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal"))
            ],
          ),
        ),
      ),
    );
  }



  void _showDataBelumLengkapDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Siswa dengan Data Belum Lengkap"),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: siswaBelumLengkap.map((siswa) {
              return _buildSiswaItem(siswa['nama'], siswa['dokumen']);
            }).toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
        ],
      ),
    );
  }

  void _showDokumenTerverifikasiDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Data Siswa Terverifikasi"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: DataSiswaSudahVerifikasi
                .map((siswa) => _buildSiswaItem(siswa['nama'], siswa['dokumen']))
                .toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
        ],
      ),
    );
  }


  Widget _buildSiswaItem(String nama, List<String> dokumen) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...dokumen.map((doc) => Text("• $doc", style: const TextStyle(fontSize: 14))),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.orange)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }
  

void _showDetailStatus(String title, bool isLengkap) {
    if (!isLengkap && title == "Data Siswa") {
      _showDataBelumLengkapDialog();
    } else if (isLengkap && title == "Dokumen") {
      _showDokumenTerverifikasiDialog();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Detail: $title"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isLengkap ? Icons.check_circle : Icons.warning_rounded,
                  size: 48, color: isLengkap ? Colors.green : Colors.red),
              const SizedBox(height: 10),
              Text(
                isLengkap
                    ? "Semua data dan dokumen telah lengkap dan terverifikasi."
                    : "Beberapa data masih belum lengkap.\nSilakan lengkapi terlebih dahulu.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('Beranda PPDB Siswa'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text('Selamat Datang di PPDB Darul Ulum', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
            ),
            const SizedBox(height: 10),
            const Text('Informasi lengkap seputar pendaftaran siswa baru tahun ajaran ini.',
                style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            const SizedBox(height: 30),
            _buildSectionTitle('Fitur Utama PPDB'),
            Row(
              children: [
                Expanded(child: _buildFeatureCard(icon: Icons.assignment, title: 'Form PPDB Lengkap', description: 'Form pendaftaran lengkap dan fleksibel sesuai kebutuhan sekolah.', onTap: _showFormPPDBDialog)),
                const SizedBox(width: 10),
                Expanded(child: _buildFeatureCard(icon: Icons.lock_open, title: 'Buka & Tutup PPDB', description: 'Kontrol mudah membuka dan menutup jalur pendaftaran.', onTap: _showBukaTutupPPDBDialog)),
              ],
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Status Pendaftaran & Data Siswa'),
            GestureDetector(
              onTap: () => _showDetailStatus('Pendaftaran', isPendaftaranDibuka),
              child: _buildStatusItem(icon: Icons.date_range, label: isPendaftaranDibuka ? 'DIBUKA' : 'DITUTUP', status: isPendaftaranDibuka),
            ),
            GestureDetector(
              onTap: () => _showDetailStatus('Data Siswa', isDataSiswaLengkap),
              child: _buildStatusItem(icon: Icons.person, label: isDataSiswaLengkap ? 'Data Lengkap' : 'Data Belum Lengkap', status: isDataSiswaLengkap),
            ),
            GestureDetector(
              onTap: () => _showDetailStatus('Dokumen', isDokumenTerverifikasi),
              child: _buildStatusItem(icon: Icons.upload_file, label: isDokumenTerverifikasi ? 'Dokumen Terverifikasi' : 'Belum Verifikasi', status: isDokumenTerverifikasi),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Info Singkat'),
            GestureDetector(onTap: _showJadwalDialog, child: _buildInfoTile(Icons.calendar_today, 'Jadwal PPDB', 'Pendaftaran dibuka 1 Juni - 30 Juni.')),
            GestureDetector(onTap: _openMaps, child: _buildInfoTile(Icons.location_on, 'Lokasi Sekolah', 'Jl. Omben No. 1, Omben City')),
            _buildInfoTile(Icons.school, 'Program Pelajaran', 'Komputer, IPS, At-tanzil, IPA, Arab, dan lainnya.'),
            const SizedBox(height: 30),
            _buildSectionTitle('Persyaratan & Keunggulan'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildListCard([
                '• Fotokopi Akta Kelahiran', 
                '• Fotokopi KK', 
                '• Pas Foto 3x4', 
                '• Formulir Online'])),
                const SizedBox(width: 16),
                Expanded(child: _buildListCard([
                '✅ Guru Profesional', 
                '✅ Fasilitas Lengkap',
                '✅ Lokasi Strategis', 
                '✅ Ekstrakurikuler']))
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.indigo, Colors.indigoAccent]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.rocket_launch_rounded, size: 60, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text("Siap Jadi Siswa Hebat?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text("Klik tombol di bawah untuk mendaftar secara online sekarang!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.assignment_turned_in),
                      label: const Text("Daftar Sekarang"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            _buildSectionTitle('Hubungi Kami'),
            Row(
              children: [
                _buildSocialButton(FontAwesomeIcons.whatsapp, () => _launchURL("https://wa.me/6287777281016")),
                const SizedBox(width: 10),
                _buildSocialButton(FontAwesomeIcons.facebook, () => _launchURL("https://facebook.com/sekolahkita")),
                const SizedBox(width: 10),
                _buildSocialButton(FontAwesomeIcons.instagram, () => _launchURL("https://instagram.com/sekolahkita")),
                const SizedBox(width: 10),
                _buildSocialButton(FontAwesomeIcons.mapLocation, () => _launchURL("https://maps.google.com/?q=SMK+Darul Ulum")),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
      );

  Widget _buildInfoTile(IconData icon, String title, String subtitle) => ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      );

  Widget _buildListCard(List<String> items) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text(item))).toList(),
          ),
        ),
      );

  Widget _buildSocialButton(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      );

  Widget _buildFeatureCard({required IconData icon, required String title, required String description, required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
          child: Column(
            children: [
              Icon(icon, color: Colors.orange, size: 36),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 6),
              Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
      );

  Widget _buildStatusItem({required IconData icon, required String label, required bool status}) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: status ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: status ? Colors.green : Colors.red, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: status ? Colors.green : Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: TextStyle(fontSize: 16, color: status ? Colors.green.shade800 : Colors.red.shade800, fontWeight: FontWeight.w600)),
            ),
            Icon(status ? Icons.check_circle : Icons.cancel, color: status ? Colors.green : Colors.red),
          ],
        ),
      );
}
