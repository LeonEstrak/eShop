import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _myTextController = TextEditingController();

  String username;

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Username"),
              onSubmitted: (String username){
                this.username = username;
                print("Username: $username");
              },
            ),
            SizedBox(height: 10,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),
              onSubmitted: (String password){
                this.password = password;
                print("Password: $password");
              }
            ),
            SizedBox(height: 10,),
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
                        child: Text("Login"),
                        onPressed: (){
                          print("Username: $username \nPassword: $password");
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: RaisedButton(
                        child: Text("Register"),
                        onPressed: (){
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
    );
  }
}
