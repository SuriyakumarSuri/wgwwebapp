import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Added for animations
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
      preferredSize: Size.fromHeight(85),
      child: AppBar(
        backgroundColor: Color(0xFF49020C),
        flexibleSpace: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  context.go('/');
                },
                child: Image.asset(
                  'assets/images/wgw.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      color: currentRoute == '/AboutUsPage'
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/services');
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
                    context.go('/officeaddress');
                  },
                  child: Text('Our Offices',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/contactus');
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
  Size get preferredSize => Size.fromHeight(85);

  PopupMenuItem<String> buildPopupMenuItem(String title, String route) {
    return PopupMenuItem<String>(
      value: route,
      height: 36,
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
            title: 'About WGW',
            content:
                'Founded in 2020, BuildRight Construction Services has quickly established itself as a reliable and innovative name in the construction industry. With a strong foundation built on quality, safety, and customer satisfaction, we have successfully completed a wide range of projects across residential, commercial, and industrial sectors. Starting with a small but passionate team, we have grown into a full-scale construction company, delivering exceptional services with a commitment to excellence and on-time delivery.',
          ).animate().slideX(
                begin: -0.5,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
              ),

          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/build2.jpg',
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
                  backgroundColor: Colors.black.withOpacity(0.5),
                ),
              ).animate().fadeIn(
                    duration: 800.ms,
                    delay: 200.ms,
                  ),
            ],
          ),

          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Vision',
            content:
                'To provide top-quality construction services using modern techniques and materials, ensuring long-lasting value and satisfaction for our clients. We believe in building not just structures, but lasting relationships through trust and professionalism.',
          ).animate().slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
              ),

          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Our Mission',
            content:
                'To become a leading construction company known for innovation, integrity, and excellence — transforming ideas into reality and contributing to the infrastructure growth of our communities.',
          ).animate().slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
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
          ).animate().slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
              ),

          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Why Choose Us',
            content: '1. Experienced and skilled workforce.\n\n'
                '2. Timely project completion.\n\n'
                '3. High-quality materials and workmanship.\n\n'
                '4. Transparent communication.\n\n'
                '5. Competitive pricing.\n\n',
          ).animate().slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
              ),

          const SizedBox(height: 16.0),
          CustomCard(
            backgroundColor: Colors.white,
            title: 'Let’s Build the Future Together',
            content:
                'At BuildRight Construction, every project is a promise — a promise of safety, strength, and satisfaction. Whether it’s your dream home or a large-scale development, we are here to build it right.',
          ).animate().slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ).fadeIn(
                duration: 600.ms,
              ),

          FooterSection(),
        ],
      ),
    );
  }
}

// -------------------------- Section Widget --------------------------
class Section extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final String content;

  const Section({Key? key, this.backgroundColor, required this.title, required this.content}) : super(key: key);

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

// -------------------------- Hoverable Menu Item --------------------------
class HoverableMenuItem extends StatefulWidget {
  final String title;

  const HoverableMenuItem({Key? key, required this.title}) : super(key: key);

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
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            color: _isHovered ? Colors.black : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

// -------------------------- FooterSection --------------------------
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF3A0303),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
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

// -------------------------- CustomCard --------------------------
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
