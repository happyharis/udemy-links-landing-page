import 'dart:html';

import 'package:flutter/material.dart';
import 'package:links_landing_page/button_link.dart';
import 'package:links_landing_page/helpers/upload.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/models/users.dart';
import 'package:provider/provider.dart';

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
            ProfilePicture(user: user),
            UpdatePictureButton(),
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
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: 96,
      child: StreamBuilder<Uri>(
          stream: getUrl(user),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Image.network(
              snapshot.data.toString(),
              height: 96,
              width: 96,
            );
          }),
    );
  }
}

class UpdatePictureButton extends StatefulWidget {
  const UpdatePictureButton({
    Key key,
  }) : super(key: key);

  @override
  _UpdatePictureButtonState createState() => _UpdatePictureButtonState();
}

class _UpdatePictureButtonState extends State<UpdatePictureButton> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<User>(context).id;

    return Tooltip(
      message: 'Update Profile Picture',
      child: OutlineButton(
        borderSide: BorderSide(width: 2),
        child: Text('Update Profile Picture'),
        onPressed: () {
          uploadImage(onSelected: (file) => uploadToFirebase(file, userId));
        },
      ),
    );
  }
}
