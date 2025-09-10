import 'package:flutter/material.dart';
import 'secret_api.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({super.key});

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  final TextEditingController _pinController = TextEditingController();
  final String _secretPIN = 'daskom123'; // PIN statis

  void _verifikasiPIN() {
    final inputPin = _pinController.text.trim();

    if (inputPin == _secretPIN) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageListPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN salah. Silakan coba lagi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter Your PIN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter your pin that you have created',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 30),
              const Icon(Icons.lock_outline, color: Colors.red, size: 50),
              const SizedBox(height: 20),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLength: 10,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, letterSpacing: 8),
                  decoration: InputDecoration(
                    hintText: '••••••',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      letterSpacing: 8,
                    ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _verifikasiPIN,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Icon(Icons.lock_open, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
