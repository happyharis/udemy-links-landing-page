import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/button_link.dart';
import 'package:links_landing_page/helpers/upload.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/models/users.dart';
import 'package:provider/provider.dart';
import 'package:firebase/firebase.dart' as fb;

class LandingPage extends StatelessWidget {
  LandingPage({
    Key key,
    this.boxDecoration,
  }) : super(key: key);
  final Decoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    final userLinks = Provider.of<List<Link>>(context);
    final user = Provider.of<User>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: boxDecoration,
        child: Column(
          children: <Widget>[
            SizedBox(height: 35),
            ProfilePicture(),
            OutlineButton(
              borderSide: BorderSide(width: 2),
              child: Text('Update Profile Picture'),
              onPressed: () {
                return uploadImage(onSelected: (file) {
                  final userId = user.id;
                  final dateTime = DateTime.now();
                  final path = 'user_profiles/$userId-$dateTime';
                  fb
                      .storage()
                      .refFromURL('gs://links-landing-page.appspot.com')
                      .child(path)
                      .put(file);
                  if (user.profilePicture != null) {
                    fb
                        .storage()
                        .refFromURL('gs://links-landing-page.appspot.com')
                        .child(user.profilePicture)
                        .delete();
                  }
                  Firestore.instance.document('users/$userId').setData(
                      {'profile_picture': path},
                      merge: true).catchError(print);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                user.name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            for (var data in userLinks)
              ButtonLink(text: data.title, url: data.url),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Built in Flutter',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),
                SizedBox(width: 8),
                Image.network(
                  'https://www.didierboelens.com/images/hummingbird_logo.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            SizedBox(height: 23),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SizedBox(
      height: 96,
      width: 96,
      child: user.profilePicture == null
          ? Icon(Icons.people, size: 96)
          : StreamBuilder<Uri>(
              stream: Stream.fromFuture(buildDownloadURL(user)),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Image.network(
                  snapshot?.data?.toString(),
                  height: 96,
                  width: 96,
                );
              }),
    );
  }

  Future<Uri> buildDownloadURL(User user) {
    return fb
        .storage()
        .refFromURL('gs://links-landing-page.appspot.com')
        .child(user.profilePicture)
        .getDownloadURL();
  }
}
