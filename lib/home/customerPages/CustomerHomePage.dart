import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  IconButton(
                      icon: Icon(Icons.menu),
                      // color: Colors.green,
                      onPressed: () => Scaffold.of(context).openDrawer()),
                  Center(
                    // heightFactor: 1,
                    child: Text(
                      "Shops",
                      style: TextStyle(
                        fontSize: 40,
                        // color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  AuthenticationServices.signOut();
                },
                child: Text("Log Out"),
              )
            ])));
  }
}
