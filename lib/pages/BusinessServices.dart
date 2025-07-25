import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/animation.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';

class BuisnessServicePage extends StatefulWidget {
   @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<BuisnessServicePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Animation duration
      vsync: this,
    );

    // Define the animation movement
    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Starts off-screen to the left
      end: Offset.zero, // Ends at its normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth transition
    ));
    // Start the animation
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 final List<Map<String, String>> services = [
  {
    'title': 'MEP Services',
    'description':
        'We provide comprehensive Mechanical, Electrical, and Plumbing (MEP) solutions, ensuring seamless integration of critical systems for safe and efficient building operations.',
    'image': 'assets/images/MEP_Services.jpg',
  },
  {
    'title': 'Structural Engineering',
    'description':
        'Our team designs and oversees the construction of safe, durable structures, from steel frameworks to reinforced concrete.',
    'image': 'assets/images/interior.jpg',
  },
  {
    'title': 'Project Management',
    'description':
        'We coordinate every phase of your construction project, ensuring timelines, budgets, and quality standards are met.',
    'image': 'assets/images/manpower.jpg',
  },
  {
    'title': 'Safety Compliance',
    'description':
        'We implement rigorous safety protocols and regular inspections to maintain a secure work environment on every site.',
    'image': 'assets/images/manpower1.jpg',
  },
  {
    'title': 'Material Procurement',
    'description':
        'We source and supply high-quality construction materials, ensuring timely delivery and cost efficiency.',
    'image': 'assets/images/manpower2.jpg',
  },
  {
    'title': 'Equipment Rental',
    'description':
        'Our fleet of modern construction equipment is available for rent, supporting projects of all sizes and scopes.',
    'image': 'assets/images/manpower3.jpg',
  },
  {
    'title': 'Quality Control',
    'description':
        'We conduct thorough inspections and testing to guarantee that all construction work meets industry standards.',
    'image': 'assets/images/mep.jpg',
  },
  {
    'title': 'Site Preparation',
    'description':
        'We handle all aspects of site clearing, grading, and excavation to ensure a solid foundation for your construction project.',
    'image': 'assets/images/civil.jpg',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubMainPageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/b_mep.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
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
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 🔥 Updated to 3 columns
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
            SizedBox(height: 10),
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


class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF022025),
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

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideTransition(
      position: _animation,
      child: Container(
        width: screenWidth * 0.9,
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description.trim(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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