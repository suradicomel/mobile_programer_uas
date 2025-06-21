import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final List<String> _namaSiswa = [
    'Rizki Hidayat', 'Ani Wijaya', 'Bayu Saputra', 'Citra Lestari',
    'Deni Pratama', 'Eva Kusuma', 'Fajar Ramadhan', 'Gita Anjani',
    'Hendra Gunawan', 'Intan Permata'
  ];
  final Random _random = Random();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  List<Map<String, dynamic>> transaksi = [];
  List<Map<String, dynamic>> filteredTransaksi = [];

  String _searchQuery = '';
  String _filterStatus = 'Semua';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _generateDummyData();
  }

  void _generateDummyData() {
    transaksi.clear();
    for (int i = 0; i < 10; i++) {
      transaksi.add({
        'id': i,
        'nama': _namaSiswa[i],
        'tanggal': '2025-06-${10 + i}',
        'jumlah': 100000 + _random.nextInt(100000),
        'status': i % 2 == 0 ? 'Lunas' : 'Belum Lunas',
      });
    }
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      filteredTransaksi = transaksi.where((item) {
        final matchNama = item['nama'].toLowerCase().contains(_searchQuery.toLowerCase());
        final matchStatus = _filterStatus == 'Semua' || item['status'] == _filterStatus;
        final itemDate = DateTime.tryParse(item['tanggal']);
        final matchDate = (_startDate == null || itemDate!.isAfter(_startDate!.subtract(const Duration(days: 1)))) &&
            (_endDate == null || itemDate!.isBefore(_endDate!.add(const Duration(days: 1))));
        return matchNama && matchStatus && matchDate;
      }).toList();
    });
  }

  int get totalPembayaran => filteredTransaksi.fold(0, (sum, item) => sum + (item['jumlah'] as int));

  void _tambahTransaksi() {
    showDialog(
      context: context,
      builder: (context) {
        String nama = '';
        String jumlah = '';
        return AlertDialog(
          title: const Text("Tambah Transaksi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nama Siswa'),
                onChanged: (val) => nama = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
                keyboardType: TextInputType.number,
                onChanged: (val) => jumlah = val,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (nama.isNotEmpty && jumlah.isNotEmpty) {
                    setState(() {
                      transaksi.add({
                        'id': transaksi.length,
                        'nama': nama,
                        'tanggal': formatter.format(DateTime.now()),
                        'jumlah': int.tryParse(jumlah) ?? 0,
                        'status': 'Belum Lunas',
                      });
                      _applyFilters();
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text("Simpan"))
          ],
        );
      },
    );
  }

  void _hapusTransaksi(int index) {
    setState(() {
      transaksi.removeAt(index);
      _applyFilters();
    });
  }

  void _editTransaksi(Map<String, dynamic> item) {
    String nama = item['nama'];
    String jumlah = item['jumlah'].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Transaksi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: nama),
                decoration: const InputDecoration(labelText: 'Nama Siswa'),
                onChanged: (val) => nama = val,
              ),
              TextField(
                controller: TextEditingController(text: jumlah),
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                onChanged: (val) => jumlah = val,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  item['nama'] = nama;
                  item['jumlah'] = int.tryParse(jumlah) ?? item['jumlah'];
                  _applyFilters();
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            )
          ],
        );
      },
    );
  }

  void _selesaikanPembayaran(Map<String, dynamic> item) {
    setState(() {
      item['status'] = 'Lunas';
      _applyFilters();
    });
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context, firstDate: DateTime(2024), lastDate: DateTime(2026),
    );
    if (picked != null) {
      _startDate = picked.start;
      _endDate = picked.end;
      _applyFilters();
    }
  }

  Future<void> _exportPDF() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Laporan Transaksi Siswa', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          ...filteredTransaksi.map((item) =>
            pw.Text("${item['nama']} | ${item['tanggal']} | Rp${item['jumlah']} | ${item['status']}")),
          pw.Divider(),
          pw.Text('Total: Rp$totalPembayaran', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    ));
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
            onPressed: _tambahTransaksi,
            icon: const Icon(Icons.add),
            label: const Text("Tambah Transaksi", style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Cari nama siswa...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            onChanged: (value) {
              _searchQuery = value;
              _applyFilters();
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _filterStatus,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Status'),
                  items: ['Semua', 'Lunas', 'Belum Lunas']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      _filterStatus = v;
                      _applyFilters();
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                icon: const Icon(Icons.date_range),
                label: const Text("Filter Tanggal"),
                onPressed: _pickDateRange,
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("Export PDF"),
                onPressed: _exportPDF,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Transaksi Siswa'), backgroundColor: Colors.indigo),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTransaksi.length,
              itemBuilder: (ctx, idx) {
                final item = filteredTransaksi[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(item['nama'][0], style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(item['nama']),
                    subtitle: Text('Rp${item['jumlah']} · ${item['tanggal']}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') _editTransaksi(item);
                        if (value == 'hapus') _hapusTransaksi(transaksi.indexOf(item));
                        if (value == 'selesai') _selesaikanPembayaran(item);
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                        if (item['status'] == 'Belum Lunas')
                          const PopupMenuItem(value: 'selesai', child: Text('Selesaikan')),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TransaksiDetailScreen(transaksi: item)),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.indigo))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Rp$totalPembayaran', style: const TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransaksiDetailScreen extends StatelessWidget {
  final Map<String, dynamic> transaksi;

  const TransaksiDetailScreen({super.key, required this.transaksi});

  Future<void> _cetakStrukPDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context ctx) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('STRUK PEMBAYARAN', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Nama   : ${transaksi['nama']}'),
            pw.Text('Tanggal: ${transaksi['tanggal']}'),
            pw.Text('Jumlah : Rp${transaksi['jumlah']}'),
            pw.Text('Status : ${transaksi['status']}'),
            pw.SizedBox(height: 30),
            pw.Text('Terima kasih atas pembayaran Anda.', style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
          ],
        ),
      ),
    ));

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = transaksi['status'] == 'Lunas' ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi'), backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.receipt_long, size: 80, color: Colors.indigo),
            const SizedBox(height: 30),
            _buildDetailTile("👤 Nama Siswa", transaksi['nama']),
            _buildDetailTile("📅 Tanggal", transaksi['tanggal']),
            _buildDetailTile("💰 Jumlah", "Rp${transaksi['jumlah']}"),
            _buildDetailTile("📌 Status", transaksi['status'], color: statusColor),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Cetak Struk"),
              onPressed: () => _cetakStrukPDF(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String label, String value, {Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          Expanded(child: Text(value, textAlign: TextAlign.end, style: TextStyle(fontSize: 16, color: color))),
        ],
      ),
    );
  }
}
