import 'package:flutter/material.dart';
import 'package:links_landing_page/button_link.dart';
import 'package:links_landing_page/models/links.dart';
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
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: boxDecoration,
        child: Column(
          children: <Widget>[
            SizedBox(height: 35),
            Image.network(
              'https://i.ibb.co/LnFqnFs/profilepic2.png',
              height: 96,
              width: 96,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '@thehappyharis',
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
