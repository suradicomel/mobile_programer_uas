class AppConstants {
  static const String appName = 'Pendaftaran Murid Baru';
  static const String schoolName = 'Sekolah Unggulan Terpadu';
  static const String schoolAddress = 'Jl. Pendidikan No. 123, Kota Pendidikan';
  static const String schoolPhone = '(021) 12345678';
  static const String schoolEmail = 'info@sekolahunggulan.sch.id';

  static const List<String> requiredDocuments = [
    'Akta Kelahiran',
    'Kartu Keluarga',
    'Rapor Terakhir',
    'Pas Foto 3x4',
  ];

  static const Map<String, int> registrationFee = {
    'Reguler': 250000,
    'Prestasi': 150000,
    'Beasiswa': 0,
  };
}
