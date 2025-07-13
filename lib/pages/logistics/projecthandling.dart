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
        initialLocation: '/logistics/home', // It’s common to start from home screen
        routes: [
          GoRoute(
            path: '/logistics/home',
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: '/logistics/AboutUsPage',
            builder: (context, state) => AboutUsPage(),
          ),
          GoRoute(
            path: '/logistics/projecthandling',
            builder: (context, state) => ProjectHandlingPage(), // Rename to ProjectHandlingPage
          ),
        ],
      ),
    );
  }
}
// -------------------------- HomePage AppBar --------------------------
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

// -------------------------- project handling Page --------------------------


class ProjectHandlingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          // About Project Handling Services Section
          _buildColoredSection(
            title: 'About Project Handling Services',
            content:
            'At Modern Western Trans, we are leaders in the art of project logistics, offering end-to-end solutions for large-scale, intricate projects. From infrastructure development to specialized cargo transport, we ensure smooth execution of complex logistics.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),

          // Highlighted Image Section with Image on Left and Content on Right
          _buildImageSection(
            imagePath: 'assets/images/images/project2.jpg',
            title: 'Our Project Management Expertise',
            content:
            'With over 10 years of experience, we offer specialized project management expertise to handle complex logistics needs. Our services ensure the efficient movement of oversized cargo, break-bulk shipments, and heavy-lift transportation.',
          ),

          // Services Section in Small Colored Container
          _buildSmallColoredSection(
            title: 'Our Services Include:',
            content:
            'Our expert team works closely with you to understand the unique requirements of your project, providing tailored solutions that prioritize efficiency, safety, and cost-effectiveness.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),

          // Why Choose Us Section in Small Colored Container
          _buildSmallColoredSection(
            title: 'Why Choose Us?',
            content:
            'We have a proven track record of successful project management, expert teams, and innovative solutions, ensuring the success of your project from start to finish.',
            backgroundColor: Colors.teal[50],
            titleColor: Colors.teal[900],
            textColor: Colors.teal[700],
          ),
          FooterSection(),
        ],

      ),
    );
  }

  // Function to Build Colored Section
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

  // Function to Build Small Colored Section (For Services and Why Choose Us)
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




class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Section(
            backgroundColor: Colors.blue[50],
            title: 'About MWT Logistics',
            content: 'About MWT Logistics Welcome to MWT Logistics, a leader in the logistics and supply chain industry. We are dedicated to providing comprehensive and efficient solutions for businesses of all sizes. With a focus on reliability, innovation, and customer satisfaction, MWT Logistics ensures the seamless movement of goods across the globe, empowering businesses to grow and thrive in an increasingly connected world.',
          ),

          // Image with Text on Top
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/images/hamburg.jpg', // Replace with your image path
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),

              Text(
                'With a focus on reliability, we guarantee that your cargo is delivered safely and securely,\n                                                              '
                    'no matter the distance.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black.withOpacity(0.5), // Optional for better visibility
                ),
              )

            ],
          ),
          // Add Advantages Section
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'OUR ADVANTAGES',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdvantageCard(
                      icon: Icons.rocket,
                      title: 'Fast Delivery',
                      description:
                      'With our Express Delivery network, we provide swift and seamless transportation of your cargo to destinations within the Kingdom and nearby countries, meeting your tight schedules.',
                    ),
                    AdvantageCard(
                      icon: Icons.headset_mic,
                      title: 'Client Support',
                      description:
                      'A 24/7 customer dedicated service enabling us to strengthen our support with tailor-made solutions beyond your expectations.',
                    ),
                    AdvantageCard(
                      icon: Icons.security,
                      title: 'Secure Services',
                      description:
                      'MWYT deployed technologies will provide you with a multitude of services to secure your interest at the highest international standard.',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Vision',
            content:'To be the most trusted and innovative logistics partner, '
                'providing exceptional services that help businesses thrive '
                'in a dynamic global economy.',

          ),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Mission',
            content:
            'Our mission is to provide efficient, reliable, and cost-effective '
                'logistics solutions that empower businesses, enhance supply chain '
                'management, and create lasting relationships with our clients.',
          ),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Core Values',
            content: '1. **Customer Focus**: Tailored logistics solutions.\n\n'
                '2. **Innovation**: Embrace technology.\n\n'
                '3. **Integrity**: Honesty and transparency.\n\n'
                '4. **Excellence**: Service excellence and customer satisfaction.',
          ),
          LogisticsDistributionContainer(),
          Stack(
            children: [
              // Image as the background
              Image.asset(
                'assets/images/images/road.jpg', // Replace with your image path
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),

              // Center the text and button in the middle of the image
              Align(
                alignment: Alignment.center, // Center the content inside the Stack
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure the Column takes up minimum space
                  children: [
                    Text(
                      'Would you like to know more?',
                      textAlign: TextAlign.center, // Centers the text itself
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black.withOpacity(0.5), // Optional for better visibility
                      ),
                    ),
                    SizedBox(height: 20), // Optional space between text and button
                    ElevatedButton(
                      onPressed: () {
                        // Define what happens when the button is pressed
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
                      ),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),








          FooterSection(), // Footer will appear at the bottom after scrolling
        ],
      ),
    );
  }
}
class LogisticsDistributionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 20), // Spacing between containers
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Text and Progress Bars
          Expanded(
            flex: 2, // Adjust flex to control space allocation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'WE ARE DISTRIBUTING OUR SERVICES\n  ACROSS THE GLOBE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Road Freight
                    _buildDistributionRow(
                      label: 'Road Freight (Temp Controlled)',
                      percentage: 0.5,
                      color: Colors.red,
                    ),
                    SizedBox(height: 20),

                    // International Freight
                    _buildDistributionRow(
                      label: 'International Freight (Temp Controlled)',
                      percentage: 0.3,
                      color: Colors.red,
                    ),
                    SizedBox(height: 20),

                    // Warehousing
                    _buildDistributionRow(
                      label: 'Warehousing',
                      percentage: 0.2,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 16), // Space between text and image

          // Right Side: Image
          Expanded(
            flex: 1, // Adjust flex to control space allocation
            child: Image.asset(

                'assets/images/images/newhero1.jpg', // Replace with your image path
                fit: BoxFit.fill,
                height: 300// Adjust to fit within the available space
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionRow({
    required String label,
    required double percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[800],
          color: color,
        ),
        SizedBox(height: 5),
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// -------------------------- Reusable
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

// -------------------------- HomePage --------------------------
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
                  buildPopupMenuItem('Project Handling Services', '/logistics/projecthandling'),
                  buildPopupMenuItem('DG Cargo Handling', '/logistics/cargohandling'),
                  buildPopupMenuItem('Packaging Services', '/logistics/packaging'),
                  buildPopupMenuItem('Custom Clearance Services', '/logistics/custom'),
                  buildPopupMenuItem('Warehouse Freight Service', '/logistics/warehouse'),
                  buildPopupMenuItem('Land Freight Service', '/logistics/land'),
                  buildPopupMenuItem('Ocean Freight Service', '/logistics/ocean'),
                  buildPopupMenuItem('Air Freight Service', '/logistics/air'),
                  buildPopupMenuItem('Browse all', '/logistics/service'),
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
            HeroSection(),
            AboutUsSection(),
            ServicesSection(),
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

// -------------------------- FooterSection --------------------------
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // Contact Info Column (Left)
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Get In Touch:',
          //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //         ),
          //         SizedBox(height: 8.0),
          //         Text(
          //           'Phone: +966567273714',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         SizedBox(height: 8.0),
          //         Text(
          //           'Email: sales@mwtworld.com',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ],
          //     ),
          //     // Address Column (Right)
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          //       children: [
          //         Text(
          //           'Address:',
          //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //         ),
          //         SizedBox(height: 8.0),
          //         Text(
          //           'Al Azhar Building Tower',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         Text(
          //           'Al Safa Dist',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         Text(
          //           'Jeddah 23535, Saudi Arabia',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
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

// Placeholder Widgets for HomePage Sections
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Welcome to MWT Logistics',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Section(
      backgroundColor: Colors.white,
      title: 'About Us',
      content: 'We deliver logistics excellence.',
    );
  }
}

class ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Section(
      backgroundColor: Colors.blue[50],
      title: 'Our Services',
      content: 'Reliable and efficient logistics services tailored for your needs.',
    );
  }
}
// Define AdvantageCard Widget
class AdvantageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AdvantageCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.red,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// Vision, Mission, and Values Section


class CustomCard extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String content;

  const CustomCard({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ServiceCard widget for displaying each service
// Helper method to build each service tile
Widget _buildServiceTile({required IconData icon, required String title, required String description}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper method for the reasons section
Widget _buildReasonTile({required IconData icon, required String title, required String description}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

