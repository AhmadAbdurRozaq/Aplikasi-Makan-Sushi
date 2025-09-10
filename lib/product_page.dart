import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  final String title;
  final bool showBackButton;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Ebi Sushi', 'price': '\$2.99', 'image': 'assets/ebi_sushi.jpg'},
    {
      'name': 'Salmon Roll',
      'price': '\$3.49',
      'image': 'assets/salmon_roll.jpg',
    },
    {
      'name': 'Temari Sushi',
      'price': '\$7.99',
      'image': 'assets/temari_sushi.jpg',
    },
    {'name': 'Futomaki', 'price': '\$6.25', 'image': 'assets/futomaki.jpg'},
    {
      'name': 'Tuna Nigiri',
      'price': '\$3.99',
      'image': 'assets/tuna_nigiri.jpg',
    },
    {
      'name': 'California Roll',
      'price': '\$4.25',
      'image': 'assets/california_roll.jpg',
    },
    {
      'name': 'Tamago Sushi',
      'price': '\$2.75',
      'image': 'assets/tamago_sushi.jpg',
    },
    {'name': 'Unagi Don', 'price': '\$5.99', 'image': 'assets/unagi_don.jpg'},
    {'name': 'Futomaki', 'price': '\$6.25', 'image': 'assets/futomaki.jpg'},
    {'name': 'Ebi Sushi', 'price': '\$2.99', 'image': 'assets/ebi_sushi.jpg'},
  ];

  List<bool> likedStatus = [];
  List<int> likeCount = [];
  List<int> qtyPerProduct = [];

  @override
  void initState() {
    super.initState();
    likedStatus = List.generate(products.length, (_) => false);
    likeCount = List.generate(products.length, (_) => 0);
    qtyPerProduct = List.generate(products.length, (_) => 0);
  }

  int get totalItemsInCart =>
      qtyPerProduct.fold(0, (previous, current) => previous + current);

  void updateCart(int index, bool increase) {
    setState(() {
      if (increase) {
        qtyPerProduct[index]++;
      } else {
        if (qtyPerProduct[index] > 0) {
          qtyPerProduct[index]--;
        }
      }
    });
  }

  void showCart() {
    final selectedProducts = <Map<String, dynamic>>[];
    for (int i = 0; i < products.length; i++) {
      if (qtyPerProduct[i] > 0) {
        selectedProducts.add({
          'name': products[i]['name'],
          'quantity': qtyPerProduct[i],
          'image': products[i]['image'],
        });
      }
    }

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: const Text('Keranjang Anda'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                child: Column(
                  children:
                      selectedProducts
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['image'],
                                    width: 70,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(item['name']),
                                trailing: Text('x${item['quantity']}'),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Text('Tutup'),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur Buy belum tersedia')),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Text('Buy', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 2,
        automaticallyImplyLeading: widget.showBackButton,
        leading:
            widget.showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 14,
                childAspectRatio: 0.61,
              ),
              itemBuilder: (context, index) {
                return _buildProductCard(index, isDark);
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: totalItemsInCart > 0 ? showCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    totalItemsInCart > 0
                        ? Colors.green
                        : (isDark ? Colors.grey[700] : Colors.grey[300]),
              ),
              child: Text(
                'Add to cart',
                style: TextStyle(
                  color: totalItemsInCart > 0 ? Colors.white : textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index, bool isDark) {
    return Card(
      color: isDark ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              products[index]['image'],
              height: 182,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Konten
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // penting!
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama & Qty
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          products[index]['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                            ),
                            onPressed:
                                qtyPerProduct[index] > 0
                                    ? () => updateCart(index, false)
                                    : null,
                          ),
                          Text(
                            '${qtyPerProduct[index]}',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 18,
                            ),
                            onPressed: () => updateCart(index, true),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Harga & Love
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        products[index]['price'],
                        style: const TextStyle(color: Colors.green),
                      ),
                      IconButton(
                        icon: Icon(
                          likedStatus[index]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: likedStatus[index] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            likedStatus[index] = !likedStatus[index];
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
