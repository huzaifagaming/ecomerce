import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Categories Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}