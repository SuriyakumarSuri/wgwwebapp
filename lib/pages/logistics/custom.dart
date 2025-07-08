// Import necessary packages
import 'package:flutter/material.dart';
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
            path: '/custom',
            builder: (context, state) => CustomClearancePage(),
          ),

        ],
      ),
    );
  }
}



class CustomClearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          // About Custom Clearance Services Section
          _buildColoredSection(
            title: 'About Custom Clearance Services',
            content:
            'At Modern Western Trans, we understand the complexities of international trade and the crucial role that customs clearance plays in ensuring smooth and efficient shipments. Our services are designed to take the stress out of navigating customs procedures, making your import and export processes seamless, fast, and hassle-free.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),

          // Highlighted Image Section with Image on Left and Content on Right
          _buildImageSection(
            imagePath: 'assets/images/images/custom.jpeg',  // Your image path
            title: 'Custom Clearance Expertise for Seamless Shipping',
            content:
            'We offer expert customs clearance solutions to ensure your shipments comply with global regulations, avoid costly delays, and reduce overall shipping costs. Our team provides tailored solutions to meet the specific needs of your cargo, whether it’s hazardous materials, electronics, or machinery.',
          ),

          // Services Section in Small Colored Container
          _buildSmallColoredSection(
            title: 'Why Choose Our Custom Clearance Services?',
            content:
            'Our expert team, efficient documentation handling, and real-time tracking make us the go-to choice for hassle-free, reliable customs clearance. We ensure that all customs requirements are met, so your shipments arrive on time and without any delays.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),

          // Additional Key Features Section in Small Colored Container
          _buildSmallColoredSection(
            title: 'Key Benefits of Our Services:',
            content:
            'From minimizing delays and costs to offering global reach and expertise, our services are designed to make your shipping process smoother. We also integrate seamlessly with shipping services for a fully managed experience.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),

          FooterSection(),
        ],
      ),
    );
  }

  // Function to Build Colored Section (For About and Other Sections)
  Widget _buildColoredSection({
    required String title,
    required String content,
    required Color? backgroundColor,
    required Color? titleColor,
    required Color? textColor,
  }) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }

  // Function to Build Small Colored Section (For Services and Key Benefits)
  Widget _buildSmallColoredSection({
    required String title,
    required String content,
    required Color? backgroundColor,
    required Color? titleColor,
    required Color? textColor,
  }) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: textColor),
          ),
        ],
      ),
    );
  }

  // Function to Build Image Section with Image on Left and Content on Right
  Widget _buildImageSection({
    required String imagePath,
    required String title,
    required String content,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Left side - Image
          Expanded(
            flex: 1,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20), // Space between image and content
          // Right side - Content
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  content,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
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
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/images/MWT.png', // Replace with your logo's asset path
            height: 75,
            width: 75,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 10),
          // Text(
          //   'Modern Western Trans',
          //   style: TextStyle(color: Colors.white),
          // ),
        ],
      ),
      backgroundColor: Color(0xFF003366),
      actions: [
        TextButton(
          onPressed: () {
            context.go('/');
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

        // 📌 Services Dropdown with PopupMenuButton
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: PopupMenuButton<String>(
            offset: Offset(0, 50), // Dropdown below the button
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
            itemBuilder: (BuildContext context) => [
              buildPopupMenuItem('Project Handling Services', '/projecthandling'),
              buildPopupMenuItem('DG Cargo Handling', '/cargohandling'),
              buildPopupMenuItem('Packaging Services', '/packaging'),
              buildPopupMenuItem('Custom Clearance Services', '/custom'),
              buildPopupMenuItem('Warehouse Freight Service', '/warehouse'),
              buildPopupMenuItem('Land Freight Service', '/land'),
              buildPopupMenuItem('Ocean Freight Service', '/ocean'),
              buildPopupMenuItem('Air Freight Service', '/air'),
              buildPopupMenuItem('Browse All Services', '/service'),
            ],
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
            context.go('/contactus');
          },
          child: Text('Contact Us', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  /// 📌 Helper Function for Compact Dropdown Menu Items
  PopupMenuItem<String> buildPopupMenuItem(String title, String route) {
    return PopupMenuItem<String>(
      value: route,
      height: 36, // Compact height
      child: HoverableMenuItem(title: title),
    );
  }
}
// Section Widget --------------------------
class Section extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final String content;

  Section({this.backgroundColor, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
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
           // HeroSection(),
            AboutUsSection(),
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
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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




