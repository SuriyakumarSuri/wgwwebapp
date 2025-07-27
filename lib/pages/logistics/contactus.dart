import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MWT Logistics',
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: '/', // It’s common to start from home screen
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: '/contact',
            builder: (context, state) => ContactForm(),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/images/MWT.png', // Replace with your logo's asset path
              height: 40, // Adjust height as needed
            ),
            SizedBox(width: 10), // Space between logo and title text
            Text(
              'Modern Western Trans',
              style: TextStyle(color: Colors.white), // Text color set to white
            ),
          ],
        ),
        backgroundColor: Color(0xFF003366), // Deep blue background color
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.go('/logistics/AboutUsPage');
            },
            child: Text('About Us', style: TextStyle(color: Colors.white)),
          ),

          // Services Dropdown
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: PopupMenuButton<String>(
              offset: Offset(0, 50), // Adjust dropdown position
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
              onSelected: (String value) {
                context.go(value); // Navigate to selected route
              },
              itemBuilder: (BuildContext context) {
                return [
                  buildPopupMenuItem('Project Handling Services',
                      '/logistics/projecthandling'),
                  buildPopupMenuItem(
                      'DG Cargo Handling', '/logistics/cargohandling'),
                  buildPopupMenuItem(
                      'Packaging Services', '/logistics/packaging'),
                  buildPopupMenuItem(
                      'Custom Clearance Services', '/logistics/custom'),
                  buildPopupMenuItem(
                      'Warehouse Freight Service', '/logistics/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/logistics/land'),
                  buildPopupMenuItem(
                      'Ocean Freight Service', '/logistics/ocean'),
                  buildPopupMenuItem('Air Freight Service', '/logistics/air'),
                  buildPopupMenuItem('Browse all', '/logistics/service'),
                ];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: PopupMenuButton<String>(
              offset: const Offset(0, 60),
              color: Colors.white,
              child: const Row(
                children: [
                  Text('Business Groups',
                      style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
                ],
              ),
              onSelected: (value) => context.go(value),
              itemBuilder: (_) => [
                buildPopupMenuItem('Construction', '/'),
                buildPopupMenuItem('Manpower', '/manpower'),
                buildPopupMenuItem('Event Management', '/event'),
                buildPopupMenuItem('Browse all', '/ourbusiness'),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .go('/logistics/contactus'); // Navigates to Contact Us page
            },
            child: Text('Contact Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeroSection(),
            AboutUsSection(),
            //ServicesSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }

  /// Helper Method for PopupMenuItem with Compact Design
  PopupMenuItem<String> buildPopupMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 36, // Reduce the default height
      child: HoverableMenuItem(title: title),
    );
  }
}

/// Hoverable Menu Item Widget with Compact Styling
class HoverableMenuItem extends StatefulWidget {
  final String title;

  HoverableMenuItem({required this.title});

  @override
  _HoverableMenuItemState createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<HoverableMenuItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 4.0, horizontal: 8.0), // Reduced padding
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14, // Compact font size
            color: _isHovered ? Colors.black : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  ContactFormState createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  Future<void> submitForm() async {
    final url = Uri.parse(
        'https://arcane-savannah-81157-3910b63c09f7.herokuapp.com/contact');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'message': _messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(
                'Your details have been submitted successfully! Our executive will contact you soon.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        // Clear form fields without showing the reset message
        _formKey.currentState?.reset();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      } else {
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Failed'),
            content: Text('Failed to submit query. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print(error);
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An unexpected error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();

    // Show reset confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Form Reset'),
        content: Text('All fields have been cleared successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Have questions? Fill out the form below to get in touch:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email';
                        }
                        // Regular expression for a valid email
                        String emailPattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(emailPattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your phone' : null,
                    ),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(labelText: 'Message'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your message' : null,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submitForm();
                            }
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: resetForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          FooterSection(), // Footer at the bottom
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? currentRoute;

  CustomAppBar({this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(85), // Set height for AppBar
      child: AppBar(
        backgroundColor: Color(0xFF003366), // Deep blue background color
        flexibleSpace: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10), // Adjust padding as needed
              child: GestureDetector(
                onTap: () {
                  context.go(
                      '/logistics/home'); // Navigate to home page on image tap
                },
                child: Image.asset(
                  'assets/images/images/MWT.png', // Image for the logo
                  height: 80, // Height of the image (same as home page)
                  width: 80, // Width of the image (same as home page)
                  fit: BoxFit
                      .fill, // Ensures the image fills the space without distortion
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/logistics/home'); // Navigate to home page
            },
            child: Text(
              'Home',
              style: TextStyle(
                color: currentRoute == '/logistics/home'
                    ? Colors.yellow
                    : Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/logistics/AboutUsPage');
            },
            child: Text(
              'About Us',
              style: TextStyle(
                color: currentRoute == '/logistics/AboutUsPage'
                    ? Colors.yellow
                    : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: PopupMenuButton<String>(
              offset: Offset(0, 50), // Adjust dropdown position
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
              onSelected: (String value) {
                context.go(value); // Navigate to selected route
              },
              itemBuilder: (BuildContext context) {
                return [
                  buildPopupMenuItem('Project Handling Services',
                      '/logistics/projecthandling'),
                  buildPopupMenuItem(
                      'DG Cargo Handling', '/logistics/cargohandling'),
                  buildPopupMenuItem(
                      'Packaging Services', '/logistics/packaging'),
                  buildPopupMenuItem(
                      'Custom Clearance Services', '/logistics/custom'),
                  buildPopupMenuItem(
                      'Warehouse Freight Service', '/logistics/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/logistics/land'),
                  buildPopupMenuItem(
                      'Ocean Freight Service', '/logistics/ocean'),
                  buildPopupMenuItem('Air Freight Service', '/logistics/air'),
                  buildPopupMenuItem('Browse all', '/logistics/service'),
                ];
              },
            ),
          ),
          TextButton(
            onPressed: () {
              context.go(
                  '/logistics/officeaddress'); // Navigates to Contact Us page
            },
            child: Text('Our Offices', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.go(
                  '/logistics/quoterequest'); // Navigates to Contact Us page
            },
            child: Text('Quote Request', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.go('/logistics/contactus'); // Navigate to Contact Us page
            },
            child: Text('Contact Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(85); // Increased height for AppBar

  /// Helper function for Compact Dropdown Menu Items
  PopupMenuItem<String> buildPopupMenuItem(String title, String route) {
    return PopupMenuItem<String>(
      value: route,
      height: 36, // Compact height
      child: HoverableMenuItem(title: title),
    );
  }
}

//About us//
class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5), // Light gray background
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'MWT Logistics Solution',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F), // Red color
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Modern Western Trans – Your Trusted Partner in Logistics and Transportation.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'At Modern Western Trans, we take pride in being a leader in the logistics industry for over a decade. Our dedication to excellence has earned us a reputation built on trust and reliability. With an extensive global network and years of experience, we ensure seamless, efficient, and hassle-free services to our customers worldwide. Join us and experience logistics solutions that go beyond expectations, delivering success every step of the way.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Founded in 2009, Modern Western Trans was created with a singular vision: to be the trusted partner in our clients journey to success. With a commitment to innovation and excellence, we have consistently worked alongside our clients, turning challenges into opportunities and ensuring mutual growth every step of the way.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD32F2F), // Red color
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'READ MORE',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Image.asset(
                  'assets/images/images/port4.jpg', // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --------------------------
// Footer Section
// --------------------------
class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF003366),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Contact Info Column (Left)
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Get In Touch:',
              //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //     SizedBox(height: 8.0),
              //     Text(
              //       'Phone: +966567273714',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     // Text(
              //     //   'Phone: +966593619999',
              //     //   style: TextStyle(color: Colors.orange),
              //     // ),
              //     SizedBox(height: 8.0),
              //     Text(
              //       'Email: sales@mwtworld.com',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //
              //   ],
              // ),
              // Address Column (Right)
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              //   children: [
              //     Text(
              //       'Address:',
              //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //     SizedBox(height: 8.0),
              //     Text(
              //       'Al Azhar Building Tower',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     Text(
              //       'Al Safa Dist',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     Text(
              //       'Jeddah 23535, Saudi Arabia',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 16.0),
          // Footer Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2024 MWT Solutions. All rights reserved.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

DropdownMenuItem<String> buildDropdownMenuItem(String text, String? value,
    {bool isHeader = false, bool isBold = false, Color? color}) {
  return DropdownMenuItem<String>(
    value: value,
    enabled: !isHeader, // Disable header row selection
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 2.0), // Controls vertical spacing
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: color ?? (isHeader ? Colors.grey : Colors.black),
          fontSize: isHeader ? 14 : 14,
        ),
      ),
    ),
  );
}
