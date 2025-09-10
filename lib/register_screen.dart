import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu_awal.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nbiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController igController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String emailInput = emailController.text.trim();
      if (!emailInput.endsWith('@gmail.com')) {
        emailInput += '@gmail.com';
      }

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isRegistered', true);
      await prefs.setString('nama', namaController.text.trim());
      await prefs.setString('nbi', nbiController.text.trim());
      await prefs.setString('email', emailInput);
      await prefs.setString('ig', igController.text.trim());
      await prefs.setString('alamat', alamatController.text.trim());

      // Simpan halaman terakhir agar bisa kembali ke posisi terakhir
      await prefs.setString('lastPage', 'main_navigation');
      await prefs.setInt('lastTabIndex', 0);

      // Langsung arahkan ke Menu Awal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            nama: namaController.text.trim(),
            nbi: nbiController.text.trim(),
            email: emailInput,
            ig: igController.text.trim(),
            alamat: alamatController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Image.asset('assets/logo1.png', height: 180),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'WELCOME',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(
                  child: Text(
                    'Praktikum PAB 2025',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  controller: namaController,
                  hint: "Masukan Nama",
                  validatorMsg: "Nama wajib diisi",
                ),
                _buildInputField(
                  controller: nbiController,
                  hint: "Masukan NBI",
                  validatorMsg: "NBI wajib diisi",
                  extraValidator: (value) {
                    if (value!.contains(' ')) return "NBI tidak boleh ada spasi";
                    if (!RegExp(r'^\d+$').hasMatch(value)) return "NBI hanya boleh angka";
                    return null;
                  },
                ),
                _buildInputField(
                  controller: emailController,
                  hint: "Masukan Email",
                  validatorMsg: "Email wajib diisi",
                  keyboardType: TextInputType.emailAddress,
                  suffixText: "@gmail.com",
                  extraValidator: (value) {
                    if (value!.contains(' ')) return "Email tidak boleh mengandung spasi";
                    return null;
                  },
                ),
                _buildInputField(
                  controller: igController,
                  hint: "Masukan Instagram",
                  validatorMsg: "Instagram wajib diisi",
                ),
                _buildInputField(
                  controller: alamatController,
                  hint: "Masukan Alamat",
                  validatorMsg: "Alamat wajib diisi",
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String validatorMsg,
    String? Function(String?)? extraValidator,
    TextInputType keyboardType = TextInputType.text,
    String? suffixText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixText: suffixText,
          suffixStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return validatorMsg;
          if (extraValidator != null) return extraValidator(value);
          return null;
        },
      ),
    );
  }
}
