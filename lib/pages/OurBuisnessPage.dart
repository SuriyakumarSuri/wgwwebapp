import 'package:flutter/material.dart';

class OurBuisnessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Our Business')),
      body: Center(
        child: Text(
          'Welcome to Our Business.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
