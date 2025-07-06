import 'package:flutter/material.dart';

class AnimatedLogoAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onLogoTap;
  final List<Widget>? actions;

  AnimatedLogoAppBar({this.onLogoTap, this.actions});

  @override
  _AnimatedLogoAppBarState createState() => _AnimatedLogoAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(85);
}

class _AnimatedLogoAppBarState extends State<AnimatedLogoAppBar> with SingleTickerProviderStateMixin {
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
    return AppBar(
      backgroundColor: Color(0xFF022025),
      flexibleSpace: Row(
        children: [
          SlideTransition(
            position: _animation,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: widget.onLogoTap,
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
      actions: widget.actions,
    );
  }
}