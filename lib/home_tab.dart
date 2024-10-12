import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screeen.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Product list and their corresponding prices
  Map<String, double> products = {
    'Smartphone': 699.99,
    'Laptop': 999.99,
    'Headphones': 199.99,
    'Smartwatch': 299.99,
    'Tablet': 399.99,
    'Camera': 499.99,
    'Speaker': 149.99,
    'Monitor': 249.99,
  };

  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products.keys.toList(); // Initialize with all products
  }

  void filterProducts(String query) {
    final filtered = products.keys
        .where((product) =>
        product.toLowerCase().contains(query.toLowerCase())) // Filter logic
        .toList();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterProducts, // Update the list when text is typed
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                String product = filteredProducts[index];
                double price = products[product]!;
                String imageUrl =
                    'https://via.placeholder.com/150'; // Placeholder image for products

                return ListTile(
                  title: Text(product),
                  subtitle: Text('\$${price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreeen(
                          productName: product,
                          productPrice: price,
                          productImage: imageUrl, // Passing the image URL
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

