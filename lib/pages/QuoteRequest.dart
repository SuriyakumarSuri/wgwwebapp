import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteRequestPage extends StatefulWidget {
  const QuoteRequestPage({super.key});

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEventType;
  DateTime? _selectedDate;

  final _guestsController = TextEditingController();
  final _budgetController = TextEditingController();
  final _preferencesController = TextEditingController();
  final _dateController = TextEditingController();

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
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _guestsController.dispose();
    _budgetController.dispose();
    _preferencesController.dispose();
    _dateController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.deepPurple[700]!,
              onPrimary: Colors.white,
              surface: Colors.deepPurple[900]!,
              onSurface: Colors.white70,
            ),
            dialogBackgroundColor: Colors.deepPurple[900]!.withOpacity(0.95),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: QuoteForm(
                          formKey: _formKey,
                          selectedEventType: _selectedEventType,
                          onEventTypeChanged: (value) => setState(() => _selectedEventType = value),
                          guestsController: _guestsController,
                          budgetController: _budgetController,
                          preferencesController: _preferencesController,
                          dateController: _dateController,
                          onPickDate: () => _pickDate(context),
                        ),
                      ),
                    ),
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

class QuoteForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedEventType;
  final ValueChanged<String?> onEventTypeChanged;
  final TextEditingController guestsController;
  final TextEditingController budgetController;
  final TextEditingController preferencesController;
  final TextEditingController dateController;
  final VoidCallback onPickDate;

  const QuoteForm({
    super.key,
    required this.formKey,
    required this.selectedEventType,
    required this.onEventTypeChanged,
    required this.guestsController,
    required this.budgetController,
    required this.preferencesController,
    required this.dateController,
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Request a Custom Quote',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Type of Event',
                      child: DropdownButtonFormField<String>(
                        value: selectedEventType,
                        items: ['Wedding', 'Birthday', 'Corporate']
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: onEventTypeChanged,
                        decoration: _inputDecoration('Select event type'),
                        validator: (value) =>
                            value == null ? 'Please select an event type' : null,
                        dropdownColor: Colors.deepPurple[900]!.withOpacity(0.95),
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Number of Guests',
                      child: TextFormField(
                        controller: guestsController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.montserrat(color: Colors.white),
                        decoration: _inputDecoration('Enter number of guests'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of guests';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Date',
                      child: TextFormField(
                        controller: dateController,
                        readOnly: true,
                        style: GoogleFonts.montserrat(color: Colors.white),
                        decoration: _inputDecoration('Select a date').copyWith(
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                          ),
                        ),
                        onTap: onPickDate,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Please select a date' : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Budget',
                      child: TextFormField(
                        controller: budgetController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.montserrat(color: Colors.white),
                        decoration: _inputDecoration('Enter your budget').copyWith(
                          prefixText: '\$ ',
                          prefixStyle: GoogleFonts.montserrat(color: Colors.white70),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your budget';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Preferences',
                      child: TextFormField(
                        controller: preferencesController,
                        maxLines: 4,
                        style: GoogleFonts.montserrat(color: Colors.white),
                        decoration: _inputDecoration('Enter any preferences'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => const ThankYouDialog(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Get My Custom Quote',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.montserrat(color: Colors.white38),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple[300]!, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        border: const Border(
          top: BorderSide(color: Colors.white12, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '© 2030 Al Wajhat Global Western Company Ltd.',
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'All rights reserved.',
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
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

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thank You!',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your quote request has been submitted. We will get back to you soon.',
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}