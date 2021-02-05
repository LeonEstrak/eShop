import 'package:flutter/material.dart';
import 'package:shopwork/Authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;

  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                //TODO:instead of isEmpty, check for validity of email [use Regular Exp.]
                validator: (email) => email.isEmpty ? "Enter your e-mail" : null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "E-Mail"),
                onChanged: (String email) {
                  this.email = email;
                  //print("email: $email");
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (password)=> password.length <= 4?"Password too snmall":null,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
                onChanged: (String password) {
                  this.password = password;
                  //print("Password: $password");
                }),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                //Buttons ROW
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: RaisedButton(
                          //LOGIN BUTTON
                          child: Text("Login"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              AuthenticationServices().signInAnonymous();
                              print("email: $email \nPassword: $password");
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: RaisedButton(
                          child: Text("Register"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/RegistrationPage');
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
