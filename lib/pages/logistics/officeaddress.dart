import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            path: '/officeaddress',
            builder: (context, state) => OfficeAddressMenu(),
          ),

        ],
      ),
    );
  }
}

class OfficeAddressMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Our Offices" Heading
                    Text(
                      "Our Offices",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildOfficeCard(
                            context,
                            'MWT Logistic Solution Head Office - JEDDAH',
                            'Al Azhar Building Tower - 7th Floor - Office # 601, Al Safa Dist.,Jeddah 23535 -Kingdom of Saudi Arabia',
                             // '+966-12 644 4799 | 644 6662 | 642 1285',
                            '+966-56-7273714',
                            'sales@mwtworld.com',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildOfficeCard(
                            context,
                            'MWT Logistic Solution - Oman',
                            '111 - Ruwi Street, 1st Floor-Building 202 , Muscat, Oman',
                            //'+966-11-479 0029',
                            '+968-98803274',
                            'sales@mwtworld.com',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildOfficeCard(
                            context,
                            'MWT Logistic Solution - Dubai',
                            'Adel Ahmed Al Wahedi Building,Office # 273,Al Marrar,Dubai,United Arab Emirates',
                            //'+966-13-833 9510',
                            '+971-585005581',
                            'sales@mwtworld.com',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          FooterSection(), // Footer stays at the bottom
        ],
      ),
    );
  }

  Widget _buildOfficeCard(BuildContext context, String title, String address,
       String phone, String email) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              address,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 8),

            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Text('Call Customer Service: $phone'),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 8),
                Text('Email: $email'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OfficeAddressMenu(),
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






