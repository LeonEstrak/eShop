import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;

  String password;

  String errorMessage=" ";

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
              Text("$errorMessage"),
              SizedBox(height: 15),
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
                validator: (password)=> password.isEmpty?"Please enter your password":null,
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
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              dynamic data = await AuthenticationServices().logInWithEmailAndPassword(email, password);
                              bool userExist = data[0];
                              dynamic userData = data[1];
                              if( userExist== true) {
                                print(userData);
                                print("Logged in");
                                setState(() {
                                  errorMessage = " ";
                                });
                                Navigator.popUntil(context, ModalRoute.withName('/'));
                              }else{
                                print("Error");
                                setState(() {
                                  print(userData);
                                  errorMessage = userData.toString().split(new RegExp(r','))[1];
                                });
                              }
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
