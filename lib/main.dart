import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wgwwebapp/pages/BusinessIndustries.dart';
import 'package:wgwwebapp/pages/BusinessServices.dart';
import 'package:wgwwebapp/pages/OurBuisnessPage.dart';
import 'package:wgwwebapp/pages/home.dart' as home;
import 'package:wgwwebapp/pages/aboutconstruction.dart' as aboutcons;
import 'package:wgwwebapp/pages/ConstructionPage.dart';
import 'package:wgwwebapp/pages/EventManagementPage.dart';
import 'package:wgwwebapp/pages/ManpowerPage.dart';
import 'package:wgwwebapp/pages/servicesconstruction.dart' as service;
import 'package:wgwwebapp/pages/ouroffices.dart' as office;
import 'package:wgwwebapp/pages/contactus.dart' as contact;
import 'package:wgwwebapp/pages/careers.dart' as careers;
import 'package:wgwwebapp/pages/QuoteRequest.dart' as quote;
import 'package:wgwwebapp/pages/logistics/home.dart' as homelog;
import 'package:wgwwebapp/pages/logistics/AboutUsPage.dart' as aboutlog;
import 'package:wgwwebapp/pages/logistics/projecthandling.dart' as projecthandling;
import 'package:wgwwebapp/pages/logistics/cargohandling.dart' as cargohandling;
import 'package:wgwwebapp/pages/logistics/packaging.dart' as packaging;
import 'package:wgwwebapp/pages/logistics/custom.dart' as custom;
import 'package:wgwwebapp/pages/logistics/warehouse.dart' as warehouse;
import 'package:wgwwebapp/pages/logistics/land.dart' as land;
import 'package:wgwwebapp/pages/logistics/air.dart' as air;
import 'package:wgwwebapp/pages/logistics/ocean.dart' as ocean;
import 'package:wgwwebapp/pages/logistics/service.dart' as servicelog;
import 'package:wgwwebapp/pages/logistics/contactus.dart' as contactus;
import 'package:wgwwebapp/pages/logistics/officeaddress.dart' as officeaddress;
import 'package:wgwwebapp/pages/logistics/quoterequest.dart' as quoterequest;


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
        builder: (context, state) => aboutcons.AboutUsPage(),
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
        path: '/logistics/home',
        builder: (context, state) => homelog.HomePage(),
      ),
          GoRoute(
        path: '/logistics/AboutUsPage',
        builder: (context, state) => aboutlog.AboutUsPage(),
      ),
      GoRoute(
        path: '/logistics/projecthandling',
        builder: (context, state) => projecthandling.ProjectHandlingPage(),
      ),
      GoRoute(
        path: '/logistics/cargohandling',
        builder: (context, state) => cargohandling.CargoHandlingPage(),
      ),
      GoRoute(
        path: '/logistics/packaging',
        builder: (context, state) => packaging.PackagingPage(),
      ),
      GoRoute(
        path: '/logistics/custom',
        builder: (context, state) => custom.CustomClearancePage(),
      ),
      GoRoute(
        path: '/logistics/warehouse',
        builder: (context, state) => warehouse.WarehouseFreightServicesPage(),
      ),
      GoRoute(
        path: '/logistics/land',
        builder: (context, state) => land.LandFreightPage(),
      ),
      GoRoute(
        path: '/logistics/air',
        builder: (context, state) => air.AirFreightPage(),
      ),
      GoRoute(
        path: '/logistics/ocean',
        builder: (context, state) => ocean.OceanFreightScreen(),
      ),
      GoRoute(
        path: '/logistics/service',
        builder: (context, state) => servicelog.ServicePageApp(),
      ),
      GoRoute(
        path: '/logistics/contactus',
        builder: (context, state) => contactus.ContactForm(),
      ),
      GoRoute(
        path: '/logistics/officeaddress',
        builder: (context, state) => officeaddress.OfficeAddressMenu(),
      ),
      GoRoute(
        path: '/logistics/quoterequest',
        builder: (context, state) => quoterequest.QuoteRequest(),
      ),
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
