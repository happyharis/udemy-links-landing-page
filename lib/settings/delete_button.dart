import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Link data;

  @override
  Widget build(BuildContext context) {
    final linksCollection = Provider.of<CollectionReference>(context);
    void _showDeleteDialog() {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Are you sure you want to delete ${data.title} Link?'),
          content: Text('Deleted links are not retrievable.'),
          actions: <Widget>[
            FlatButton(
              color: Colors.redAccent,
              onPressed: () {
                linksCollection.document(data.documentID).delete();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            )
          ],
        ),
      );
    }

    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: _showDeleteDialog,
    );
  }
}
