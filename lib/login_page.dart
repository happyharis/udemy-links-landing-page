import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/helpers/errors.dart';
import 'package:links_landing_page/helpers/validators.dart';

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
                      validator: validateEmail,
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
