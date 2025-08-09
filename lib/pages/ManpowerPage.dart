import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/animation.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManpowerPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ManpowerPage>
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
      appBar: SubMainPageAppBar(),
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

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
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
        int currentLength =
            (_typewriterController.value * _fullText.length).round();
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
      'imagePath': 'assets/images/MEP_Services.jpg',
      'title': 'MEP Services',
      'description': 'Reliable local manpower solutions for MEP projects across Saudi Arabia',
    },
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

class IndustrySection extends StatefulWidget {
  const IndustrySection({Key? key}) : super(key: key);

  @override
  State<IndustrySection> createState() => _IndustrySectionState();
}

class _IndustrySectionState extends State<IndustrySection>
    with TickerProviderStateMixin {
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
        int currentLength =
            (_typewriterController.value * _fullText.length).round();
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
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
              style: const TextStyle(
                fontSize: 18,
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
              children: List.generate(
                      3,
                      (index) => Icon(Icons.circle,
                          size: 8,
                          color: index == 0 ? Colors.red : Colors.white))
                  .expand((icon) => [icon, SizedBox(width: 4)])
                  .toList()
                ..removeLast(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbusinessCard(
      {required String imagePath, required String title}) {
     return GestureDetector(
      onTap: () {
        if (title == 'Construction') {
          context.go('/aboutconstruction');
        } else if (title == 'Manpower') {
          context.go('/manpower');
        } else if (title == 'Event Management') {
          context.go('/event');
        } else if (title == 'Event Management') {
          context.go('/event');
        } else if (title == 'Logistics') {
          context.go('/logistics/home');
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
  {
    'imagePath': 'assets/images/images/logistics.jpg',
    'title': 'Logistics',
  },
];

class AboutUsSection extends StatefulWidget {
  @override
  _AboutUsSectionState createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection>
    with TickerProviderStateMixin {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Your About Us content here
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'About Us Section',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// --- FIXED FooterSection ---
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
      color: const Color(0xFF222222),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _footerColumn(
                  "QUICK LINKS",
                  [
                    _FooterLink(label: 'About Us', onTap: () => context.go('/businessabout')),
                    _FooterLink(label: 'Our Services', onTap: () => context.go('/businessservices')),
                    _FooterLink(label: 'Industries', onTap: () => context.go('/businessindustries')),
                    _FooterLink(label: 'Our Offices', onTap: () => context.go('/officeaddress-manpower')),
                    _FooterLink(label: 'Career', onTap: () => context.go('/careers-manpower')),
                    _FooterLink(label: 'Contact Us', onTap: () => context.go('/contactus-manpower')),
                  ],
                ),
              ),
              Expanded(
                child: _footerColumn(
                  "CONTACT",
                  [
                    Text('Phone: +966567273714', style: TextStyle(color: Colors.white)),
                    Text('Email: info@wgwcltd.com', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: _footerColumn(
                  "ADDRESS",
                  [
                    Text('Al Azhar Building Tower', style: TextStyle(color: Colors.white)),
                    Text('Al Safa Dist', style: TextStyle(color: Colors.white)),
                    Text('Jeddah 23535, Saudi Arabia', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: _footerColumn(
                  "SOCIAL",
                  [
                    Row(
                      children: [
                        _socialIcon(FontAwesomeIcons.facebookF, 'https://facebook.com'),
                        SizedBox(width: 8),
                        _socialIcon(FontAwesomeIcons.twitter, 'https://twitter.com'),
                        SizedBox(width: 8),
                        _socialIcon(FontAwesomeIcons.linkedinIn, 'https://linkedin.com'),
                        SizedBox(width: 8),
                        _socialIcon(FontAwesomeIcons.youtube, 'https://youtube.com'),
                        SizedBox(width: 8),
                        _socialIcon(FontAwesomeIcons.instagram, 'https://instagram.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.white24),
          SizedBox(height: 8),
          Center(
            child: Text(
              '© 2025 Al Wajhat Global Western Groups Ltd. All rights reserved.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFD32F2F),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
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
        padding: EdgeInsets.symmetric(vertical: 4.0),
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
