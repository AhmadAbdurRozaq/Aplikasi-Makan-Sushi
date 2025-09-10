import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final List<int> qtyPerProduct;
  final List<bool> likedStatus;
  final void Function(int index, bool increase) onQtyChanged;
  final void Function(int index) onLikeChanged;
  final void Function(Map<String, dynamic> product) onProductTapped;
  final bool isDark;

  const ListProduct({
    super.key,
    required this.products,
    required this.qtyPerProduct,
    required this.likedStatus,
    required this.onQtyChanged,
    required this.onLikeChanged,
    required this.onProductTapped,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onProductTapped(products[index]),
          child: Card(
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
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Konten
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  icon: const Icon(Icons.remove_circle_outline, size: 18),
                                  onPressed: qtyPerProduct[index] > 0
                                      ? () => onQtyChanged(index, false)
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
                                  icon: const Icon(Icons.add_circle_outline, size: 18),
                                  onPressed: () => onQtyChanged(index, true),
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
                                likedStatus[index] ? Icons.favorite : Icons.favorite_border,
                                color: likedStatus[index] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => onLikeChanged(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
