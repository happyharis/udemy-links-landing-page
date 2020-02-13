import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonLink extends StatelessWidget {
  const ButtonLink({
    Key key,
    @required this.text,
    @required this.url,
  }) : super(key: key);

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          width: constraints.maxWidth > 768.0
              ? 768.0
              : constraints.maxWidth * 0.95,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FlatButton(
              color: Color.fromRGBO(57, 224, 155, 1),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () => launch(url),
            ),
          ),
        ),
      ),
    );
  }
}
