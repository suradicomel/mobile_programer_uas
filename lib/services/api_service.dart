import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pendaftaran_murid/models/registration.dart';

class ApiService {
  static const String _baseUrl = 'https://api.sekolahku.com/v1';

  Future<Registration> submitRegistration(Registration registration) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/registrations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(registration.toJson()),
    );

    if (response.statusCode == 201) {
      return Registration.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit registration');
    }
  }

  Future<String> uploadDocument(String filePath) async {
    // Implementasi upload dokumen
    await Future.delayed(const Duration(seconds: 2));
    return 'https://storage.sekolahku.com/documents/${filePath.split('/').last}';
  }

  Future<bool> verifyPayment(String registrationId) async {
    // Implementasi verifikasi pembayaran
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}