// Import necessary packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {


  runApp(OceanFreightApp());
}

class OceanFreightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ocean Freight Services',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OceanFreightScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OceanFreightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          // About Ocean Freight Services Section
          _buildColoredSection(
            title: 'About Ocean Freight Services',
            content:
            'MWT offers reliable ocean freight services, ensuring that your cargo reaches its destination safely and on time. We provide FCL and LCL options, global network coverage, and environmentally conscious practices for smooth and cost-effective shipping.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
            verticalPadding: 16,
            horizontalPadding: 16,
          ),

          // Highlighted Image Section with Image on Left and Content on Right
          _buildImageSection(
            imagePath: 'assets/images/images/ocean.jpeg', // Your image path
            title: 'Why Choose MWT Ocean Freight Services?',
            content:
            'With MWT, enjoy a hassle-free experience in ocean freight shipping. We offer transparent processes, expert handling, and real-time tracking to ensure your goods are transported efficiently across continents.',
            imageHeight: 350,
            contentFontSize: 14,
          ),

          // Key Features Section in Small Colored Container
          _buildSmallColoredSection(
            title: 'Key Features of Our Ocean Freight Service',
            content:
            'Our ocean freight services are powered by a global network, flexible solutions, and sustainable practices, ensuring that your cargo is delivered with the utmost care and efficiency.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
            verticalPadding: 16,
            horizontalPadding: 16,
          ),

          // Feature List Section
          _buildFeatureList(),

          // Footer Section
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
    double verticalPadding = 20,
    double horizontalPadding = 20,
  }) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      margin: EdgeInsets.only(bottom: 12), // Reduced bottom margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18, // Slightly smaller title size
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 8), // Reduced space between title and content
          Text(
            content,
            style: TextStyle(fontSize: 14, color: textColor), // Reduced font size
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
    double verticalPadding = 20,
    double horizontalPadding = 20,
  }) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      margin: EdgeInsets.only(bottom: 12), // Reduced bottom margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18, // Slightly smaller title size
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 8), // Reduced space between title and content
          Text(
            content,
            style: TextStyle(fontSize: 14, color: textColor), // Reduced font size
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
    double imageHeight = 350,
    double contentFontSize = 14,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: EdgeInsets.only(bottom: 12), // Reduced bottom margin
      child: Row(
        children: [
          // Left side - Image
          Expanded(
            flex: 1,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: imageHeight,
            ),
          ),
          SizedBox(width: 16), // Reduced space between image and content
          // Right side - Content
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Slightly smaller title size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8), // Reduced space between title and content
                Text(
                  content,
                  style: TextStyle(fontSize: contentFontSize, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to Build the Feature List Section
  Widget _buildFeatureList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Features:',
            style: TextStyle(
              fontSize: 18, // Slightly smaller font size
              fontWeight: FontWeight.w600,
              color: Colors.teal[900],
            ),
          ),
          SizedBox(height: 8), // Reduced space between title and list
          FeatureItem(
            icon: Icons.public,
            title: 'Global Network',
            description: 'Seamless connectivity across major ports worldwide.',
          ),
          FeatureItem(
            icon: Icons.build,
            title: 'Flexible Solutions',
            description: 'Tailored FCL and LCL options for all shipment sizes.',
          ),
          FeatureItem(
            icon: Icons.visibility,
            title: 'Transparent Processes',
            description: 'Real-time tracking and robust documentation support.',
          ),
          FeatureItem(
            icon: Icons.eco,
            title: 'Sustainable Practices',
            description: 'Environmentally friendly logistics solutions.',
          ),
          FeatureItem(
            icon: Icons.support_agent,
            title: 'Expert Handling',
            description: 'Safe handling of oversized, perishable, and hazardous cargo.',
          ),
        ],
      ),
    );
  }
}

// Feature Item Widget
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal[900], size: 28), // Reduced icon size
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Reduced font size
      ),
      subtitle: Text(
        description,
        style: TextStyle(fontSize: 12, color: Colors.black87), // Reduced font size
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
            context.go('/logistics/home');
          },
          child: Text(
            'Home',
            style: TextStyle(
              color: currentRoute == '/logistics/home' ? Colors.yellow : Colors.white,
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
              color: currentRoute == '/logistics/AboutUsPage' ? Colors.yellow : Colors.white,
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
              buildPopupMenuItem('Project Handling Services', '/logistics/projecthandling'),
              buildPopupMenuItem('DG Cargo Handling', '/logistics/cargohandling'),
              buildPopupMenuItem('Packaging Services', '/logistics/packaging'),
              buildPopupMenuItem('Custom Clearance Services', '/logistics/custom'),
              buildPopupMenuItem('Warehouse Freight Service', '/logistics/warehouse'),
              buildPopupMenuItem('Land Freight Service', '/logistics/land'),
              buildPopupMenuItem('Ocean Freight Service', '/logistics/ocean'),
              buildPopupMenuItem('Air Freight Service', '/logistics/air'),
              buildPopupMenuItem('Browse All Services', '/logistics/service'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            context.go('/logistics/officeaddress'); // Navigates to Contact Us page
          },
          child: Text('Our Offices', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            context.go('/logistics/quoterequest'); // Navigates to Contact Us page
          },
          child: Text('Quote Request', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            context.go('/logistics/contactus');
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
                  buildPopupMenuItem('Project Handling Services', '/logistics/projecthandling'),
                  buildPopupMenuItem('DG Cargo Handling', '/logistics/cargohandling'),
                  buildPopupMenuItem('Packaging Services', '/logistics/packaging'),
                  buildPopupMenuItem('Custom Clearance Services', '/logistics/custom'),
                  buildPopupMenuItem('Warehouse Freight Service', '/logistics/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/logistics/land'),
                  buildPopupMenuItem('Ocean Freight Service', '/logistics/ocean'),
                  buildPopupMenuItem('Browse all', '/logistics/service'),
                ];
              },
            ),
          ),

          TextButton(
            onPressed: () {
              context.go('/logistics/contactus'); // Navigates to Contact Us page
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




