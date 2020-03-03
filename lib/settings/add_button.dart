import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    TextEditingController _urlTextController = TextEditingController();
    TextEditingController _titleTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final linksCollection = Provider.of<CollectionReference>(context);

    _displayAddDialog() async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Link'),
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
                child: Text('Insert'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final newLink = Link(
                      title: _titleTextController.text,
                      url: _urlTextController.text,
                    );
                    linksCollection.add(newLink.toMap());
                    linksCollection.where('title', isEqualTo: 'Youtube');
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return SizedBox(
      width: width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.greenAccent.shade400,
        onPressed: _displayAddDialog,
        child: Text(
          'Add Button',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
