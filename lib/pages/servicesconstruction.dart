import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(ServicePageApp());
}

class ServicePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WGW ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ServicePageScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/service': (context) => ServicePageScreen(),
      },
    );
  }
}

class ServicePageScreen extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'title': 'General Contracting',
      'description': 'Complete solutions for commercial and residential projects.',
      'image': 'assets/images/servicescons/general.jpg', // Add image path here
    },
    {
      'title': 'Design & Build',
      'description': 'From concept to completion, we handle it all.',
      'image': 'assets/images/servicescons/design.jpg', // Add image path here
    },
    {
      'title': 'Civil Engineering',
      'description': 'Expertise in infrastructure and large-scale developments.',
      'image': 'assets/images/servicescons/civil.jpg', // Add image path here
    },
    {
      'title': 'Residential Construction',
      'description': 'Building dream homes with precision and care.',
      'image': 'assets/images/servicescons/res.jpg', // Add image path here
    },
    {
      'title': 'Infrastructure Development',
      'description': 'Creating essential infrastructure for tomorrow.',
      'image': 'assets/images/servicescons/civil.jpg', // Add image path here
    },
    {
      'title': 'MEP Services',
      'description': 'Ensuring buildings operate efficiently.',
      'image': 'assets/images/servicescons/mep.jpg', // Add image path here
    },
    {
      'title': 'Renovation Works',
      'description': 'Breathing new life into old spaces.',
      'image': 'assets/images/servicescons/renovation.jpg', // Add image path here
    },
    {
      'title': 'Interior Solutions',
      'description': 'Beautiful interiors tailored to your lifestyle.',
      'image': 'assets/images/servicescons/interior.jpg', // Add image path here
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/construction/construction4.jpg'), // Banner image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                // Centered Text
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'Our Services',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Our Services',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Services Grid with Animation
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 2,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return ServiceCard(
                  title: service['title']!,
                  description: service['description']!,
                  imagePath: service['image']!,
                );
              },
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    widget.imagePath,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
              child: GestureDetector(
                onTap: () {
                  context.go('/'); // Navigate to home page on image tap
                },
                child: Image.asset(
                  'assets/images/MWT.png', // Image for the logo
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

}
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




