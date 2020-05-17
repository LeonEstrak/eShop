import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

class MerchantPageProfile extends StatefulWidget {
  @override
  _MerchantPageProfileState createState() => _MerchantPageProfileState();
}

class _MerchantPageProfileState extends State<MerchantPageProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Profile"),
            FlatButton.icon(
                onPressed: () {
                  AuthenticationServices.signOut();
                },
                icon: Icon(Icons.person_outline),
                label: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
