import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Material(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: RegisterContainer(),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterContainer extends StatelessWidget {
  const RegisterContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 32),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'I have an account',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () => Navigator.of(context).pushNamed('/login'),
              ),
              Spacer(),
              FlatButton(
                onPressed: () => Navigator.of(context).pushNamed('/settings'),
                color: Colors.lightBlue,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
