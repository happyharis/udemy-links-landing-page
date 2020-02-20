import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/landing_page.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/not_found_page.dart';
import 'package:links_landing_page/settings/page.dart';
import 'package:provider/provider.dart';

final dummyData = [
  {
    'title': 'Udemy',
    'url': 'https://www.udemy.com',
  },
  {
    'title': 'LinkedIn',
    'url': 'https://www.linkedin.com',
  },
  {
    'title': 'Facebook',
    'url': 'https://www.facebook.com',
  },
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final linksCollection = Firestore.instance.collection('links');
    final userLinks = linksCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Link.fromDocument(doc)).toList();
    });
    return MultiProvider(
      providers: [
        StreamProvider<List<Link>>(
          create: (_) => userLinks,
          initialData: [],
        ),
        Provider<CollectionReference>(create: (_) => linksCollection)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/settings': (context) => SettingsPage(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => NotFoundPage(
            routeName: settings.name,
          ),
        ),
      ),
    );
  }
}
