import 'package:flutter/material.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';

class CareersPage extends StatefulWidget {
  @override
  _CareersPageState createState() => _CareersPageState();
}

class _CareersPageState extends State<CareersPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Careers", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 20),

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone/Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Gmail'),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@]+@gmail\.com$').hasMatch(value)) {
                    return 'Enter a valid Gmail address';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // You can handle form submission here
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Submitted"),
                          content: Text("Thank you, ${_usernameController.text}!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
