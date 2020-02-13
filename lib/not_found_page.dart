import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key key, this.routeName}) : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final parsedName = routeName.substring(1);
    return Scaffold(
      body: Center(
        child: Text('$parsedName page not found'),
      ),
    );
  }
}
