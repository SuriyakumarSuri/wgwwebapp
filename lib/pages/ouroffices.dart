import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'package:wgwwebapp/utils/pageTheme.dart';

class OurOfficesPage extends StatelessWidget {
  final PageTheme theme;
  OurOfficesPage({Key? key, required this.theme}) : super(key: key);

  final List<Map<String, String>> offices = [
    {
      'title': 'Al Wajhat Global Western Company Ltd., Head Office - JEDDAH',
      'address':
          'Al Azhar Building Tower - 7th Floor - Office # 601, Al Safa Dist., Jeddah 23535 - Kingdom of Saudi Arabia',
      'phone': '+966567273714',
      'email': 'info@wgwcltd.com',
      'mapUrl': 'https://www.google.com/maps/search/?api=1&query=Jeddah,+Saudi+Arabia',
      'image': 'assets/images/jeddah.webp',
    },
    {
      'title': 'Al Wajhat Global Western Company Ltd., - Oman',
      'address': '111 - Ruwi Street, 1st Floor - Building 202, Muscat, Oman',
      'phone': '+96898803274',
      'email': 'info@wgwcltd.com',
      'mapUrl': 'https://www.google.com/maps/search/?api=1&query=Muscat,+Oman',
      'image': 'assets/images/Muscat.jpg',
    },
    {
      'title': 'Al Wajhat Global Western Company Ltd., - Dubai',
      'address': 'Adel Ahmed Al Wahedi Building, Office # 273, Al Marrar, Dubai, United Arab Emirates',
      'phone': '+971585005581',
      'email': 'info@wgwcltd.com',
      'mapUrl': 'https://www.google.com/maps/search/?api=1&query=Dubai,+UAE',
      'image': 'assets/images/uae.jpg',
    },
  ];

  void _launchUrl(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  Widget officeCard(Map<String, String> office, int index, BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 600 + index * 200),
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                office['image']!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: Center(child: Text('Image not found')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          office['title'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home, color: Colors.brown[400]),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          office['address'] ?? '',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _launchUrl('tel:${office['phone']}', context),
                          child: Text(
                            'Call Customer Service: ${office['phone']}',
                            style: TextStyle(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _launchUrl('mailto:${office['email']}', context),
                          child: Text(
                            'Email: ${office['email']}',
                            style: TextStyle(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => _launchUrl(office['mapUrl']!, context),
                      icon: Icon(Icons.map),
                      label: Text('View on Map'),
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

  PreferredSizeWidget getAppBar() {
    switch (theme) {
      case PageTheme.construction:
        return const MainPageAppBar();
      case PageTheme.manpower:
        return const SubMainPageAppBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-career.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.55),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Our Global Offices',
                      textStyle: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: offices.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, String> office = entry.value;
                          return SizedBox(
                            width: MediaQuery.of(context).size.width >= 900
                                ? MediaQuery.of(context).size.width / 3 - 40
                                : MediaQuery.of(context).size.width,
                            child: officeCard(office, index, context),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              FooterSection(theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}
