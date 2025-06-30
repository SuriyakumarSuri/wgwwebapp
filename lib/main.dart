import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        path: '/eventmanagement',
        builder: (context, state) => EventManagementPage(),
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
        builder: (context, state) => office.OurOfficesPage(),
      ),

      GoRoute(
        path: "/contactus",
        builder: (context, state) => contact.ContactUsPage()
      ),

      GoRoute(
        path: '/careers',
        builder:(context, state) => careers.CareersPage(),
      ),

       GoRoute(
        path: '/quoterequest',
        builder:(context, state) => quote.QuoteRequestPage(),
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
