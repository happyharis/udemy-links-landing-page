import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key key, this.isLogin}) : super(key: key);

  const AuthView.registerPage({
    Key key,
    this.isLogin = false,
  }) : super(key: key);

  const AuthView.loginPage({
    Key key,
    this.isLogin = true,
  }) : super(key: key);

  final isLogin;

  @override
  Widget build(BuildContext context) {
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
              child: AuthViewContainer(isLogin: isLogin),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthViewContainer extends StatelessWidget {
  const AuthViewContainer({
    Key key,
    this.isLogin,
  }) : super(key: key);

  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future authenticateUser(bool isLogin) {
      return isLogin
          ? firebaseEmailLogin(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController,
              context: context,
            )
          : firebaseEmailRegister(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController,
              context: context,
            );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            isLogin ? 'Welcome back!' : 'Welcome',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 25),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              } else
                return null;
            },
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Please enter a password' : null,
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Text(
                  isLogin ? 'Create account' : 'I have an account',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed(isLogin ? '/register' : '/login'),
              ),
              Spacer(),
              FlatButton(
                onPressed: () async => authenticateUser(isLogin),
                color: Colors.lightBlue,
                child: Text(
                  isLogin ? 'Login' : 'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future firebaseEmailLogin({
    @required GlobalKey<FormState> formKey,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required BuildContext context,
  }) async {
    if (formKey.currentState.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((authResult) {
        return Navigator.of(context).pushNamed('/settings');
      }).catchError((error) {
        showErrorDialog(context, error);
      });
    }
  }

  Future firebaseEmailRegister({
    @required GlobalKey<FormState> formKey,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required BuildContext context,
  }) async {
    if (formKey.currentState.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((authResult) {
        return Navigator.of(context).pushNamed('/settings');
      }).catchError((error) {
        showErrorDialog(context, error);
      });
    }
  }

  Future showErrorDialog(BuildContext context, error) {
    return showDialog(
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
            ),
          ],
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: SizedBox(
              child: Text(error.toString()),
              width: 400,
            ),
          ),
          SimpleDialogOption(
            child: FlatButton(
              color: Colors.redAccent,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Dismiss',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
