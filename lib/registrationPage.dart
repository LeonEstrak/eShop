import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String confirmedPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Confirm Password", border: OutlineInputBorder()),
              onChanged: (String confirmedPass){
                this.confirmedPassword = confirmedPass;
              },
            ),
          ),
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
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
