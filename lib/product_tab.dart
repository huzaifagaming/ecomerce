import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Products Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}