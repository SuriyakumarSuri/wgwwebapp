// Import necessary packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Wajhat Global Logistics',
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
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85), // Increased height for AppBar
        child: AppBar(
            backgroundColor: Color(0xFF003366), // Deep blue background color
            flexibleSpace: Row(
              children: [
                SlideTransition(
                  position: _animation,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to home page on image tap
                        Navigator.pushNamed(context, '/logistics/home');
                      },
                      child: Image.asset(
                        'assets/images/images/MWT.png',
                        height: 80, // Adjust logo height
                        width: 70, // Increased width for enhanced appearance
                        fit: BoxFit.fill, // Ensure the image doesn't crop
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                context.go('/logistics/contactus'); // Navigates to Contact Us page
              },
              child: Text('Contact Us', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
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
// --------------------------
// Hero Section with Auto-Swiping Slider
// --------------------------
class HeroSection extends StatefulWidget {
  @override
  _HeroSectionState createState() => _HeroSectionState();
}
class _HeroSectionState extends State<HeroSection> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/images/pexels2.jpeg',
      'title': 'GLOBAL SHIPPING EXPERTS',
      'subtitle': 'Delivering Excellence with Responsibility Across the World',
    },
    {
      'image': 'assets/images/images/pexels1.webp',
      'title': 'Reliable Logistics Solutions',
      'subtitle': 'Ensuring Seamless Deliveries Worldwide',
    },
    {
      'image': 'assets/images/images/port.jpg',
      'title': 'Your Trusted Shipping Partner',
      'subtitle': 'Commitment Beyond Borders, Excellence in Every Shipment',
    },
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
    _pageController.addListener(_onPageChanged); // Listen for page change
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

  // This function will update the current page index when the page is swiped
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
    _pageController.removeListener(_onPageChanged); // Remove listener when disposed
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
                    color: Colors.black.withOpacity(0.3), // Overlay for readability
                  ),
                  // Title and Subtitle at the Top
                  Positioned(
                    top: 40,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          _slides[index]['title']!,
                          style: TextStyle(
                            color: Color(0xFFFFD700), // Gold Color
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
          // Dots Indicator
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
                      _currentPage = entry.key; // Update current page on tap
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
// --------------------------
// Services Section
// -------------------------
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
  /// Start Auto Scroll Timer
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        // Scroll to the next card
        double nextScroll = currentScroll + 300 + 12; // Card width + spacing
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
      color: Colors.black, // Background for the entire section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and Description
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
            'At MWT, we pride ourselves on delivering tailored logistics solutions that adapt to your unique business needs. With a commitment to flexibility and precision, we ensure every service is crafted to exceed expectations.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.go('/service');
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

          // Horizontal Scrollable Service Cards
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
          // Indicator Dots
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
  /// Service Card Widget
  Widget _buildServiceCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      width: 300, // Fixed width for each card
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextButton(
          //     onPressed: () {
          //
          //     },
          //     // child: Text(
          //     //   //'READ MORE »',
          //     //   style: TextStyle(
          //     //     fontSize: 12,
          //     //     fontWeight: FontWeight.bold,
          //     //     color: Colors.red,
          //     //   ),
          //     // ),
          //   ),
          // ),
        ],
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
                      'Founded in 2021, Modern Western Trans was created with a singular vision: to be the trusted partner in our clients journey to success. With a commitment to innovation and excellence, we have consistently worked alongside our clients, turning challenges into opportunities and ensuring mutual growth every step of the way.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        print('Navigating to AboutUsPage');
                      // Ensure the path matches the defined route in GoRouter
                      context.go('/logistics/AboutUsPage');},
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get In Touch:',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Phone: +966567273714',
                    style: TextStyle(color: Colors.white),
                  ),
                  // Text(
                  //   'Phone: +966593619999',
                  //   style: TextStyle(color: Colors.orange),
                  // ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email: sales@mwtworld.com',
                    style: TextStyle(color: Colors.white),
                  ),

                ],
              ),
              // Address Column (Right)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    'Address:',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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




