import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'dart:io';

import 'package:wgwwebapp/utils/pageTheme.dart';

class CareersPage extends StatefulWidget {
  final PageTheme theme;
  CareersPage({Key? key, required this.theme}) : super(key: key);
  @override
  _CareersPageState createState() => _CareersPageState();
}

class _CareersPageState extends State<CareersPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  File? _resumeFile;

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => _resumeFile = File(result.files.single.path!));
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() => _resumeFile = null);
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-career.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.orange.shade100.withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                                children: [
                                  Center(
                                    child: Text(
                                      "Join Our Team",
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter a message'
                                            : null,
                                  ),
                                  SizedBox(height: 20),

                                  // Resume Upload
                                  Text(
                                    "Upload Resume / CV",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        icon: Icon(Icons.upload_file),
                                        label: Text(_resumeFile == null
                                            ? "Choose File"
                                            : "Change File"),
                                        onPressed: _pickResume,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _resumeFile != null
                                              ? _resumeFile!.path
                                                  .split('/')
                                                  .last
                                              : "No file selected",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),

                                  // Buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: Icon(Icons.send),
                                        label: Text("Submit Application"),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_resumeFile == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Please upload your resume/CV."),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );
                                              return;
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: Text(
                                                    "Application Submitted"),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FooterSection(theme: widget.theme), // Footer always visible
              ],
            );
          },
        ),
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
