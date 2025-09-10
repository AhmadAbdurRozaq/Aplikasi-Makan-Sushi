import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'product_page.dart';
import 'profile_page.dart';
import 'secret_page.dart'; // ✅ Tambahkan ini

class MainNavigation extends StatefulWidget {
  final String nama;
  final String nbi;
  final String email;
  final String ig;
  final String alamat;
  final int initialIndex;

  const MainNavigation({
    super.key,
    required this.nama,
    required this.nbi,
    required this.email,
    required this.ig,
    required this.alamat,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  Future<void> _onItemTapped(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastTabIndex', index);
    await prefs.setString('lastPage', 'main_navigation');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomePage(),
      ProductPage(title: 'Product', showBackButton: false),
      SecretPage(), // ✅ Tambahkan BuatPinScreen sebagai tab baru
      ProfilePage(
        nama: widget.nama,
        nbi: widget.nbi,
        email: widget.email,
        ig: widget.ig,
        alamat: widget.alamat,
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Secret'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
