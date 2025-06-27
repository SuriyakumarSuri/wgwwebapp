import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ServicePageApp());
}

class ServicePageApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/service',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/service', builder: (context, state) => ServicePageScreen()),
      GoRoute(path: '/AboutUsPage', builder: (context, state) => AboutUsScreen()),
      GoRoute(path: '/officeaddress', builder: (context, state) => OfficeAddressScreen()),
      GoRoute(path: '/quoterequest', builder: (context, state) => QuoteRequestScreen()),
      GoRoute(path: '/contactus', builder: (context, state) => ContactUsScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WGW',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

class ServicePageScreen extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'title': 'General Contracting',
      'description': 'Complete solutions for commercial and residential projects.',
      'image': 'assets/images/servicescons/general.jpg',
    },
    {
      'title': 'Design & Build',
      'description': 'From concept to completion, we handle it all.',
      'image': 'assets/images/servicescons/design.jpg',
    },
    {
      'title': 'Civil Engineering',
      'description': 'Expertise in infrastructure and large-scale developments.',
      'image': 'assets/images/servicescons/civil.jpg',
    },
    {
      'title': 'Residential Construction',
      'description': 'Building dream homes with precision and care.',
      'image': 'assets/images/servicescons/res.jpg',
    },
    {
      'title': 'Infrastructure Development',
      'description': 'Creating essential infrastructure for tomorrow.',
      'image': 'assets/images/servicescons/civil.jpg',
    },
    {
      'title': 'MEP Services',
      'description': 'Ensuring buildings operate efficiently.',
      'image': 'assets/images/servicescons/mep.jpg',
    },
    {
      'title': 'Renovation Works',
      'description': 'Breathing new life into old spaces.',
      'image': 'assets/images/servicescons/renovation.jpg',
    },
    {
      'title': 'Interior Solutions',
      'description': 'Beautiful interiors tailored to your lifestyle.',
      'image': 'assets/images/servicescons/interior.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CustomAppBar(currentRoute: '/service'),
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
                      image: AssetImage('assets/images/construction/construction4.jpg'),
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
            SizedBox(height: 10),
            FooterSection(),
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

class _ServiceCardState extends State<ServiceCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
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
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? currentRoute;

  CustomAppBar({this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF003366),
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Image.asset(
          'assets/images/wgw.jpg',
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.go('/'),
          child: Text('Home', style: TextStyle(color: currentRoute == '/' ? Colors.yellow : Colors.white)),
        ),
        TextButton(
          onPressed: () => context.go('/AboutUsPage'),
          child: Text('About Us', style: TextStyle(color: currentRoute == '/AboutUsPage' ? Colors.yellow : Colors.white)),
        ),
        TextButton(
          onPressed: () => context.go('/officeaddress'),
          child: Text('Our Offices', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => context.go('/quoterequest'),
          child: Text('Quote Request', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => context.go('/contactus'),
          child: Text('Contact Us', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Get In Touch:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text('Phone: +966567273714', style: TextStyle(color: Colors.white)),
                  Text('Email: sales@mwtworld.com', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('Al Azhar Building Tower', style: TextStyle(color: Colors.white)),
                  Text('Al Safa Dist', style: TextStyle(color: Colors.white)),
                  Text('Jeddah 23535, Saudi Arabia', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Center(
            child: Text('© 2024 MWT Solutions. All rights reserved.', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(currentRoute: '/'),
        body: Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
      );
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(currentRoute: '/AboutUsPage'),
        body: Center(child: Text('About Us', style: TextStyle(fontSize: 24))),
      );
}

class OfficeAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(currentRoute: '/officeaddress'),
        body: Center(child: Text('Our Offices', style: TextStyle(fontSize: 24))),
      );
}

class QuoteRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(currentRoute: '/quoterequest'),
        body: Center(child: Text('Quote Request', style: TextStyle(fontSize: 24))),
      );
}

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(currentRoute: '/contactus'),
        body: Center(child: Text('Contact Us', style: TextStyle(fontSize: 24))),
      );
}
