import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventManagementPage extends StatefulWidget {
  @override
  _EventManagementPageState createState() => _EventManagementPageState();
}

class _EventManagementPageState extends State<EventManagementPage> with SingleTickerProviderStateMixin {
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
      backgroundColor: Colors.blueGrey.shade50,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          backgroundColor: Color(0xFF800020),
          flexibleSpace: Row(
            children: [
              SlideTransition(
                position: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      context.go('/');
                    },
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
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Company Ltd.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
                context.go('/');
              },
              child: Text('Home', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/AboutUsPage');
              },
              child: Text('About Us', style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: PopupMenuButton<String>(
                offset: Offset(0, 50),
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
            TextButton(
              onPressed: () {
                context.go('/businessservices');
              },
              child: Text('Our Services', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/businessindustries');
              },
              child: Text('Industries', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/officeaddress');
              },
              child: Text('Our Offices', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/contactus');
              },
              child: Text('Careers', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                context.go('/contactus');
              },
              child: Text('Contact Us', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
          child: Text(
            'Event Management Page Content Goes Here',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[900],
            ),
            textAlign: TextAlign.center,
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
      color: Color(0xFF800020),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
