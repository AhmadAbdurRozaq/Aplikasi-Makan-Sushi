import 'package:flutter/material.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPromoBanner(context),
              const SizedBox(height: 20),
              _buildMenuCard(context, 'Promo Panas'),
              const SizedBox(height: 10),
              _buildMenuCard(context, 'Gratis Ongkir'),
              const SizedBox(height: 10),
              _buildMenuCard(context, 'Paket Spesial'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[800],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kiri: Teks promo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Deals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '50% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'and get free delivery',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductPage(
                          title: 'Product',
                          showBackButton: true,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Order Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 120,
            height: 160,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -4,
                  right: 6,
                  child: Image.asset('assets/sushi1.png', width: 70),
                ),
                Positioned(
                  top: 30,
                  left: -80,
                  child: Image.asset(
                    'assets/sushi2.png',
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: -14,
                  right: 0,
                  child: Image.asset('assets/sushi3.png', width: 110),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                title: title,
                showBackButton: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
