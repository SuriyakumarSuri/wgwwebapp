import 'package:flutter/material.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';

class OurOfficesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      body:                                                                                                                                                                                                                                                      Center(
        child: Center(
          child: Text(
            "Welcome to our office section"
            )
        ),
      ),
    );
  }
}
