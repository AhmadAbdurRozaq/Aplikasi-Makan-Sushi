import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation.dart';

class MainPage extends StatefulWidget {
  final String nama;
  final String nbi;
  final String email;
  final String ig;
  final String alamat;

  const MainPage({
    super.key,
    required this.nama,
    required this.nbi,
    required this.email,
    required this.ig,
    required this.alamat,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _saveLastPage();
  }

  Future<void> _saveLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastPage', 'menu_awal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('PRAKTIKUM PAB 2025', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Text(
                widget.nbi,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/fotoku.jpg', height: 200),
              const SizedBox(height: 20),
              Text(
                widget.nama,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('lastPage', 'main_navigation');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigation(
                          nama: widget.nama,
                          nbi: widget.nbi,
                          email: widget.email,
                          ig: widget.ig,
                          alamat: widget.alamat,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
