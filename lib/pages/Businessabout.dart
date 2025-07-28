import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';

class BusinessAbout extends StatefulWidget {
  @override
  _BusinessAboutState createState() => _BusinessAboutState();
}

class _BusinessAboutState extends State<BusinessAbout> with SingleTickerProviderStateMixin {
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
      appBar:SubMainPageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 260,
                  child: Image.asset(
                    'assets/images/futureofmepdesing.jpg', // <-- Add your image here
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 260,
                  color: Colors.black.withOpacity(0.35),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedText(
                        text: 'About Our Company',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'AL Wajhat Global Western Company Ltd.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // About Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 48, horizontal: 28),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 900;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company Image
                      if (isWide)
                        Container(
                          width: 320,
                          height: 320,
                          margin: EdgeInsets.only(right: 36),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.12),
                                blurRadius: 16,
                                offset: Offset(0, 8),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/images/civil.jpg'), // <-- Add your image here
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      // Description and Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AnimatedIconWidget(),
                                SizedBox(width: 16),
                                Text(
                                  'Who We Are',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF022025),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Divider(thickness: 1, color: Colors.blueGrey.shade100),
                            SizedBox(height: 18),
                            Text(
                              'AL Wajhat Global Western Company Ltd. is a leading diversified business group in Saudi Arabia, offering a wide range of services and solutions across construction, manpower, event management, and more.',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[900],
                                height: 1.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              'Founded with a vision to drive progress and innovation, our company has consistently delivered high-quality projects and services to clients across various industries. We pride ourselves on our commitment to excellence, customer satisfaction, and sustainable growth.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[800],
                                height: 1.7,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              'Our passionate and skilled team brings together years of expertise, ensuring that every project is executed with professionalism, integrity, and a focus on best practices. We believe in empowering our people, fostering innovation, and making a positive impact on the Kingdom’s development.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[800],
                                height: 1.7,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              'As we look to the future, AL Wajhat Global Western Company Ltd. remains dedicated to building lasting partnerships, embracing new technologies, and contributing to the prosperity of Saudi Arabia.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[800],
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Mission, Vision, Values
            Container(
              width: double.infinity,
              color: Colors.blueGrey.shade50,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Mission, Vision & Values',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF022025),
                    ),
                  ),
                  SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isWide = constraints.maxWidth > 900;
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          SizedBox(
                            width: isWide ? (constraints.maxWidth - 40) / 3 : constraints.maxWidth,
                            child: CompanyInfoCard(
                              icon: Icons.flag_outlined,
                              iconColor: Colors.blueAccent,
                              title: 'Our Mission',
                              content: 'To deliver world-class solutions and services that exceed client expectations, contribute to the development of Saudi Arabia, and empower our people to achieve excellence.',
                            ),
                          ),
                          SizedBox(
                            width: isWide ? (constraints.maxWidth - 40) / 3 : constraints.maxWidth,
                            child: CompanyInfoCard(
                              icon: Icons.remove_red_eye_outlined,
                              iconColor: Colors.deepPurple,
                              title: 'Our Vision',
                              content: 'To be recognized as a trusted leader across multiple industries in the Kingdom, known for our quality, reliability, and commitment to sustainable growth.',
                            ),
                          ),
                          SizedBox(
                            width: isWide ? (constraints.maxWidth - 40) / 3 : constraints.maxWidth,
                            child: CompanyInfoCard(
                              icon: Icons.verified_outlined,
                              iconColor: Colors.green,
                              title: 'Our Core Values',
                              contentWidget: Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: [
                                  _valueChip('Integrity'),
                                  _valueChip('Innovation'),
                                  _valueChip('Excellence'),
                                  _valueChip('Teamwork'),
                                  _valueChip('Customer Focus'),
                                  _valueChip('Sustainability'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: FooterSection(),
    );
  }

  Widget _valueChip(String label) {
    return Chip(
      label: Text(label, style: TextStyle(color: Color(0xFF022025))),
      backgroundColor: Colors.blueGrey.shade100,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    );
  }
}

class AnimatedIconWidget extends StatefulWidget {
  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    _iconAnimation =
        CurvedAnimation(parent: _iconController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _iconAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Icon(Icons.info_outline, color: Color(0xFF022025), size: 40),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const AnimatedText({required this.text, required this.style, Key? key}) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this)
          ..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}

class CompanyInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? content;
  final Widget? contentWidget;

  const CompanyInfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.content,
    this.contentWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueGrey.withOpacity(0.16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 36),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF022025),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            contentWidget ??
                Text(
                  content ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF022025),
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