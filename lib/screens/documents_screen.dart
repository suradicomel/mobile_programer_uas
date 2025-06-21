import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final Map<String, File?> _documents = {
    'Akta Kelahiran': null,
    'Kartu Keluarga': null,
    'Pas Foto 3x4': null,
  };

  Future<void> _pickDocument(String name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _documents[name] = File(result.files.single.path!);
      });

      _showUploadSuccessDialog(name);
    }
  }

  void _showUploadSuccessDialog(String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Upload Berhasil"),
        content: Text("Dokumen '$name' berhasil diunggah."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  bool _allUploaded() => _documents.values.every((f) => f != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('Unggah Dokumen'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unggah Dokumen Syarat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            const Text(
              'Silakan unggah dokumen penting berikut ini dalam format PDF atau JPG/PNG:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            ..._documents.entries.map((entry) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  leading: Icon(
                    FontAwesomeIcons.fileUpload,
                    color: Colors.orange[800],
                  ),
                  title: Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: entry.value == null
                      ? const Text('Belum ada file dipilih')
                      : Text(entry.value!.path.split('/').last),
                  trailing: IconButton(
                    icon: Icon(
                      entry.value == null ? Icons.cloud_upload : Icons.edit,
                      color: Colors.green[700],
                    ),
                    onPressed: () => _pickDocument(entry.key),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Lanjutkan'),
              onPressed: _allUploaded()
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Semua dokumen berhasil diunggah. Lanjut ke langkah berikutnya."),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
