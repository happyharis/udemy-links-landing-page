import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/helpers/firestore_service.dart';
import 'package:links_landing_page/login_page.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/models/users.dart';
import 'package:links_landing_page/not_found_page.dart';
import 'package:links_landing_page/register_page.dart';
import 'package:links_landing_page/settings/page.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>(
          create: (_) => FirebaseAuth.instance.onAuthStateChanged,
          initialData: null,
        ),
        ProxyProvider<FirebaseUser, CollectionReference>(update: (_, user, __) {
          return linksCollection(user?.uid);
        }),
        ProxyProvider<FirebaseUser, Stream<List<Link>>>(update: (_, user, __) {
          return userLinksCollection(linksCollection(user?.uid));
        }),
        ProxyProvider<FirebaseUser, Stream<User>>(update: (_, user, __) {
          return userData(user?.uid);
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) {
          print(settings.name);
          return MaterialPageRoute(
            builder: (context) => AuthWidget(settingsName: settings.name),
          );
        },
      ),
    );
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.settingsName}) : super(key: key);

  final String settingsName;

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<FirebaseUser>(context) != null;
    final notLoggedInUserGoToSettings =
        settingsName == '/settings' && !isUserLoggedIn;
    final notLoggedInUserGoToLogin =
        settingsName == '/login' && !isUserLoggedIn;
    final notLoggedInUserGoToRegister =
        settingsName == '/register' && !isUserLoggedIn;

    if (settingsName == '/') {
      return LoginPage();
    } else if (isUserLoggedIn) {
      return SettingsPage();
    } else if (notLoggedInUserGoToLogin || notLoggedInUserGoToSettings) {
      return LoginPage();
    } else if (notLoggedInUserGoToRegister) {
      return RegisterPage();
    } else {
      return NotFoundPage(routeName: settingsName);
    }
  }
}
