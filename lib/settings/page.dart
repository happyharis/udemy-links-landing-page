import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/login_page.dart';
import 'package:links_landing_page/settings/button_settings.dart';
import 'package:links_landing_page/settings/phone_preview.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Spacer(),
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) =>
                      Navigator.of(context).popAndPushNamed('/login'))
                  .catchError((error) => showErrorDialog(context, error));
            },
          )
        ],
      ),
      body: Row(
        children: <Widget>[
          ButtonSettings(),
          PhonePreview(),
        ],
      ),
    );
  }
}
