import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, error) {
  showDialog(
      context: context,
      child: SimpleDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
            SizedBox(width: 10),
            Text(
              'Oh snap!',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: SizedBox(width: 400, child: Text(error.message)),
          ),
          SimpleDialogOption(
            child: FlatButton(
              child: Text(
                'Dismiss',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: Navigator.of(context).pop,
              color: Colors.redAccent,
            ),
          )
        ],
      ));
}
