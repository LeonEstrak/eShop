import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Customer Home"),
            RaisedButton(
              onPressed: () {
                AuthenticationServices.signOut();
              },
              child: Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}
