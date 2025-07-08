import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/animation.dart';

class ManpowerPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<ManpowerPage> with SingleTickerProviderStateMixin {
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
          backgroundColor: Color(0xFF022025), // Deep blue background color
          flexibleSpace: Row(
            children: [
              SlideTransition(
                position: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to home page on image tap
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Row(
                      children: [
                        // Logo
                        Image.asset(
                          'assets/images/wgw.png',
                          height: 80, // Adjust logo height
                          width: 70, // Adjust width for proper appearance
                          fit: BoxFit.contain, // Keep aspect ratio intact
                        ),
                        SizedBox(width: 8), // Space between logo and text column
                        // Column for Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                          children: [
                            Text(
                              'AL Wajhat Global Western',
                              style: TextStyle(
                                fontSize: 20, // Adjust font size as needed
                                fontWeight: FontWeight.bold, // Make "Manpower" bold
                                color: Colors.white, // Text color
                              ),
                            ),
                            Text(
                              'Company Ltd.',
                              style: TextStyle(
                                fontSize: 16, // Adjust font size for "Services"
                                fontWeight: FontWeight.normal, // Regular weight for "Services"
                                color: Colors.white, // Text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/manpower');
              },
              child: Text('Home', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/businessabout');
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
                      'Business Groups',
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
                    buildPopupMenuItem('Construction', '/construction'),
                    buildPopupMenuItem('Manpower', '/manpower'),
                    buildPopupMenuItem('Event Management', '/event'),
                    buildPopupMenuItem('Browse all', '/ourbusiness'),
                  ];
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/businessservices'); // Navigates to Contact Us page
              },
              child: Text('Our Services', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/businessindustries'); // Navigates to Contact Us page
              },
              child: Text('Industries', style: TextStyle(color: Colors.white)),
            ),
            // TextButton(
            //   onPressed: () {
            //     context.go('/contactus'); // Navigates to Contact Us page
            //   },
            //   child: Text('Job Seekers', style: TextStyle(color: Colors.white)),
            // ),
            TextButton(
              onPressed: () {
                context.go('/officeaddress'); // Navigates to Contact Us page
              },
              child: Text('Our Offices', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/contactus'); // Navigates to Contact Us page
              },
              child: Text('Careers', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/contactus'); // Navigates to Contact Us page
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
            IndustrySection(),
            BusinessSection(),
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
class HeroSection extends StatefulWidget {
  @override
  _HeroSectionState createState() => _HeroSectionState();
}
class _HeroSectionState extends State<HeroSection> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/manpower1.jpg',
      'title': 'Empowering Projects with Skilled Talent Worldwide',
      'subtitle': 'Highlights the strength and global reach of your manpower services',
    },
    {
      'image': 'assets/images/manpower2.jpg',
      'title': 'Skilled Workforce for Your Every Need',
      'subtitle': 'Simple and effective, emphasizing versatility and expertise',
    },
    {
      'image': 'assets/images/manpower3.jpg',
      'title': 'Reliable Manpower for Every Industry, Anywhere',
      'subtitle': 'Reflects the reliability and wide-ranging services for various industries',
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
//Servicessection
class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}
class _ServicesSectionState extends State<ServicesSection> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  late AnimationController _typewriterController;
  late String _displayText = '';
  final String _fullText = 'Our Services';

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _startTypewriterAnimation();
  }
  void _startTypewriterAnimation() {
    _typewriterController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _typewriterController.addListener(() {
      setState(() {
        int currentLength = (_typewriterController.value * _fullText.length).round();
        _displayText = _fullText.substring(0, currentLength);
      });
    });

    _typewriterController.repeat(reverse: true);
  }
  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    _typewriterController.dispose();
    super.dispose();
  }
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double nextScroll = currentScroll + 260 + 12;

        if (nextScroll >= maxScroll) {
          _scrollController.jumpTo(0);
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
          colors: [Colors.blue.shade200, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _displayText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _serviceData.length,
              padding: EdgeInsets.only(left: 0, right: 20),
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return _buildServiceCard(
                  imagePath: _serviceData[index]['imagePath']!,
                  title: _serviceData[index]['title']!,
                  description: _serviceData[index]['description']!,
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
      width: 260,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  final _serviceData = [
    {
      'imagePath': 'assets/images/saudi.jpg',
      'title': 'Saudi Local Workforce Recruitment',
      'description': 'Reliable local manpower solutions for Saudi projects.',
    },
    {
      'imagePath': 'assets/images/global.jpg',
      'title': 'Global Workforce Recruitment',
      'description': 'Expert recruitment for overseas projects.',
    },
    {
      'imagePath': 'assets/images/executive.jpg',
      'title': 'Executive Hiring Solutions',
      'description': 'Executive placements for business leadership roles.',
    },
    {
      'imagePath': 'assets/images/virtual.jpg',
      'title': 'Virtual Staffing Services',
      'description': 'Remote staffing for global business needs.',
    },
    {
      'imagePath': 'assets/images/housekeeping.jpg',
      'title': 'Outsourced Staffing Solutions',
      'description': 'Outsourcing skilled labor for various industries.',
    },
    {
      'imagePath': 'assets/images/job.jpg',
      'title': 'Job Placement Solutions',
      'description': 'Matching talent with the right opportunities.',
    },
  ];
}
//Industrysection
class IndustrySection extends StatefulWidget {
  const IndustrySection({Key? key}) : super(key: key);

  @override
  State<IndustrySection> createState() => _IndustrySectionState();
}
class _IndustrySectionState extends State<IndustrySection> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  late AnimationController _typewriterController;
  late String _displayText = '';
  final String _fullText = 'Our Focused Industries';
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _startTypewriterAnimation();
  }
  void _startTypewriterAnimation() {
    _typewriterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _typewriterController.addListener(() {
      setState(() {
        int currentLength = (_typewriterController.value * _fullText.length).round();
        _displayText = _fullText.substring(0, currentLength);
      });
    });

    _typewriterController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    _typewriterController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double nextScroll = currentScroll + 280;

        if (nextScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _displayText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _serviceData.length,
              padding: const EdgeInsets.only(left: 0, right: 20),
              itemBuilder: (context, index) {
                return _buildServiceCard(
                  imagePath: _serviceData[index]['imagePath']!,
                  title: _serviceData[index]['title']!,

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
  }) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.pink.shade200, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220, // Increased image height
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover, // Ensures the image fills the container
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18, // Slightly larger font size for the title
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  final List<Map<String, String>> _serviceData = [
    {
      'imagePath': 'assets/images/industry/cons.png',
      'title': 'Construction Industry',

    },
    {
      'imagePath': 'assets/images/industry/bpo.jpg',
      'title': 'Technology Sector',

    },
    {
      'imagePath': 'assets/images/industry/health.jpg',
      'title': 'Healthcare Industry',
    },
    {
      'imagePath': 'assets/images/industry/hosp.jpg',
      'title': 'Hospitality Sector',

    },
    {
      'imagePath': 'assets/images/industry/power.jpg',
      'title': 'Power Industry',

    },
    {
      'imagePath': 'assets/images/industry/oil.jpg',
      'title': 'OIL & GAS',

    },
    {
      'imagePath': 'assets/images/industry/manu.jpg',
      'title': 'Manufacturing Industry',

    },
    {
      'imagePath': 'assets/images/industry/tele.jpg',
      'title': 'Telecommunications',

    },
    {
      'imagePath': 'assets/images/industry/tech.jpg',
      'title': 'IT/BPO',

    },
    {
      'imagePath': 'assets/images/industry/ban2.jpg',
      'title': 'Banking',

    },
    {
      'imagePath': 'assets/images/industry/aviation.jpg',
      'title': 'Aviation',

    },
    {
      'imagePath': 'assets/images/industry/finance.jpg',
      'title': 'Financial',

    },

  ];
}
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: IndustrySection(),
    ),
  ));
}
//Business Section
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
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our Other Divisions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 350,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _businessData.length,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final service = _businessData[index];
                return _buildbusinessCard(
                  imagePath: service['imagePath']!,
                  title: service['title']!,
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => Icon(Icons.circle, size: 8, color: index == 0 ? Colors.red : Colors.white)).expand((icon) => [icon, SizedBox(width: 4)]).toList()..removeLast(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbusinessCard({required String imagePath, required String title}) {
    return GestureDetector(
      onTap: () {
        if (title == 'Construction') {
          context.go('/aboutconstruction');
        } else if (title == 'Manpower') {
          context.go('/manpower');
        } else if (title == 'Event Management') {
          context.go('/eventmanagement');
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        width: 350,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
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
/// Service Data
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
//About us//
class AboutUsSection extends StatefulWidget {
  @override
  _AboutUsSectionState createState() => _AboutUsSectionState();
}
class _AboutUsSectionState extends State<AboutUsSection> with TickerProviderStateMixin {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after a slight delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Empowering Your Workforce Needs with Trusted Manpower Services!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We provide highly skilled and reliable workers for housekeeping, drivers, security, construction, and more. Our commitment is to deliver quality services with customer satisfaction and timely solutions.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Learn More", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          SizedBox(width: 20), // Space between the content and the image
          // Animated Image Container with combined opacity and slide-in effect
          AnimatedOpacity(
            opacity: _animate ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: _animate ? 180 : 120, // Adjusted size for better look
              width: _animate ? 180 : 120,  // Adjusted size for better look
              transform: Matrix4.translationValues(
                  _animate ? 0.0 : 200.0, 0.0, 0.0), // Slide-in effect from the right
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/manpower3.jpg', // Replace with your image path
                fit: BoxFit.cover,  // Use BoxFit.cover for better image fit
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Footer Section//
class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF012429),
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
                    'Email: info@wgwcltd.com',
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
                '© 2025 Al Wajhat Global Western Groups Ltd. All rights reserved.',
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

