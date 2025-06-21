
import 'package:flutter/material.dart';
import '../models/student.dart';
import 'payment_screen.dart';
import '../widgets/custom_app_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedGrade;

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _parentNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: const CustomAppBar(title: 'Formulir Pendaftaran'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSectionCard(
                title: 'Data Calon Murid',
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nama Lengkap',
                    icon: Icons.person,
                    validator: (value) =>
                        value!.isEmpty ? 'Harap isi nama lengkap' : null,
                  ),
                  _buildTextField(
                    controller: _birthDateController,
                    label: 'Tanggal Lahir',
                    icon: Icons.calendar_today,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2010),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        _birthDateController.text =
                            '${date.day}/${date.month}/${date.year}';
                      }
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Harap isi tanggal lahir' : null,
                  ),
                  _buildDropdown(),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionCard(
                title: 'Data Orang Tua/Wali',
                children: [
                  _buildTextField(
                    controller: _parentNameController,
                    label: 'Nama Orang Tua/Wali',
                    icon: Icons.family_restroom,
                    validator: (value) =>
                        value!.isEmpty ? 'Harap isi nama orang tua/wali' : null,
                  ),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Alamat',
                    icon: Icons.home,
                    maxLines: 3,
                    validator: (value) =>
                        value!.isEmpty ? 'Harap isi alamat' : null,
                  ),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Nomor Telepon',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) return 'Harap isi nomor telepon';
                      if (!RegExp(r'^[0-8]+$').hasMatch(value)) {
                        return 'Nomor tidak valid';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _goToPaymentScreen();
                  }
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Daftarkan Sekarang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 6,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _goToPaymentScreen() {
    final student = Student(
      name: _nameController.text,
      birthDate: _birthDateController.text,
      grade: _selectedGrade ?? '',
      parentName: _parentNameController.text,
      address: _addressController.text,
      phone: _phoneController.text,
    );

    final documents = [
      'Akta Kelahiran',
      'Kartu Keluarga',
      'Rapor Terakhir',
      'Pas Foto 3x4',
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          student: student,
          documents: documents,
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800],
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.indigo[600]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        readOnly: onTap != null,
        onTap: onTap,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedGrade,
        decoration: InputDecoration(
          labelText: 'Kelas yang Dipilih',
          prefixIcon: Icon(Icons.school, color: Colors.indigo[600]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: ['TK', 'SD', 'SMP', 'SMA'].map((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedGrade = newValue;
          });
        },
        validator: (value) =>
            value == null ? 'Harap pilih kelas yang diinginkan' : null,
      ),
    );
  }
}
