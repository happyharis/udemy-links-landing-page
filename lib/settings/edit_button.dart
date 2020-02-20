import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
    this.data,
  }) : super(key: key);

  final Link data;

  @override
  Widget build(BuildContext context) {
    TextEditingController _urlTextController = TextEditingController(
      text: data.url,
    );
    TextEditingController _titleTextController = TextEditingController(
      text: data.title,
    );
    final linksCollection = Provider.of<CollectionReference>(context);
    final _formKey = GlobalKey<FormState>();

    _displayEditDialog() async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Link'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a title' : null,
                    controller: _titleTextController,
                    decoration: InputDecoration(
                      hintText: "Facebook",
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a url' : null,
                    controller: _urlTextController,
                    decoration: InputDecoration(
                      hintText: "https://facebook.com",
                      labelText: 'URL',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                color: Colors.blueAccent,
                onPressed: () {
                  final userChangedTitle =
                      data.title != _titleTextController.text;
                  final userChangedUrl = data.url != _urlTextController.text;
                  final userUpdateForm = userChangedTitle || userChangedUrl;

                  if (_formKey.currentState.validate()) {
                    if (userUpdateForm) {
                      // If user updates the form field, send a update request to firebase
                      final newLink = Link(
                        title: _titleTextController.text,
                        url: _urlTextController.text,
                      );
                      linksCollection
                          .document(data.documentID)
                          .updateData(newLink.toMap());
                    } // Else, it closes the dialog without sending a request
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: _displayEditDialog,
    );
  }
}
