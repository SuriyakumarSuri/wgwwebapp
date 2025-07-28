import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'dart:typed_data';
import 'package:wgwwebapp/utils/pageTheme.dart';

class CareersPage extends StatefulWidget {
  final PageTheme theme;
  const CareersPage({Key? key, required this.theme}) : super(key: key);

  @override
  _CareersPageState createState() => _CareersPageState();
}

class _CareersPageState extends State<CareersPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _filePath;
  Uint8List? _fileBytes;

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'doc', 'docx'],
      type: FileType.custom,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.name;
        _fileBytes = result.files.single.bytes;
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      _filePath = null;
      _fileBytes = null;
    });
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
          image: const DecorationImage(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
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
                                            color: widget.theme.buttonColor,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  _buildInfoCard(),
                                  const SizedBox(height: 30),
                                  _buildTextField(
                                    controller: _usernameController,
                                    label: 'Full Name',
                                    icon: Icons.person,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter your name'
                                            : null,
                                  ),
                                  const SizedBox(height: 20),
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
                                  const SizedBox(height: 20),
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
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _messageController,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      labelText: 'Message',
                                      prefixIcon: const Icon(Icons.message),
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
                                  const SizedBox(height: 20),
                                  _buildFilePicker(),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.send),
                                        label: const Text("Submit Application"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              widget.theme.buttonColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_fileBytes == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
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
                                                title: const Text(
                                                    "Application Submitted"),
                                                content: Text(
                                                    "Thank you, ${_usernameController.text}!"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("Close"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      OutlinedButton.icon(
                                        icon: const Icon(Icons.refresh),
                                        label: const Text("Reset"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor:
                                              widget.theme.buttonColor,
                                          side: BorderSide(
                                              color: widget.theme.buttonColor),
                                          padding: const EdgeInsets.symmetric(
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
                  FooterSection(theme: widget.theme),
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

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.orange.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "We’re a growing company looking for passionate individuals. Submit your application to become a part of something meaningful.",
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Attach Resume / CV',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickResume,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Choose File', style: TextStyle(color: Colors.black)),
              const SizedBox(width: 10),
              Text(
                _filePath ?? 'No file chosen',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
