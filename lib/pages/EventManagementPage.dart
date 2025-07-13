import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventManagementPage extends StatefulWidget {
  @override
  _EventManagementPageState createState() => _EventManagementPageState();
}

class _EventManagementPageState extends State<EventManagementPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _fadeAnimation;

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
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
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

  final List<Map<String, dynamic>> eventData = [
    {
      'title': 'Corporate Events',
      'description': 'Conferences, product launches, and leadership summits.',
      'icon': Icons.business_center,
    },
    {
      'title': 'Weddings & Socials',
      'description': 'From grand weddings to intimate receptions.',
      'icon': Icons.favorite,
    },
    {
      'title': 'Birthday Parties',
      'description': 'Themed birthday experiences for all ages.',
      'icon': Icons.cake,
    },
    {
      'title': 'Cultural & Sports',
      'description': 'Cultural fests, sports days, and tournaments.',
      'icon': Icons.celebration,
    },
    {
      'title': 'Stage & AV Production',
      'description': 'Lighting, sound, multimedia displays, and live streaming.',
      'icon': Icons.theaters,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          backgroundColor: Color(0xFF6A0DAD),
          flexibleSpace: Row(
            children: [
              SlideTransition(
                position: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/wgw.png',
                          height: 80,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AL Wajhat Global Western',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Text(
                              'Company Ltd.',
                              style: TextStyle(fontSize: 16, color: Colors.white),
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
            for (var item in [
              {'title': 'Home', 'route': '/'},
              {'title': 'About Us', 'route': '/AboutUsPage'},
              {'title': 'Our Services', 'route': '/businessservices'},
              {'title': 'Industries', 'route': '/businessindustries'},
              {'title': 'Our Offices', 'route': '/officeaddress'},
              {'title': 'Careers', 'route': '/contactus'},
              {'title': 'Contact Us', 'route': '/contactus'},
            ])
              TextButton(
                onPressed: () => context.go(item['route']!),
                child: Text(item['title']!, style: TextStyle(color: Colors.white)),
              ),
            PopupMenuButton<String>(
              offset: Offset(0, 50),
              color: Colors.white,
              child: Row(
                children: [
                  Text('Business Groups', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
                ],
              ),
              onSelected: (value) => context.go(value),
              itemBuilder: (_) => [
                buildPopupMenuItem('Construction', '/construction'),
                buildPopupMenuItem('Manpower', '/manpower'),
                buildPopupMenuItem('Event Management', '/event'),
                buildPopupMenuItem('Browse all', '/ourbusiness'),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Management',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD)),
                ),
                SizedBox(height: 16),
                Text(
                  'We craft unforgettable experiences with precision and elegance. Whether it\'s a corporate function, a cultural fest, or a birthday celebration, our dedicated team brings your vision to life.',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey[800]),
                ),
                SizedBox(height: 32),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: eventData.map((event) => EventCardItem(
                    title: event['title'],
                    description: event['description'],
                    icon: event['icon'],
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterSection(),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6A0DAD),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.0),
          Text(
            '© 2030 Al Wajhat Global Western Company Ltd., All rights reserved.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EventCardItem extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const EventCardItem({required this.title, required this.description, required this.icon});

  @override
  State<EventCardItem> createState() => _EventCardItemState();
}

class _EventCardItemState extends State<EventCardItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF6A0DAD)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: Color(0xFF6A0DAD), size: 36),
              SizedBox(height: 12),
              Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD))),
              SizedBox(height: 8),
              Text(widget.description, style: TextStyle(fontSize: 16, color: Colors.blueGrey[700])),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/quoterequest'),
                child: Text('Book Now', style: TextStyle(color: Color(0xFF6A0DAD))),
              )
            ],
          ),
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
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 14, color: _isHovered ? Colors.black : Colors.grey[800]),
        ),
      ),
    );
  }
}