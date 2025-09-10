import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'register_screen.dart';
import 'menu_awal.dart';
import 'bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  Future<void> navigateToNext() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));

    final nama = prefs.getString('nama');
    final nbi = prefs.getString('nbi');
    final email = prefs.getString('email');
    final ig = prefs.getString('ig');
    final alamat = prefs.getString('alamat');
    final lastPage = prefs.getString('lastPage');
    final lastTabIndex = prefs.getInt('lastTabIndex') ?? 0;

    if (nama != null && nbi != null && email != null && ig != null && alamat != null) {
      // Sudah daftar → arahkan ke halaman terakhir
      if (lastPage == 'main_navigation') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainNavigation(
              nama: nama,
              nbi: nbi,
              email: email,
              ig: ig,
              alamat: alamat,
              initialIndex: lastTabIndex,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainPage(
              nama: nama,
              nbi: nbi,
              email: email,
              ig: ig,
              alamat: alamat,
            ),
          ),
        );
      }
    } else {
      // Belum daftar → ke register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B9412),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/splash2.png', fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/splash1.png',
                  width: MediaQuery.of(context).size.width * 0.80,
                ),
                const SizedBox(height: 30),
                const SpinKitThreeBounce(color: Colors.white, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
