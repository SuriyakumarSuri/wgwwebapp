import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/utils/pageTheme.dart';

class MainPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainPageAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(85);

  @override
  State<MainPageAppBar> createState() => _MainPageAppBarState();
}

class _MainPageAppBarState extends State<MainPageAppBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  bool get _isHome =>
      GoRouterState.of(context).location == '/' ||
      GoRouterState.of(context).location == '/home';

  @override
  void initState() {
    super.initState();
    // Animation controller will be initialized in build if needed
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildLogoAndText() {
    final logoRow = Row(
      children: [
        Image.asset(
          'assets/images/wgw.png',
          height: 80,
          width: 70,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
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
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );

    if (_isHome) {
      // Only animate on home
      _controller ??= AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..forward();
      _animation ??= Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ));
      return SlideTransition(
        position: _animation!,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              if (!_isHome) context.go('/');
            },
            child: logoRow,
          ),
        ),
      );
    } else {
      // Static for other routes
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: () {
            if (!_isHome) context.go('/');
          },
          child: logoRow,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3A0303),
      flexibleSpace: Row(
        children: [
          _buildLogoAndText(),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.go('/'),
                child:
                    const Text('Home', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.go('/aboutconstruction'),
                child: const Text('About Us',
                    style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: PopupMenuButton<String>(
                  offset: const Offset(0, 50),
                  color: Colors.white,
                  child: const Row(
                      children: [
                    Text('Business Groups', style: TextStyle(color: Colors.white)),
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
              ),
              TextButton(
                onPressed: () => context.go('/services'),
                child: const Text('Our Services',
                    style: TextStyle(color: Colors.white)),
              ),
              // TextButton(
              //   onPressed: () => context.go('/quoterequest'),
              //   child: const Text('Quote Request',
              //       style: TextStyle(color: Colors.white)),
              // ),
              TextButton(
                onPressed: () => context.go('/officeaddress'),
                child: const Text('Our Offices',
                    style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.go('/careers'),
                child: const Text('Careers',
                    style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.go('/contactus'),
                child: const Text('Contact Us',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        )
      ],
    );
  }

  static PopupMenuItem<String> buildPopupMenuItem(String title, String route) {
    return PopupMenuItem<String>(
      value: route,
      child: Text(title),
    );
  }
}



class SubMainPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SubMainPageAppBar({super.key});

  @override
  State<SubMainPageAppBar> createState() => _SubMainPageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class _SubMainPageAppBarState extends State<SubMainPageAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
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

  static PopupMenuItem<String> buildPopupMenuItem(String title, String route) {
    return PopupMenuItem<String>(
      value: route,
      child: Text(title)
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF022025),
      automaticallyImplyLeading: false,
      toolbarHeight: 85,
      titleSpacing: 0,
      title: Align(
      // THIS IS THE KEY: Align the entire content to the bottom
      alignment: Alignment.bottomLeft,
      child:Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SlideTransition(
          position: _animation,
          child: GestureDetector(
            onTap: () => context.go('/home'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/wgw.png',
                  height: 80,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'AL Wajhat Global Western',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Company Ltd.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.go('/manpower'),
                child: const Text('Home', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.go('/businessabout'),
                child: const Text('About Us', style: TextStyle(color: Colors.white)),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: PopupMenuButton<String>(
                offset: const Offset(0, 60),
                color: Colors.white,
                child: const Row(
                  children: [
                    Text('Business Groups', style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
                  ],
                ),
                onSelected: (value) => context.go(value),
                itemBuilder: (_) => [
                  buildPopupMenuItem('Construction', '/'),
                  buildPopupMenuItem('Manpower', '/manpower'),
                  buildPopupMenuItem('Event Management', '/event'),
                  buildPopupMenuItem('Browse all', '/ourbusiness'),
                ],
              ),
               ),
              TextButton(
                onPressed: () => context.go('/businessservices'),
                child: const Text('Our Services', style: TextStyle(color: Colors.white)),
              ),
               TextButton(
              onPressed: () {
                context.go('/businessindustries');
              },
              child: const Text('Industries', style: TextStyle(color: Colors.white)),
            ),
            // TextButton(
            //   onPressed: () {
            //     context.go('/contactus'); 
            //   },
            //   child: const Text('Job Seekers', style: TextStyle(color: Colors.white)),
            // ),
              TextButton(
                onPressed: () => context.go('/officeaddress-manpower'),
                child: const Text('Our Offices', style: TextStyle(color: Colors.white)),
              ),
              // TextButton(
              //   onPressed: () => context.go('/quoterequest'),
              //   child: const Text('Quote Request', style: TextStyle(color: Colors.white)),
              // ),
              TextButton(
                onPressed: () => context.go('/careers-manpower'),
                child: const Text('Careers', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => context.go('/contactus-manpower'),
                child: const Text('Contact Us', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  final PageTheme theme;

  const FooterSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (theme) {
      PageTheme.manpower => const Color(0xFF022025),
      PageTheme.construction => const Color(0xFF3A0303),
    };

    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: const Center(
        child: Text(
          '© 2030 Al Wajhat Global Western Company Ltd., All rights reserved.',
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
