import 'package:flutter/material.dart';
import 'package:links_landing_page/landing_page.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/not_found_page.dart';
import 'package:links_landing_page/settings/page.dart';
import 'package:provider/provider.dart';

final dummyData = [
  {'title': 'Udemy', 'url': 'https://www.udemy.com', 'position': 1},
  {'title': 'LinkedIn', 'url': 'https://www.linkedin.com', 'position': 2},
  {'title': 'Facebook', 'url': 'https://www.facebook.com', 'position': 3},
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userLinks = dummyData.map((data) => Link.fromMap(data)).toList();
    return Provider<List<Link>>(
      create: (_) => userLinks,
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
