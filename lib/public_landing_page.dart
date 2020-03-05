import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/helpers/firestore_service.dart';
import 'package:links_landing_page/landing_page.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/models/users.dart';
import 'package:provider/provider.dart';

class PublicLandingPage extends StatelessWidget {
  const PublicLandingPage({Key key, this.routeName}) : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final parsedName = routeName.substring(1);
    return FutureBuilder<String>(
      future: userId(parsedName),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final uid = snapshot.data;

        if (uid.isEmpty) {
          return Material(
            child: Center(child: Text('$parsedName not found')),
          );
        }
        return MultiProvider(
          providers: [
            StreamProvider<User>(
              create: (_) => userData(uid),
              initialData: User.empty(),
            ),
            StreamProvider<List<Link>>(
              create: (_) => userLinksCollection(linksCollection(uid)),
              initialData: [],
            ),
          ],
          child: LandingPage.public(),
        );
      },
    );
  }
}

Future<String> userId(String parsedName) async {
  final userSnapshot = await Firestore.instance
      .collection('users')
      .where('name_path', isEqualTo: parsedName)
      .limit(1)
      .getDocuments();

  if (userSnapshot.documents.isEmpty) return '';

  return userSnapshot.documents.first.documentID;
}

// 1. user type in /haris
// 2. search the word 'haris' firestore database
// 3a. if found, return UserId. and make use of the uid
//     to return user data and links
// 3b. if not found, return a page that say user not found
