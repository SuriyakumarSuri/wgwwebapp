import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/pages/home.dart' as home;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WGW Construction',
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          // GoRoute(
          //   path: '/',
          //   builder: (context, state) => HomePage(),
          // ),
          GoRoute(
            path: '/AboutUsPage',
            builder: (context, state) => AboutUsPage(),
          ),
        ],
      ),
    );
  }
}
// -------------------------- HomePage AppBar --------------------------

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? currentRoute;
  const CustomAppBar({Key? key, this.currentRoute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(85), // Set height for AppBar
      child: AppBar(
        backgroundColor: Color(0xFF49020C), // Deep blue background color
        flexibleSpace: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10), // Adjust padding as needed
              child: GestureDetector(
                onTap: () {
                  context.go('/'); // Navigate to home page on image tap
                },
                child: Image.asset(
                  'assets/images/wgw.png', // Image for the logo
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
          Padding(
            padding: const EdgeInsets.only(top: 20), // adjust this value as needed
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      color: currentRoute == '/AboutUsPage'
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/services'); // Navigate to Services page
                  },
                  child: Text(
                    'Our Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/officeaddress'); // Navigates to Contact Us page
                  },
                  child: Text('Our Offices',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/contactus'); // Navigate to Contact Us page
                  },
                  child:
                      Text('Contact Us', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
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

// -------------------------- AboutUsPage --------------------------
class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Section(
            backgroundColor: Colors.blue[50],
            title: 'About WGW ',
            content:
                'Founded in 2020, BuildRight Construction Services has quickly established itself as a reliable and innovative name in the construction industry. With a strong foundation built on quality, safety, and customer satisfaction, we have successfully completed a wide range of projects across residential, commercial, and industrial sectors.Starting with a small but passionate team, we have grown into a full-scale construction company, delivering exceptional services with a commitment to excellence and on-time delivery.',
          ),

          // Image with Text on Top
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/build2.jpg', // Replace with your image path
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
              Text(
                'Your vision. Our mission. Let’s raise the skyline together.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black
                      .withOpacity(0.5), // Optional for better visibility
                ),
              )
            ],
          ),
          // Add Advantages Section

          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Vision',
            content:
                'To provide top-quality construction services using modern techniques and materials, ensuring long-lasting value and satisfaction for our clients. We believe in building not just structures, but lasting relationships through trust and professionalism.',
          ),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Mission',
            content:
                'To become a leading construction company known for innovation, integrity, and excellence — transforming ideas into reality and contributing to the infrastructure growth of our communities.',
          ),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Core Values',
            content: '1. Residential Buildings (Villas, Apartments).\n\n'
                '2. Commercial Projects (Shops, Offices).\n\n'
                '3. Renovation and Remodeling.\n\n'
                '4. Interior Finishing Works.\n\n'
                '5. Structural Repairs & Maintenance.\n\n'
                '6. Project Management & Consultancy.\n\n',
          ),
          const SizedBox(height: 16.0),
          CustomCard(
              backgroundColor: Colors.white,
              title: 'Why Choose Us',
              content: '1. Experienced and skilled workforce.\n\n'
                  '2. Timely project completion.\n\n'
                  '3. High-quality materials and workmanship.\n\n'
                  '4. Transparent communication.\n\n'
                  '5. Competitive pricing.\n\n'),
          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Let’s Build the Future Together',
            content:
                'At BuildRight Construction, every project is a promise — a promise of safety, strength, and satisfaction. Whether it’s your dream home or a large-scale development, we are here to build it right.',
          ),

          FooterSection(), // Footer will appear at the bottom after scrolling
        ],
      ),
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

// -------------------------- FooterSection --------------------------
class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF3A0303),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),

          SizedBox(height: 16.0),
          // Footer Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2030 Al Wajhat Global Western Company Ltd., All rights reserved.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
