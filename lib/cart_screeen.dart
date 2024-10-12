import 'package:flutter/material.dart';

class CartScreeen extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;

  const CartScreeen({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              productImage,
              height: 200,
              width: 200,
            ), // Product Image
            const SizedBox(height: 20),
            Text(
              productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ), // Product Name
            const SizedBox(height: 10),
            Text(
              '\$${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, color: Colors.green),
            ), // Product Price
            const SizedBox(height: 20),
            const Text(
              'This is a detailed description of the product. It includes features, specifications, and other useful information.',
              textAlign: TextAlign.center,
            ), // Product Description
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add to Cart Functionality
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
