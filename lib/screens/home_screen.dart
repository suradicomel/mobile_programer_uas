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

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka URL: $url';
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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Selamat Datang di Portal PPDB',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Informasi lengkap seputar pendaftaran siswa baru tahun ajaran ini.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            _buildSectionTitle('Fitur Utama PPDB'),
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    icon: Icons.assignment,
                    title: 'Form PPDB Lengkap',
                    description: 'Form pendaftaran lengkap dan fleksibel sesuai kebutuhan sekolah.',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    icon: Icons.lock_open,
                    title: 'Buka dan Tutup PPDB',
                    description: 'Kontrol mudah membuka dan menutup jalur pendaftaran.',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Status Pendaftaran & Data Siswa'),

            _buildStatusItem(
              icon: Icons.date_range,
              label: isPendaftaranDibuka
                  ? 'Pendaftaran saat ini sedang DIBUKA'
                  : 'Pendaftaran saat ini sudah DITUTUP',
              status: isPendaftaranDibuka,
            ),
            _buildStatusItem(
              icon: Icons.person,
              label: isDataSiswaLengkap
                  ? 'Data siswa telah lengkap'
                  : 'Data siswa belum lengkap',
              status: isDataSiswaLengkap,
            ),
            _buildStatusItem(
              icon: Icons.upload_file,
              label: isDokumenTerverifikasi
                  ? 'Dokumen telah diverifikasi'
                  : 'Dokumen belum diverifikasi',
              status: isDokumenTerverifikasi,
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Info Singkat'),
            _buildInfoTile(Icons.calendar_today, 'Jadwal PPDB',
                'Pendaftaran dibuka mulai 1 Juni hingga 30 Juni.'),
            _buildInfoTile(Icons.location_on, 'Lokasi Kampus',
                'Jl. Pendidikan No. 1, Jakarta Selatan'),
            _buildInfoTile(Icons.school, 'Program Studi',
                'Teknik Komputer, Akuntansi, Multimedia, dan lainnya.'),

            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Persyaratan Pendaftaran'),
                      _buildListCard([
                        '• Fotokopi Akta Kelahiran',
                        '• Fotokopi Kartu Keluarga',
                        '• Pas Foto 3x4',
                        '• Mengisi Formulir Online'
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Alasan Memilih Kami'),
                      _buildListCard([
                        '✅ Tenaga pengajar profesional',
                        '✅ Fasilitas lengkap & modern',
                        '✅ Lokasi strategis & aman',
                        '✅ Ekstrakurikuler menarik'
                      ]),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Siap Mendaftar?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Klik tombol di bawah ini untuk memulai proses pendaftaran online Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.assignment_turned_in_outlined),
                      label: const Text('Daftar Sekarang'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegistrationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Hubungi Kami'),
            Row(
              children: [
                _buildSocialButton(context, FontAwesomeIcons.whatsapp,
                    () => _launchURL("https://wa.me/6281234567890")),
                const SizedBox(width: 10),
                _buildSocialButton(context, FontAwesomeIcons.facebook,
                    () => _launchURL("https://facebook.com/sekolahkita")),
                const SizedBox(width: 10),
                _buildSocialButton(context, FontAwesomeIcons.instagram,
                    () => _launchURL("https://instagram.com/sekolahkita")),
                const SizedBox(width: 10),
                _buildSocialButton(context, FontAwesomeIcons.mapLocation,
                    () => _launchURL("https://maps.google.com/?q=SMK+Kita")),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildListCard(List<String> items) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(item),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            if (title == 'Form PPDB Lengkap') {
              return _buildDialogFormPPDB();
            } else if (title == 'Buka dan Tutup PPDB') {
              return _buildDialogKontrolPPDB();
            }
            return const SizedBox();
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orange, size: 36),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogFormPPDB() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.assignment, color: Colors.orange, size: 40),
              const SizedBox(height: 16),
              const Text(
                'Formulir Data Siswa & Upload Dokumen',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildStatusItem(
                icon: Icons.person,
                label: 'Data siswa belum lengkap',
                status: isDataSiswaLengkap,
              ),
              _buildStatusItem(
                icon: Icons.upload_file,
                label: 'Dokumen telah diverifikasi',
                status: isDokumenTerverifikasi,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Tutup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogKontrolPPDB() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_open, color: Colors.orange, size: 40),
              const SizedBox(height: 16),
              const Text(
                'Kontrol Pendaftaran PPDB',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildStatusItem(
                icon: Icons.date_range,
                label: isPendaftaranDibuka
                    ? 'Pendaftaran saat ini sedang DIBUKA'
                    : 'Pendaftaran saat ini sudah DITUTUP',
                status: isPendaftaranDibuka,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isPendaftaranDibuka = false;
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.power_settings_new),
                label: const Text('Tutup Pendaftaran Sekarang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required bool status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: status ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: status ? Colors.green : Colors.red,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: status ? Colors.green : Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: status ? Colors.green.shade800 : Colors.red.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            status ? Icons.check_circle : Icons.cancel,
            color: status ? Colors.green : Colors.red,
          )
        ],
      ),
    );
  }
}
