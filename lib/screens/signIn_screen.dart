import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel_test/utils/auth.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'lolo@gmail.com';
    _passwordController.text = '123456';
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  validator: (value) => value.isEmpty ? 'Enter email!' : null,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) =>
                      value.isEmpty ? 'Enter password!' : null,
                ),
                SizedBox(
                  height: 5,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    child: Text(
                      'SignIn',
                      style: TextStyle(color: Colors.white),
                    ),
                    minWidth: double.infinity,
                    color: Colors.blue,
                    onPressed: () {
                      Map creds = {
                        'email': _emailController.text,
                        'password': _passwordController.text,
                        'device': 'mobile',
                      };
                      if (_formKey.currentState.validate()) {
                        Provider.of<Auth>(context, listen: false)
                            .signIn(creds: creds);
                        Navigator.pop(context);
                      }
                    })
              ],
            )),
      ),
    );
  }
}
