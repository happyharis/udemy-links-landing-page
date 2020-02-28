import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailTextController = TextEditingController();
    TextEditingController _passwordTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: Material(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: _emailTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTextController,
                      validator: (value) =>
                          value.isEmpty ? 'Please enter a password' : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/register'),
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        Spacer(),
                        FlatButton(
                          color: Colors.blueAccent,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              final email = _emailTextController.text;
                              final password = _passwordTextController.text;
                              final firebaseAuth = FirebaseAuth.instance;
                              firebaseAuth
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              )
                                  .then((_) {
                                Navigator.of(context).pushNamed('/settings');
                              }).catchError((error) =>
                                      showErrorDialog(context, error));
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
