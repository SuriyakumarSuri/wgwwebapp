import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgwwebapp/components/AppBarComponents.dart';
import 'package:wgwwebapp/utils/pageTheme.dart';
class OurOfficesPage extends StatelessWidget {
  final PageTheme theme;
  OurOfficesPage({Key? key, required this.theme}) : super(key: key);
  final List<Map<String, String>> offices = [
    {
      'title': 'MWT Logistic Solution Head Office - JEDDAH',
      'address':
          'Al Azhar Building Tower - 7th Floor - Office # 601, Al Safa Dist., Jeddah 23535 - Kingdom of Saudi Arabia',
      'phone': '+966567273714',
      'email': 'sales@mwtworld.com',
      'mapUrl':
          'https://www.google.com/maps/search/?api=1&query=Jeddah,+Saudi+Arabia',
    },
    {
      'title': 'MWT Logistic Solution - Oman',
      'address':
          '111 - Ruwi Street, 1st Floor - Building 202, Muscat, Oman',
      'phone': '+96898803274',
      'email': 'sales@mwtworld.com',
      'mapUrl':
          'https://www.google.com/maps/search/?api=1&query=Muscat,+Oman',
    },
    {
      'title': 'MWT Logistic Solution - Dubai',
      'address':
          'Adel Ahmed Al Wahedi Building, Office # 273, Al Marrar, Dubai, United Arab Emirates',
      'phone': '+971585005581',
      'email': 'sales@mwtworld.com',
      'mapUrl':
          'https://www.google.com/maps/search/?api=1&query=Dubai,+UAE',
    },
  ];

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget officeCard(Map<String, String> office) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
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
                    onTap: () => _launchUrl('tel:${office['phone']}'),
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
                    onTap: () => _launchUrl('mailto:${office['email']}'),
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
                onPressed: () => _launchUrl(office['mapUrl']!),
                icon: Icon(Icons.map),
                label: Text('View on Map'),
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
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.orange.shade100.withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: offices.map((office) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width >= 900
                              ? MediaQuery.of(context).size.width / 3 - 40
                              : MediaQuery.of(context).size.width,
                          child: officeCard(office),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                FooterSection(theme: theme),
              ],
            );
          },
        ),
      ),
    );
  }
}

