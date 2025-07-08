import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

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
            path: '/quoterequest',
            builder: (context, state) => QuoteRequest(),
          ),

        ],
      ),
    );
  }
}

class QuoteRequest extends StatefulWidget {
  @override
  _QuoteRequestState createState() => _QuoteRequestState();
}

class _QuoteRequestState extends State<QuoteRequest> {

  String? _filePath;
  Uint8List? _fileBytes;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _departureCountryController = TextEditingController();
  final _departureTownController = TextEditingController();
  final _arrivalCountryController = TextEditingController();
  final _arrivalTownController = TextEditingController();
  final _cargoDescriptionController = TextEditingController();
  final _cargoWeightController = TextEditingController();
  final _cargoSizeController = TextEditingController();
  final _otherDetailsController = TextEditingController();

  // FocusNodes for the fields
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _telephoneFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _departureCountryFocusNode = FocusNode();
  final FocusNode _departureTownFocusNode = FocusNode();
  final FocusNode _arrivalCountryFocusNode = FocusNode();
  final FocusNode _arrivalTownFocusNode = FocusNode();
  final FocusNode _cargoDescriptionFocusNode = FocusNode();
  final FocusNode _cargoWeightFocusNode = FocusNode();
  final FocusNode _cargoSizeFocusNode = FocusNode();
  final FocusNode _otherDetailsFocusNode = FocusNode();

  // Dropdown values
  String? _collectAsap = 'COLLECT ASAP'; // Default value
  String? _deliverAsap = 'DELIVER ASAP'; // Default value
  String? _selectContainer = 'SELECT CONTAINER'; // Default value

  // API endpoint
  final String _apiUrl = 'https://quote-request-backend-896ba0aaa29d.herokuapp.com/send-quote-request';

  @override
  void initState() {
    super.initState();

    // Add listeners to each focus node
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        // Handle focus
      }
    });

    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        // Handle focus
      }
    });
  }

  @override
  void dispose() {
    // Dispose the focus nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _telephoneFocusNode.dispose();
    _companyFocusNode.dispose();
    _departureCountryFocusNode.dispose();
    _departureTownFocusNode.dispose();
    _arrivalCountryFocusNode.dispose();
    _arrivalTownFocusNode.dispose();
    _cargoDescriptionFocusNode.dispose();
    _cargoWeightFocusNode.dispose();
    _cargoSizeFocusNode.dispose();
    _otherDetailsFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(), // Custom AppBar here
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quote Request \n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Text(
                'Submit your details below, and our team will promptly provide you with a customized and competitive quote tailored to your needs.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Alternatively, contact us at +966-56-7273714 or email sales@mwtworld.com. We are here to assist you!',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Name *', _nameController, _nameFocusNode)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Email *', _emailController, _emailFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Telephone *', _telephoneController, _telephoneFocusNode)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Company Name', _companyController, _companyFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Departure Country *', _departureCountryController, _departureCountryFocusNode)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Departure Town/City *', _departureTownController, _departureTownFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Arrival Country *', _arrivalCountryController, _arrivalCountryFocusNode)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Arrival Town/City *', _arrivalTownController, _arrivalTownFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildDropdownField('Collect ASAP *', (value) {
                          setState(() {
                            _collectAsap = value;
                          });
                        }, _collectAsap, [
                          'COLLECT ASAP',
                          'COLLECT IN 1-2 WEEKS',
                          'COLLECT IN 2-3 WEEKS',
                          'COLLECT IN 1 MONTH',
                          'COLLECT IN 2-3 MONTHS',
                          'COLLECT IN 4-6 MONTHS',
                        ])),
                        SizedBox(width: 16),
                        Expanded(child: _buildDropdownField('Deliver ASAP *', (value) {
                          setState(() {
                            _deliverAsap = value;
                          });
                        }, _deliverAsap, [
                          'DELIVER ASAP',
                          'DELIVER IN 1-2 WEEKS',
                          'DELIVER IN 2-3 WEEKS',
                          'DELIVER IN 1 MONTH',
                          'DELIVER IN 2-3 MONTHS',
                          'DELIVER IN 4-6 MONTHS',
                        ])),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Cargo Description *', _cargoDescriptionController, _cargoDescriptionFocusNode)),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Cargo Weight, if known, in kilograms', _cargoWeightController, _cargoWeightFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildDropdownField('Select Container *', (value) {
                          setState(() {
                            _selectContainer = value;
                          });
                        }, _selectContainer, [
                          'SELECT CONTAINER',
                          '40FT CONTAINER',
                          '20FT CONTAINER',
                          'PART CONTAINER',
                          'PALLETISED',
                          'AIR FREIGHT',
                          'OUT OF GAUGE',
                          'OTHER',
                        ])),
                        SizedBox(width: 16),
                        Expanded(child: _buildTextField('Cargo Size, if known, in metres', _cargoSizeController, _cargoSizeFocusNode)),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField('Any other details that may be useful for us to know about your shipment', _otherDetailsController, _otherDetailsFocusNode),
                    SizedBox(height: 20),
                    _buildFilePicker(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text('Submit Request'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _resetForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text('Reset'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              FooterSection(),  // Footer section added here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, FocusNode focusNode) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdownField(String label, Function(String?) onChanged, String? selectedValue, List<String> options) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
    );
  }

  Widget _buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attach File'),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Choose File', style: TextStyle(color: Colors.black)),
              SizedBox(width: 10),
              Text(
                _filePath != null ? _filePath!.split('/').last : 'No file chosen',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'doc', 'docx'], // Allow only PDF, DOC, and DOCX
      type: FileType.custom,
    );
    if (result != null) {
      setState(() {
        _filePath = result.files.single.name;
        _fileBytes = result.files.single.bytes;
      });
    }
  }

  Future<void> _submitForm() async {
    var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

    // Add form data
    request.fields['name'] = _nameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['telephone'] = _telephoneController.text;
    request.fields['company'] = _companyController.text;
    request.fields['departure_country'] = _departureCountryController.text;
    request.fields['departure_town'] = _departureTownController.text;
    request.fields['arrival_country'] = _arrivalCountryController.text;
    request.fields['arrival_town'] = _arrivalTownController.text;
    request.fields['cargo_description'] = _cargoDescriptionController.text;
    request.fields['cargo_weight'] = _cargoWeightController.text;
    request.fields['cargo_size'] = _cargoSizeController.text;
    request.fields['other_details'] = _otherDetailsController.text;

    // Add dropdown values
    request.fields['collectAsap'] = _collectAsap ?? 'COLLECT ASAP';
    request.fields['deliverAsap'] = _deliverAsap ?? 'No';
    request.fields['select_container'] = _selectContainer ?? 'No';

    // Add file if selected
    if (_fileBytes != null) {
      var byteStream = http.ByteStream.fromBytes(_fileBytes!);
      var length = _fileBytes!.length;

      var multipartFile = http.MultipartFile(
        'attachment',
        byteStream,
        length,
        filename: _filePath,
        contentType: MediaType('application', 'pdf'),
      );

      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request submitted successfully! We will get back to you.")));
      } else {
        final responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to submit the request.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _telephoneController.clear();
      _companyController.clear();
      _departureCountryController.clear();
      _departureTownController.clear();
      _arrivalCountryController.clear();
      _arrivalTownController.clear();
      _cargoDescriptionController.clear();
      _cargoWeightController.clear();
      _cargoSizeController.clear();
      _otherDetailsController.clear();
      _collectAsap = 'COLLECT ASAP';
      _deliverAsap = 'No';
      _selectContainer = 'No';
      _filePath = null;
      _fileBytes = null;
    });
  }
}


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuoteRequest(),
  ));
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
              padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
              child: GestureDetector(
                onTap: () {
                  context.go('/'); // Navigate to home page on image tap
                },
                child: Image.asset(
                  'assets/images/images/MWT.png', // Image for the logo
                  height: 80, // Height of the image (same as home page)
                  width: 80, // Width of the image (same as home page)
                  fit: BoxFit.fill, // Ensures the image fills the space without distortion
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/'); // Navigate to home page
            },
            child: Text(
              'Home',
              style: TextStyle(
                color: currentRoute == '/' ? Colors.yellow : Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/AboutUsPage');
            },
            child: Text(
              'About Us',
              style: TextStyle(
                color: currentRoute == '/AboutUsPage' ? Colors.yellow : Colors.white,
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
                  buildPopupMenuItem('Project Handling Services', '/projecthandling'),
                  buildPopupMenuItem('DG Cargo Handling', '/cargohandling'),
                  buildPopupMenuItem('Packaging Services', '/packaging'),
                  buildPopupMenuItem('Custom Clearance Services', '/custom'),
                  buildPopupMenuItem('Warehouse Freight Service', '/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/land'),
                  buildPopupMenuItem('Ocean Freight Service', '/ocean'),
                  buildPopupMenuItem('Air Freight Service', '/air'),
                  buildPopupMenuItem('Browse all', '/service'),
                ];
              },
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/officeaddress'); // Navigates to Contact Us page
            },
            child: Text('Our Offices', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.go('/quoterequest'); // Navigates to Contact Us page
            },
            child: Text('Quote Request', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              context.go('/contactus'); // Navigate to Contact Us page
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
// Section Widget --------------------------
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
              context.go('/AboutUsPage');
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
                  buildPopupMenuItem('Project Handling Services', '/projecthandling'),
                  buildPopupMenuItem('DG Cargo Handling', '/cargohandling'),
                  buildPopupMenuItem('Packaging Services', '/packaging'),
                  buildPopupMenuItem('Custom Clearance Services', '/custom'),
                  buildPopupMenuItem('Warehouse Freight Service', '/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/land'),
                  buildPopupMenuItem('Ocean Freight Service', '/ocean'),
                  buildPopupMenuItem('Air Freight Service', '/air'),
                  buildPopupMenuItem('Browse all', '/service'),
                ];
              },
            ),
          ),

          TextButton(
            onPressed: () {
              context.go('/contactus'); // Navigates to Contact Us page
            },
            child: Text('Contact Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HeroSection(),
            //AboutUsSection(),
            // ServicesSection(),
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
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced padding
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
/// Service Data
final List<Map<String, String>> _serviceData = [
  {
    'imagePath': 'assets/images/images/freight.jpg',
    'title': 'Freight Forwarding',
    'description': 'Seamless Global Cargo Solutions: Navigating complex logistics with precision, efficiency, and reliability. Our freight forwarding services ensure your goods move swiftly across borders, connecting continents and powering businesses with end-to-end transparency and care.',
  },
  {
    'imagePath': 'assets/images/images/supplychain.jpg',
    'title': 'Supply Chain Management',
    'description': 'Optimize, Streamline, and Succeed: Our Supply Chain Management solutions ensure seamless coordination across procurement, production, and logistics. With advanced analytics, real-time tracking, and strategic planning, we empower your business to reduce costs, enhance efficiency, and deliver excellence at every step.',
  },
  {
    'imagePath': 'assets/images/images/inventory.jpg',
    'title': 'Inventory Management',
    'description': 'Our inventory management system makes logistics easier and more efficient. With real-time tracking and automatic updates, you’ll always know your stock levels and be able to fulfill orders on time. Say goodbye to stockouts and delays, and keep your supply chain running smoothly. Let us help you manage your inventory more effectively and improve your logistics operations.',
  },
  {
    'imagePath': 'assets/images/images/custom.jpg',
    'title': 'Customs Clearance',
    'description': 'Effortless Border Solutions: Our Customs Clearance service ensures your shipments cross borders smoothly. We handle all the paperwork, regulations, and compliance so you can focus on your business. No delays, no hassles—just seamless, stress-free shipping.',
  },
  {
    'imagePath': 'assets/images/images/warehouse.jpg',
    'title': 'Warehousing',
    'description': 'Secure and Efficient Storage: Our warehousing service keeps your products safe, organized, and ready for quick access. With real-time tracking and efficient handling, we ensure your goods are always prepared for timely delivery. Your storage needs, simplified.',
  },
  {
    'imagePath': 'assets/images/images/distribution.jpg',
    'title': 'Distribution Services',
    'description': 'Distribution Services ensure your products are delivered on time and in perfect condition. We handle everything from storage to final delivery, using smart routes and real-time tracking to keep things smooth and efficient. Your goods, delivered reliably every time..',
  },
  {
    'imagePath': 'assets/images/images/consult.jpg',
    'title': 'Consultation Services',
    'description': 'Consultation Services provide expert guidance to optimize your logistics operations. We analyze your challenges, offer tailored solutions, and help you streamline processes for better efficiency and cost savings. Your success is our priority, every step of the way..',
  },
  {
    'imagePath': 'assets/images/images/ecomerce.jpg',
    'title': 'E-Commerce Logistics',
    'description': 'Efficient and reliable logistics for your eCommerce business. We handle shipping, storage, and delivery so you can focus on growing your store. Fast, safe, and affordable solutions to get your products to customers on time, every time.',
  },
];

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
          SizedBox(height:10.0),
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

/// Helper method to build dropdown items with custom spacing
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

