import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EventAboutUs extends StatefulWidget {
  const EventAboutUs({super.key});

  @override
  State<EventAboutUs> createState() => _EventAboutUsState();
}

class _EventAboutUsState extends State<EventAboutUs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A0B2E), Color(0xFF2E1A47)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                    child: AboutUsContent(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: FooterSection()),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple[900]!.withOpacity(0.9), Colors.transparent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () => context.go('/'),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/wgw.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AL Wajhat Global',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Western Company Ltd.',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var item in [
                              {'title': 'Home', 'route': '/event'},
                              {'title': 'About Us', 'route': '/eventaboutus'},
                              {'title': 'Quote Request', 'route': '/QuoteRequest'},
                              {'title': 'Contact Us', 'route': '/EventContactus'},
                              // {'title': 'Contact Us', 'route': '/contactus'},
                            ])
                              _buildNavButton(context, item['title']!, item['route']!),
                            _buildBusinessGroupsMenu(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: () => context.go(route),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          foregroundColor: Colors.white,
        ),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessGroupsMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.deepPurple[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(
              'Business Groups',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
          ],
        ),
      ),
      onSelected: (value) => context.go(value),
      itemBuilder: (_) => [
        _buildPopupMenuItem('Construction', '/construction'),
        _buildPopupMenuItem('Manpower', '/manpower'),
        _buildPopupMenuItem('Event Management', '/event'),
        _buildPopupMenuItem('Logistics', '/logistics/home'),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 48,
      child: HoverableMenuItem(title: title),
    );
  }
}

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/Event/EM.jpg',
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Where Vision Meets Execution',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildAboutContent(context),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple[700]!.withOpacity(0.2),
                      Colors.deepPurple[900]!.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About AL Wajhat Global Western Company Ltd.',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'AL Wajhat Global Western Company Ltd. is a premier global enterprise...',
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Our Mission', style: _sectionTitleStyle()),
                  const SizedBox(height: 12),
                  Text(
                    'To create unforgettable experiences...',
                    style: _bodyStyle(),
                  ),
                  const SizedBox(height: 24),
                  Text('Our Vision', style: _sectionTitleStyle()),
                  const SizedBox(height: 12),
                  Text(
                    'To be the leading global partner...',
                    style: _bodyStyle(),
                  ),
                  const SizedBox(height: 24),
                  Text('Why Choose Us?', style: _sectionTitleStyle()),
                  const SizedBox(height: 12),
                  _buildWhyChooseUsItem(Icons.star_border, 'Unmatched expertise...'),
                  _buildWhyChooseUsItem(Icons.group, 'Dedicated global team...'),
                  _buildWhyChooseUsItem(Icons.lightbulb_outline, 'Innovative solutions...'),
                  _buildWhyChooseUsItem(Icons.verified, 'Commitment to quality...'),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => context.go('/EventContactus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Get in Touch',
                        style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle() => GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  TextStyle _bodyStyle() => GoogleFonts.montserrat(
        color: Colors.white70,
        fontSize: 16,
        height: 1.5,
      );

  Widget _buildWhyChooseUsItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple[300], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: _bodyStyle()),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.deepPurple[900]!.withOpacity(0.9),
        border: const Border(top: BorderSide(color: Colors.white12)),
      ),
      child: Column(
        children: [
          Text(
            '© 2030 Al Wajhat Global Western Company Ltd.',
            style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 14),
          ),
          Text(
            'All rights reserved.',
            style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class HoverableMenuItem extends StatefulWidget {
  final String title;
  const HoverableMenuItem({super.key, required this.title});

  @override
  State<HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<HoverableMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.deepPurple[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? Colors.deepPurple[300]! : Colors.transparent,
          ),
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isHovered ? Colors.deepPurple[900] : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
