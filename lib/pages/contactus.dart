import 'package:flutter/material.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'package:wgwwebapp/utils/pageTheme.dart';

class ContactUsPage extends StatefulWidget {
  final PageTheme theme;
  const ContactUsPage({Key? key, required this.theme}) : super(key: key);
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _resetForm() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
  }

PreferredSizeWidget getAppBar() {
    switch (widget.theme) {
      case PageTheme.construction:
        return const MainPageAppBar();
      case PageTheme.manpower:
        return const SubMainPageAppBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: [
          // Scrollable form section
          Expanded(
            child: Stack(
              children: [
                // Background image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg-career.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.orange.shade100.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                // Scrollable form content
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Card(
                        color: Colors.white.withOpacity(0.95),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    "Have Questions? Fill Out The Form Below To Get In Touch:",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                _buildTextField(
                                  controller: _usernameController,
                                  label: 'Full Name',
                                  icon: Icons.person,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter your name'
                                          : null,
                                ),
                                SizedBox(height: 20),
                                _buildTextField(
                                  controller: _phoneController,
                                  label: 'Phone Number',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) =>
                                      value == null || value.length < 10
                                          ? 'Enter a valid phone number'
                                          : null,
                                ),
                                SizedBox(height: 20),
                                _buildTextField(
                                  controller: _emailController,
                                  label: 'Email (Gmail only)',
                                  icon: Icons.email,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(r'^[^@]+@gmail\.com$')
                                            .hasMatch(value)) {
                                      return 'Enter a valid Gmail address';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    labelText: 'Message',
                                    prefixIcon: Icon(Icons.message),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter a message'
                                          : null,
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.send),
                                      label: Text("Submit"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title:
                                                  Text("Application Submitted"),
                                              content: Text(
                                                  "Thank you, ${_usernameController.text}!"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text("Close"),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    OutlinedButton.icon(
                                      icon: Icon(Icons.refresh),
                                      label: Text("Reset"),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.deepOrange,
                                        side: BorderSide(
                                            color: Colors.deepOrange),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: _resetForm,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Always-visible footer
          FooterSection(theme: widget.theme,),
        ],
      ),
    );
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
