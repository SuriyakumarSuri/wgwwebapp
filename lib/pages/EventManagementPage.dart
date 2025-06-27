import 'package:flutter/material.dart';

class EventManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Management')),
      body:                                                                                                                                                                                                                                                      Center(
        child: Text(
          'Welcome to Event Management Division',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
