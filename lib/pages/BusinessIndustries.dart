import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';

class Businessindustries extends StatelessWidget {
  final List<Industry> industries = [
    Industry(
      title: 'Construction',
      description:
          'Our construction division delivers turnkey solutions for commercial, residential, and industrial projects. We specialize in project management, civil works, and infrastructure development.',
      imagePath: 'assets/images/construction/construction4.jpg',
      moreDetails:
          'We have completed numerous landmark projects across Saudi Arabia, utilizing advanced technologies and a highly skilled workforce. Our services include design-build, renovation, and sustainable construction practices.',
    ),
    Industry(
      title: 'Manpower',
      description:
          'We provide skilled and unskilled manpower solutions tailored to client needs in oil & gas, hospitality, healthcare, and more.',
      imagePath: 'assets/images/manpower.jpg',
      moreDetails:
          'Our manpower division recruits, trains, and deploys professionals and laborers for short-term and long-term assignments. We ensure compliance with all local regulations and provide ongoing support.',
    ),
    Industry(
      title: 'Event Management',
      description:
          'From corporate events to exhibitions, our team handles planning, logistics, and execution, creating memorable experiences.',
      imagePath: 'assets/images/event.jpg',
      moreDetails:
          'We offer end-to-end event solutions including venue selection, branding, technical support, and guest management. Our creative team ensures every event is unique and impactful.',
    ),
    Industry(
      title: 'Facility Management',
      description:
          'Maintenance, cleaning, security, and landscaping services ensuring safe, efficient, and sustainable environments.',
      imagePath: 'assets/images/construction/Project2.jpg',
      moreDetails:
          'Our facility management services are tailored for commercial, residential, and industrial properties. We use smart technologies for preventive maintenance and energy management.',
    ),
    Industry(
      title: 'Industrial Services',
      description:
          'Equipment supply, maintenance, and technical support for manufacturing, energy, and petrochemical sectors.',
      imagePath: 'assets/images/industrial.jpg',
      moreDetails:
          'We provide industrial cleaning, shutdown maintenance, and supply of specialized machinery. Our technical teams are available 24/7 for emergency support.',
    ),
    Industry(
      title: 'Logistics & Transportation',
      description:
          'End-to-end freight, warehousing, and distribution solutions for timely and secure delivery across Saudi Arabia.',
      imagePath: 'assets/images/logistics.jpg',
      moreDetails:
          'Our logistics network covers all major cities and industrial zones. We offer temperature-controlled storage, customs clearance, and last-mile delivery.',
    ),
    Industry(
      title: 'Technology Solutions',
      description:
          'Innovative technology solutions, including software development, IT consulting, and digital transformation.',
      imagePath: 'assets/images/technology.jpg',
      moreDetails:
          'We deliver ERP systems, cloud migration, cybersecurity, and custom app development. Our consultants help businesses embrace Industry 4.0.',
    ),
    Industry(
      title: 'Healthcare',
      description:
          'Medical staffing, equipment supply, and facility management for hospitals and clinics.',
      imagePath: 'assets/images/healthcare.jpg',
      moreDetails:
          'We supply certified medical professionals, manage healthcare facilities, and provide advanced medical equipment and consumables.',
    ),
    Industry(
      title: 'Flotter',
      description:
          'Advanced floating solutions—modular floating platforms for events, leisure, and industrial applications.',
      imagePath: 'assets/images/flotter.jpg',
      moreDetails:
          'Our flotter systems are customizable for marinas, floating stages, and offshore operations. We ensure safety, durability, and quick installation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;
    final int crossAxisCount = isWide ? 3 : 1;

    return Scaffold(
      appBar:SubMainPageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header/intro section
            Container(
              width: double.infinity,
              color: Colors.blueGrey.shade50,
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AL Wajhat Global Western Company Ltd.',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF022025)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A leading diversified business group in Saudi Arabia, delivering high-quality services and solutions across multiple industries.',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 12),
                  Divider(thickness: 1, color: Colors.blueGrey.shade100),
                  SizedBox(height: 12),
                  Text(
                    'With a commitment to excellence, innovation, and customer satisfaction, we deliver high-quality projects and services for clients in various industries. We contribute to the Kingdom’s growth through our expertise, professionalism, and best practices.',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Section title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Icon(Icons.business, color: Color(0xFF022025), size: 32),
                  SizedBox(width: 10),
                  Text(
                    'Our Industries',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF022025),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Text(
                'Explore the range of industries we serve and excel in.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 20),
            // Grid of animated industry cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: industries.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: isWide ? 1.25 : 1,
                    ),
                    itemBuilder: (context, index) {
                      final industry = industries[index];
                      return AnimatedIndustryCard(
                        title: industry.title,
                        description: industry.description,
                        imagePath: industry.imagePath,
                        moreDetails: industry.moreDetails,
                        delay: Duration(milliseconds: 200 * index),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            FooterSection(),
          ],
        ),
      ),
    );
  }

  static TextButton _navBtn(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => context.go(route),
      child: Text(label, style: TextStyle(color: Colors.white)),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      ),
    );
  }

  static PopupMenuItem<String> _buildPopupMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 36,
      child: HoverableMenuItem(title: title),
    );
  }
}

class Industry {
  final String title;
  final String description;
  final String imagePath;
  final String moreDetails;

  Industry({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.moreDetails,
  });
}

class AnimatedIndustryCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String moreDetails;
  final Duration delay;

  const AnimatedIndustryCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.moreDetails,
    required this.delay,
  }) : super(key: key);

  @override
  _AnimatedIndustryCardState createState() => _AnimatedIndustryCardState();
}

class _AnimatedIndustryCardState extends State<AnimatedIndustryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.16), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: _HoverableCard(
          title: widget.title,
          description: widget.description,
          imagePath: widget.imagePath,
          moreDetails: widget.moreDetails,
        ),
      ),
    );
  }
}

class _HoverableCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String moreDetails;
  const _HoverableCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.moreDetails,
  }) : super(key: key);

  @override
  State<_HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<_HoverableCard> {
  bool _hovered = false;
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _hovered ? Colors.blueGrey.withOpacity(0.16) : Colors.grey.withOpacity(0.07),
              blurRadius: _hovered ? 12 : 6,
              offset: Offset(0, _hovered ? 6 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedText(title: widget.title),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                    textAlign: TextAlign.left,
                  ),
                  if (_showMore) ...[
                    SizedBox(height: 8),
                    Text(
                      widget.moreDetails,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[800],
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                  SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showMore = !_showMore;
                        });
                      },
                      child: Text(_showMore ? 'Less Details' : 'More Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showMore ? Colors.blue : Color(0xFF022025),
                        foregroundColor: Colors.white,
                        minimumSize: Size(120, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
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

// Animated text widget for industry title
class AnimatedText extends StatefulWidget {
  final String title;
  const AnimatedText({required this.title, Key? key}) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(0xFF022025),
              fontSize: 19,
            ),
        textAlign: TextAlign.left,
      ),
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