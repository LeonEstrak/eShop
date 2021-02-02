import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
              controller: TextEditingController(),
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Username"),
            ),
            SizedBox(height: 10,),
            TextField(
              obscureText: true,
              controller: TextEditingController(),
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),
            )
          ],
        ),
      ),
    );
  }
}
