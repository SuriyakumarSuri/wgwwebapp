import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/pages/BusinessIndustries.dart';
import 'package:wgwwebapp/pages/BusinessServices.dart';
import 'package:wgwwebapp/pages/Businessabout.dart';
import 'package:wgwwebapp/pages/OurBuisnessPage.dart';
import 'package:wgwwebapp/pages/home.dart' as home;
import 'package:wgwwebapp/pages/aboutconstruction.dart' as about;
import 'package:wgwwebapp/pages/ConstructionPage.dart';
import 'package:wgwwebapp/pages/EventManagementPage.dart';
import 'package:wgwwebapp/pages/ManpowerPage.dart';
import 'package:wgwwebapp/pages/servicesconstruction.dart' as service;
import 'package:wgwwebapp/pages/ouroffices.dart' as office;
import 'package:wgwwebapp/pages/contactus.dart' as contact;
import 'package:wgwwebapp/pages/careers.dart' as careers;
import 'package:wgwwebapp/pages/QuoteRequest.dart' as quote;
import 'package:wgwwebapp/utils/pageTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => home.HomePage(),

      ),
      GoRoute(
        path: '/aboutconstruction',
        builder: (context, state) => about.AboutUsPage(),
      ),
      GoRoute(
        path: '/construction',
        builder: (context, state) => ConstructionPage(),
      ),
      GoRoute(
        path: '/manpower',
        builder: (context, state) => ManpowerPage(),
      ),
      GoRoute(
        path: '/aboutconstruction',
        builder: (context, state) => about.AboutUsPage(),
      ),
      GoRoute(
        path: '/event',
        builder: (context, state) => EventManagementPage(),
      ),
      GoRoute(
        path: '/ourbusiness',
        builder: (context, state) => OurBuisnessPage(),
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => service.ServicePageScreen(), // not ServicePageApp
      ),

      GoRoute(
        path: '/AboutUsPage',
        builder: (context, state) =>  about.AboutUsPage(),
      ),

      GoRoute(
        path: '/officeaddress',
        builder: (context, state) => office.OurOfficesPage(theme: PageTheme.construction)
      ),
      GoRoute(
        path: '/officeaddress-manpower',
        builder: (context, state) => office.OurOfficesPage(theme: PageTheme.manpower)
      ),
      
      GoRoute(
        path: "/contactus",
        builder: (context, state) => contact.ContactUsPage(theme: PageTheme.construction)
      ),

      GoRoute(
        path: "/contactus-manpower",
        builder: (context, state) => contact.ContactUsPage(theme: PageTheme.manpower)
      ),

      GoRoute(
        path: '/careers',
        builder:(context, state) => careers.CareersPage(theme: PageTheme.construction),
      ),

       GoRoute(
        path: '/careers-manpower',
        builder:(context, state) => careers.CareersPage(theme: PageTheme.manpower),
      ),

       GoRoute(
        path: '/quoterequest',
        builder:(context, state) => quote.QuoteRequestPage(),
      ),

       GoRoute(
        path: '/businessservices',
        builder:(context, state) => BuisnessServicePage(),
      ),

       GoRoute(
        path: '/businessindustries',
        builder:(context, state) => Businessindustries(),
      ),

       GoRoute(
        path: '/businessabout',
        builder:(context, state) => BusinessAbout(),
      )

    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WGW Web App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
