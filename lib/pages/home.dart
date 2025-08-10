import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'package:wgwwebapp/pages/ConstructionPage.dart';
import 'package:wgwwebapp/pages/EventManagementPage.dart';
import 'package:wgwwebapp/pages/ManpowerPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Wajhat Global Western',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
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

  PopupMenuItem<String> buildPopupMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 36,
      child: HoverableMenuItem(title: title),
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
      'subtitle':
          'Reliable, Efficient, and High-Quality Construction Solutions',
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
    _timer = Timer.periodic(Duration(seconds: 20), (Timer timer) {
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
    if (_pageController.page?.toInt() != _currentPage) {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
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
      height: 500,
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
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          _slides[index]['title']!,
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _slides[index]['subtitle']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black38,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _slides.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPage = entry.key;
                    });
                    _pageController.animateToPage(
                      entry.key,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == entry.key
                          ? Colors.white
                          : Colors.grey,
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

// Services Section
class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});
  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
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
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double nextScroll = currentScroll + 300 + 12;
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
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 65, 66, 66),
            const Color.fromARGB(255, 1, 18, 37),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'SERVICES',
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'At WGW, we pride ourselves on delivering tailored construction solutions that adapt to your unique project needs. With a commitment to quality and innovation, we ensure every structure is built to exceed expectations.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.go('/services');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'VIEW MORE »',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: _serviceData.map((service) {
                return _buildServiceCard(
                  imagePath: service['imagePath']!,
                  title: service['title']!,
                  description: service['description']!,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 8, color: Colors.red),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.white),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.white),
              ],
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
      width: 300,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

final List<Map<String, String>> _serviceData = [
  {
    'imagePath': 'assets/images/Cont1.jpg',
    'title': 'General Contracting',
    'description':
        'We provide end-to-end construction management, ensuring high-quality execution, timely delivery, and adherence to safety standards. From planning to completion, we handle every aspect of your project with precision and expertise.',
  },
  {
    'imagePath': 'assets/images/build.jpg',
    'title': 'Design & Build',
    'description':
        'Our integrated Design & Build approach streamlines the construction process, combining innovative design with expert execution to deliver cost-effective, high-quality projects on time.',
  },
  {
    'imagePath': 'assets/images/civil.jpg',
    'title': 'Civil & Structural Engineering',
    'description':
        'We specialize in designing and constructing durable, high-performance structures, ensuring safety, stability, and efficiency in every project, from foundations to complex infrastructures.',
  },
  {
    'imagePath': 'assets/images/res.jpg',
    'title': 'Commercial & Residential Construction',
    'description':
        'We provide comprehensive construction services for both commercial and residential projects, delivering custom-built solutions that meet client specifications while ensuring quality, safety, and timely completion.',
  },
  {
    'imagePath': 'assets/images/road.png',
    'title': 'Infrastructure & Heavy Construction',
    'description':
        'We specialize in large-scale infrastructure projects, including roads, bridges, and utilities, delivering durable, efficient, and sustainable solutions that meet the demands of modern urban development.',
  },
  {
    'imagePath': 'assets/images/mep.jpg',
    'title': 'Mechanical, Electrical & Plumbing (MEP) Services',
    'description':
        'We offer integrated MEP solutions, ensuring the efficient design, installation, and maintenance of heating, ventilation, air conditioning (HVAC), electrical, and plumbing systems to optimize building performance and comfort.',
  },
  {
    'imagePath': 'assets/images/renovate.jpg',
    'title': 'Renovation & Remodeling',
    'description':
        'We transform existing spaces with expert renovation and remodeling services, enhancing functionality and aesthetics while preserving structural integrity to meet modern needs and design preferences.',
  },
  {
    'imagePath': 'assets/images/interior.jpg',
    'title': 'Fit-Out & Interior Solutions',
    'description':
        'We provide customized fit-out and interior design services, creating functional and stylish spaces that reflect your vision, with high-quality finishes and attention to detail for both commercial and residential projects.',
  },
];

class BusinessSection extends StatefulWidget {
  const BusinessSection({super.key});

  @override
  State<BusinessSection> createState() => _BusinessSectionState();
}

class _BusinessSectionState extends State<BusinessSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 214, 218, 234), // light pink
            Color.fromARGB(255, 88, 87, 89), // light blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Other Divisions',
            style: TextStyle(
              color: const Color.fromARGB(255, 69, 2, 2),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          // Horizontal scroll cards
          SizedBox(
            height: 330,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _businessData
                    .map((service) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: _buildBusinessCard(
                            imagePath: service['imagePath']!,
                            title: service['title']!,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),

          SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 8, color: Colors.red),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.white),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.white),
              ],
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
          context.go('/eventmanagement');
        } else if (title == 'Logistics') {
          context.go('/logistics/home');
        }
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 224, 221, 223),
              Color(0xFFa6c1ee)
            ], // purple to blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top image section
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(
                      255, 41, 3, 87), // white text looks better on gradient
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
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
    'imagePath': 'assets/images/manpower.jpg',
    'title': 'Manpower',
  },
  {
    'imagePath': 'assets/images/event.jpg',
    'title': 'Event Management',
  },
  {
    'imagePath': 'assets/images/images/logistics.jpg',
    'title': 'Logistics',
  },
];

class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
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
                      'Al Wajhat Global Western Groups',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Wajhat Global Western Groups – Your Trusted Partner in Construction and Engineering.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'At Wajhat Global Western Groups, we take pride in being a leader in the construction industry for over a decade. Our commitment to excellence has earned us a reputation built on quality, innovation, and reliability. With a wealth of experience and a skilled team, we deliver top-tier construction solutions that meet the highest standards. Join us and experience construction services that go beyond expectations, building success at every stage.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Founded in 2021, Wajhat Global Western Contracting was established with a singular vision: to be the trusted partner in our clients journey to success. With a commitment to innovation and excellence, we have consistently worked alongside our clients, transforming visions into reality and building a future of strength and sustainability every step of the way.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.go('/AboutUsPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD32F2F),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  'assets/images/build5.jpg',
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

// Footer Section with Links, Social Media, and Map Locations
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 231, 229, 230),
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Links Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(
                label: 'About Us',
                onTap: () => context.go('/aboutconstruction'),
              ),
              _footerDivider(),
              _FooterLink(
                label: 'Our Services',
                onTap: () => context.go('/services'),
              ),
              _footerDivider(),
              _FooterLink(
                label: 'Career',
                onTap: () => context.go('/career'),
              ),
              _footerDivider(),
              _FooterLink(
                label: 'Contact Us',
                onTap: () => context.go('/contactus'),
              ),
              _footerDivider(),
              _FooterLink(
                label: 'Our Offices',
                onTap: () => context.go('/officeaddress'),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          // Social Media Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterIconButton(
                icon: FontAwesomeIcons.facebookF,
                color: Colors.white,
                onTap: () => _launchUrl('https://facebook.com/yourcompany'),
              ),
              SizedBox(width: 16),
              _FooterIconButton(
                icon: FontAwesomeIcons.instagram,
                color: Colors.white,
                onTap: () => _launchUrl('https://instagram.com/yourcompany'),
              ),
              SizedBox(width: 16),
              _FooterIconButton(
                icon: FontAwesomeIcons.linkedinIn,
                color: Colors.white,
                onTap: () =>
                    _launchUrl('https://linkedin.com/company/yourcompany'),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          // Map Locations
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     _FooterMapLocation(
          //       title: 'Head Office',
          //       address: 'Al Azhar Building Tower, Al Safa Dist, Jeddah 23535, Saudi Arabia',
          //       url: 'https://goo.gl/maps/yourmap1',
          //       onTap: _launchUrl,
          //     ),
          //     SizedBox(width: 32),
          //     _FooterMapLocation(
          //       title: 'Branch Office',
          //       address: 'King Fahd Rd, Riyadh 12212, Saudi Arabia',
          //       url: 'https://goo.gl/maps/yourmap2',
          //       onTap: _launchUrl,
          //     ),
          //     SizedBox(width: 32),
          //     _FooterMapLocation(
          //       title: 'International Office',
          //       address: 'Dubai Media City, Dubai, UAE',
          //       url: 'https://goo.gl/maps/yourmap3',
          //       onTap: _launchUrl,
          //     ),
          //   ],
          // ),
          SizedBox(height: 24.0),
          // Contact Info and Address
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get In Touch:',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Phone: +966567273714',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email: info@wgwcltd.com',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              // Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address:',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Al Azhar Building Tower',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Al Safa Dist',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Jeddah 23535, Saudi Arabia',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Copyright
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2025 Al Wajhat Global Western Groups Ltd. All rights reserved.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerDivider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('|', style: TextStyle(color: Colors.white70)),
      );
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _FooterIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _FooterIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFD32F2F),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

class _FooterMapLocation extends StatelessWidget {
  final String title;
  final String address;
  final String url;
  final void Function(String) onTap;
  const _FooterMapLocation({
    required this.title,
    required this.address,
    required this.url,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.orangeAccent, size: 18),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          SizedBox(
            width: 180,
            child: Text(
              address,
              style: TextStyle(color: Colors.white70, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

DropdownMenuItem<String> buildDropdownMenuItem(String text, String? value,
    {bool isHeader = false, bool isBold = false, Color? color}) {
  return DropdownMenuItem<String>(
    value: value,
    enabled: !isHeader,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 2.0),
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
