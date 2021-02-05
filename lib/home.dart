import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopwork/Authentication.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("This is the Home Page !!"),
            FlatButton.icon(onPressed: (){AuthenticationServices().signOut();}, icon: Icon(Icons.account_box), label: Text("Logout"))
          ],
        ),
      ),

    );
  }
}
