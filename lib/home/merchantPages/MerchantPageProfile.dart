import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

class MerchantPageProfile extends StatefulWidget {
  @override
  _MerchantPageProfileState createState() => _MerchantPageProfileState();
}

class _MerchantPageProfileState extends State<MerchantPageProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20,),
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 25,),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage("lib/shared/One piece.png"),
                fit: BoxFit.cover
              )
            ),
          ),
          FlatButton.icon(
              onPressed: () {
                AuthenticationServices.signOut();
              },
              icon: Icon(Icons.person_outline),
              label: Text("Logout"))
        ],
      ),
    );
  }
}
