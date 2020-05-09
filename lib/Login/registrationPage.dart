import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/shared/constants.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email;

  String password;

  String confirmedPassword;

  String errorMessage=' ';

  String typeOfUser;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
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
                //TODO:instead of isEmpty, check for validity of email [use Regular Exp.] [email.contains(new RegExp(r'...'))]
              validator: (email) => email.isEmpty ? "Enter your e-mail" : null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "E-mail"),
              onChanged: (String email) {
                this.email = email;
                //print("email: $email");
              },
            ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (password)=> password.length <= 4?"Password too small":null,
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
              TextFormField(
                validator: (confirmedPassword)=>confirmedPassword!=password?"Passwords do not match":null,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()
                ),
                onChanged: (String confirmedPass){
                  this.confirmedPassword = confirmedPass;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: Constant().customer,
                    groupValue: typeOfUser,
                    onChanged: (String value){setState(() {typeOfUser=value;});},
                  ), Text(Constant().customer),
                  Radio(
                    value: Constant().merchant,
                    groupValue: typeOfUser,
                    onChanged: (String value){setState(() {typeOfUser=value;});},
                  ),Text(Constant().merchant)
                ],
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
                          child: Text("Back"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: RaisedButton(
                          child: Text("Register"),
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              dynamic data = await AuthenticationServices().registerWithEmailAndPassword(email, password,typeOfUser);
                              bool userExist = data[0];
                              dynamic userData = data[1];
                              if( userExist== true) {
                                print(userData);
                                print("Registered");
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
