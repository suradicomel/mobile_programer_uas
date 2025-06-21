import 'package:flutter/material.dart';

class StatusPendaftaranScreen extends StatelessWidget {
  const StatusPendaftaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pendaftaran'),
        backgroundColor: Colors.indigo,
      ),
      body: const Center(
        child: Text(
          'Belum ada status. Anda belum mendaftar.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
