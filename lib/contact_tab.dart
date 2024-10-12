import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Contact Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
