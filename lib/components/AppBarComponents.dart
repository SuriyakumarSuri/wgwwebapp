// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(85);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3A0303),
      flexibleSpace: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Image.asset(
                'assets/images/wgw.jpg',
                height: 80,
                width: 70,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
            padding:
                const EdgeInsets.only(top: 20), // adjust this value as needed
            child: Row(mainAxisSize: MainAxisSize.min, children: [
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
                      Text('Business Groups',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Icon(Icons.arrow_drop_down,
                          color: Colors.white, size: 18),
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
            ]))
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

