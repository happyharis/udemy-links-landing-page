import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/auth_view.dart';
import 'package:links_landing_page/landing_page.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/not_found_page.dart';
import 'package:links_landing_page/settings/settings_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final linksCollection =
        Firestore.instance.collection('/users/238GuGJSFwE6Ad06AGuA/links');
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
        initialRoute: '/login',
        routes: {
          '/': (context) => LandingPage(),
          '/settings': (context) => SettingsPage(),
          '/login': (context) => AuthView.loginPage(),
          '/register': (context) => AuthView.registerPage(),
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
