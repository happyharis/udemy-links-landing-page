import 'package:flutter/material.dart';
import 'package:links_landing_page/settings/button_settings.dart';
import 'package:links_landing_page/settings/phone_preview.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          ButtonSettings(),
          PhonePreview(),
        ],
      ),
    );
  }
}
