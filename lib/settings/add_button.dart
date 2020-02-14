import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    this.width,
  }) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.greenAccent.shade400,
        onPressed: () {},
        child: Text(
          'Add Button',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
