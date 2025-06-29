import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // GoRouter configuration
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/aboutconstruction',
        builder: (context, state) => UnderConstructionPage(title: 'About Construction'),
      ),
      GoRoute(
        path: '/construction',
        builder: (context, state) => UnderConstructionPage(title: 'Construction Services'),
      ),
      GoRoute(
        path: '/manpower',
        builder: (context, state) => UnderConstructionPage(title: 'Manpower Services'),
      ),
      GoRoute(
        path: '/event',
        builder: (context, state) => UnderConstructionPage(title: 'Event Management'),
      ),
      GoRoute(
        path: '/ourbusiness',
        builder: (context, state) => UnderConstructionPage(title: 'All Business Divisions'),
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => UnderConstructionPage(title: 'Our Services'),
      ),
      GoRoute(
        path: '/officeaddress',
        builder: (context, state) => UnderConstructionPage(title: 'Our Offices'),
      ),
      GoRoute(
        path: '/contactus',
        builder: (context, state) => UnderConstructionPage(title: 'Contact Us / Careers'),
      ),
      GoRoute(
        path: '/AboutUsPage',
        builder: (context, state) => UnderConstructionPage(title: 'About Us'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Al-Wajhat Global Western',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        fontFamily: 'Roboto',
      ),
      routerConfig: _router,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PopupMenuItem<String> buildPopupMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 36,
      child: HoverableMenuItem(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color(0xFF3A0303),
          elevation: 4,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0), // Increased horizontal padding
            child: Row(
              children: [
                SlideTransition(
                  position: _animation,
                  child: GestureDetector(
                    onTap: () {
                      context.go('/home'); // Use context.go for GoRouter navigation
                    },
                    child: Image.asset(
                      'assets/images/wgw.jpg',
                      height: 65,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 24), // Increased spacing
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _NavButton(label: 'Home', onTap: () => context.go('/')),
                      _NavButton(
                        label: 'About Us',
                        onTap: () => context.go('/AboutUsPage'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0), // Adjusted padding
                        child: PopupMenuButton<String>(
                          offset: Offset(0, 50),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners for popup menu
                          child: Row(
                            children: [
                              Text(
                                'Business Groups',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500, // Slightly bolder
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, color: Colors.white, size: 20), // Larger icon
                            ],
                          ),
                          onSelected: (String value) {
                            context.go(value);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              buildPopupMenuItem('Construction', '/construction'),
                              buildPopupMenuItem('Manpower', '/manpower'),
                              buildPopupMenuItem('Event Management', '/event'),
                              buildPopupMenuItem('Browse all', '/ourbusiness'),
                            ];
                          },
                        ),
                      ),
                      _NavButton(
                        label: 'Our Services',
                        onTap: () => context.go('/services'),
                      ),
                      _NavButton(
                        label: 'Our Offices',
                        onTap: () => context.go('/officeaddress'),
                      ),
                      _NavButton(
                        label: 'Careers',
                        onTap: () => context.go('/contactus'),
                      ),
                      _NavButton(
                        label: 'Contact Us',
                        onTap: () => context.go('/contactus'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(),
            AboutUsSection(),
            ServicesSection(),
            BusinessSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  __NavButtonState createState() => __NavButtonState();
}

class __NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: _isHovered ? Colors.orange.shade200 : Colors.white, // Hover effect
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        child: Text(widget.label),
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
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), // Adjusted padding
        decoration: BoxDecoration(
          color: _isHovered ? Colors.orange.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0), // Slightly more rounded
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 15, // Slightly larger font
            color: _isHovered ? Colors.deepOrange : Colors.grey[800], // Darker color on hover
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal, // Bold on hover
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatefulWidget {
  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/build1.jpg',
      'title': 'GLOBAL CONSTRUCTION EXPERTS',
      'subtitle': 'Building Excellence with Precision & Innovation Worldwide',
    },
    {
      'image': 'assets/images/build2.jpg',
      'title': 'LEADERS IN CONSTRUCTION & ENGINEERING',
      'subtitle': 'Creating Sustainable & Innovative Structures Globally',
    },
    {
      'image': 'assets/images/build3.jpg',
      'title': 'BUILDING THE FUTURE, BRICK BY BRICK',
      'subtitle': 'Reliable, Efficient, and High-Quality Construction Solutions',
    },
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
    _pageController.addListener(_onPageChanged);
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: 8), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged() {
    if (_pageController.page?.round() != _currentPage) { // Use round() for more reliable integer conversion
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 480, // Increased height for more impact
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _slides[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.45), // Slightly darker overlay
                  ),
                  Positioned.fill( // Use Positioned.fill to center content
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0), // Increased padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                          children: [
                            Text(
                              _slides[index]['title']!,
                              style: TextStyle(
                                color: Color(0xFFFFD700), // Gold-like color
                                fontSize: 42, // Larger font size
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5, // Increased letter spacing
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.black54, // More pronounced shadow
                                    offset: Offset(3.0, 3.0),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16), // Increased spacing
                            Text(
                              _slides[index]['subtitle']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22, // Larger font size
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black45,
                                    offset: Offset(1.5, 1.5),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30), // Spacing before potential call to action
                            ElevatedButton(
                              onPressed: () {
                                context.go('/contactus');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade700, // Darker orange
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5, // Add elevation
                              ),
                              child: Text(
                                'GET A QUOTE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 24, // Adjusted position
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _slides.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      entry.key,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 12, // Slightly larger dots
                    height: 12,
                    margin: EdgeInsets.symmetric(horizontal: 6), // Increased margin
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == entry.key
                          ? Colors.orange.shade700 // Match button color
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});
  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double itemWidth = 300 + 12; // Card width + margin
        double nextScroll = currentScroll + itemWidth;

        if (nextScroll >= maxScroll) {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0), // Increased padding
      color: Color(0xFF1A1A1A), // Darker background for contrast
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38, // Larger font
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'SERVICES',
            style: TextStyle(
              color: Colors.orange.shade600, // More vibrant orange
              fontSize: 42, // Larger font
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0, // Increased letter spacing
            ),
          ),
          SizedBox(height: 20),
          Text(
            'At WGW, we pride ourselves on delivering tailored construction solutions that adapt to your unique project needs. With a commitment to quality and innovation, we ensure every structure is built to exceed expectations.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 17, // Slightly larger font
              height: 1.5, // Line height for readability
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.go('/services');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // More rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Larger padding
              elevation: 5,
            ),
            child: Text(
              'VIEW ALL SERVICES »',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 40), // Increased spacing
          SizedBox(
            height: 360, // Increased height for cards
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _serviceData.length,
              separatorBuilder: (context, index) => SizedBox(width: 20), // Spacing between cards
              itemBuilder: (context, index) {
                final service = _serviceData[index];
                return _buildServiceCard(
                  imagePath: service['imagePath']!,
                  title: service['title']!,
                  description: service['description']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      width: 320, // Slightly wider cards
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Darker shadow
            blurRadius: 10, // Increased blur
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 180, // Taller image area
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Larger title font
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700, // Darker orange
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14, // Consistent font size
                    color: Colors.grey[700], // Darker grey
                  ),
                  maxLines: 4, // Allow more lines for description
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Spacer(), // Push content to top if necessary
        ],
      ),
    );
  }
}

final List<Map<String, String>> _serviceData = [
  {
    'imagePath': 'assets/images/Cont1.jpg',
    'title': 'General Contracting',
    'description': 'We provide end-to-end construction management, ensuring high-quality execution, timely delivery, and adherence to safety standards. From planning to completion, we handle every aspect of your project with precision and expertise.',
  },
  {
    'imagePath': 'assets/images/build.jpg',
    'title': 'Design & Build',
    'description': 'Our integrated Design & Build approach streamlines the construction process, combining innovative design with expert execution to deliver cost-effective, high-quality projects on time.',
  },
  {
    'imagePath': 'assets/images/civil.jpg',
    'title': 'Civil & Structural Engineering',
    'description': 'We specialize in designing and constructing durable, high-performance structures, ensuring safety, stability, and efficiency in every project, from foundations to complex infrastructures.',
  },
  {
    'imagePath': 'assets/images/res.jpg',
    'title': 'Commercial & Residential Construction',
    'description': 'We provide comprehensive construction services for both commercial and residential projects, delivering custom-built solutions that meet client specifications while ensuring quality, safety, and timely completion.',
  },
  {
    'imagePath': 'assets/images/road.png',
    'title': 'Infrastructure & Heavy Construction',
    'description': 'We specialize in large-scale infrastructure projects, including roads, bridges, and utilities, delivering durable, efficient, and sustainable solutions that meet the demands of modern urban development.',
  },
  {
    'imagePath': 'assets/images/mep.jpg',
    'title': 'Mechanical, Electrical & Plumbing (MEP) Services',
    'description': 'We offer integrated MEP solutions, ensuring the efficient design, installation, and maintenance of heating, ventilation, air conditioning (HVAC), electrical, and plumbing systems to optimize building performance and comfort.',
  },
  {
    'imagePath': 'assets/images/renovate.jpg',
    'title': 'Renovation & Remodeling',
    'description': 'We transform existing spaces with expert renovation and remodeling services, enhancing functionality and aesthetics while preserving structural integrity to meet modern needs and design preferences.',
  },
  {
    'imagePath': 'assets/images/interior.jpg',
    'title': 'Fit-Out & Interior Solutions',
    'description': 'We provide customized fit-out and interior design services, creating functional and stylish spaces that reflect your vision, with high-quality finishes and attention to detail for both commercial and residential projects.',
  },
];

class BusinessSection extends StatefulWidget {
  const BusinessSection({super.key});
  @override
  State<BusinessSection> createState() => _BusinessSectionState();
}

class _BusinessSectionState extends State<BusinessSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double itemWidth = 350 + 16; // Card width + separator width
        double nextScroll = currentScroll + itemWidth;

        if (nextScroll >= maxScroll) {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
      color: Color(0xFFF7F7F7), // Light background for this section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our',
            style: TextStyle(
              color: Colors.black,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Other Divisions',
            style: TextStyle(
              color: Colors.orange.shade600,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 400, // Increased height for business cards
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _businessData.length,
              separatorBuilder: (context, index) => SizedBox(width: 24), // Increased spacing
              itemBuilder: (context, index) {
                final service = _businessData[index];
                return _buildBusinessCard(
                  imagePath: service['imagePath']!,
                  title: service['title']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard({
    required String imagePath,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        if (title == 'Construction') {
          context.go('/aboutconstruction');
        } else if (title == 'Manpower') {
          context.go('/manpower');
        } else if (title == 'Event Management') {
          context.go('/event'); // Corrected to match GoRouter path
        }
      },
      child: Container(
        width: 380, // Wider cards for business section
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18), // More rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12, // Increased blur
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                imagePath,
                height: 280, // Taller image for impact
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0), // Increased padding
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24, // Larger title font
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> _businessData = [
  {
    'imagePath': 'assets/images/Cont1.jpg',
    'title': 'Construction',
  },
  {
    'imagePath': 'assets/images/Manpower.jpg',
    'title': 'Manpower',
  },
  {
    'imagePath': 'assets/images/event.jpg',
    'title': 'Event Management',
  },
];

class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 48), // Increased padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Vertically align content
        children: [
          Expanded(
            flex: 3, // Give more space to text
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 32, // Larger font
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Al Wajhat Global Western Groups',
                  style: TextStyle(
                    fontSize: 40, // Larger and more impactful
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700, // Consistent orange
                    height: 1.2, // Tighter line height
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome to Wajhat Global Western Groups – Your Trusted Partner in Construction and Engineering.',
                  style: TextStyle(fontSize: 18, color: Colors.black87, height: 1.4),
                ),
                SizedBox(height: 12),
                Text(
                  'At Wajhat Global Western Groups, we take pride in being a leader in the construction industry for over a decade. Our commitment to excellence has earned us a reputation built on quality, innovation, and reliability. With a wealth of experience and a skilled team, we deliver top-tier construction solutions that meet the highest standards. Join us and experience construction services that go beyond expectations, building success at every stage.',
                  style: TextStyle(fontSize: 17, color: Colors.black87, height: 1.4),
                ),
                SizedBox(height: 12),
                Text(
                  'Founded in 2021, Wajhat Global Western Contracting was established with a singular vision: to be the trusted partner in our clients journey to success. With a commitment to innovation and excellence, we have consistently worked alongside our clients, transforming visions into reality and building a future of strength and sustainability every step of the way.',
                  style: TextStyle(fontSize: 17, color: Colors.black87, height: 1.4),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    context.go('/AboutUsPage');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'READ MORE',
                    style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 48), // Increased spacing
          Expanded(
            flex: 2, // Less space for image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // More rounded corners
              child: Image.asset(
                'assets/images/build5.jpg',
                fit: BoxFit.cover,
                height: 400, // Taller image
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2C0105), // Darker, richer red for footer
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 48.0), // Increased padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space more evenly
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Info Column (Left)
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get In Touch:',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Phone: +966567273714',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Email: info@wgwcltd.com',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Spacer for separation
              SizedBox(width: 40),
              // Address Column (Right)
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address:',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Al Azhar Building Tower',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Al Safa Dist',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Jeddah 23535, Saudi Arabia',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Adding a placeholder for quick links or social media
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links:',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 12.0),
                    InkWell(
                      onTap: () => context.go('/AboutUsPage'),
                      child: Text('About Us', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () => context.go('/services'),
                      child: Text('Our Services', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () => context.go('/contactus'),
                      child: Text('Contact Us', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Divider(color: Colors.white30, thickness: 1), // Thicker divider
          SizedBox(height: 16.0),
          Text(
            '© 2025 Al Wajhat Global Western Groups Ltd. All rights reserved.',
            style: TextStyle(color: Colors.white60, fontSize: 14), // Slightly larger and lighter copyright
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// A placeholder page for routes that are "under construction"
class UnderConstructionPage extends StatelessWidget {
  final String title;

  const UnderConstructionPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF3A0303),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              '$title Page Under Construction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'We are working hard to bring you this content soon!',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/');
              },
              icon: Icon(Icons.home, color: Colors.white),
              label: Text('Go to Home', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}