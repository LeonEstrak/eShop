import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    final userType = DatabaseServices(uid: user.uid).getTypeOfUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("This is the Home Page !!"),
            FutureBuilder(
              future: userType,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  String result = snapshot.data.toString();
                  return Text("$result");
                }else if (snapshot.hasError){
                  String result = snapshot.error.toString();
                  return Text(result);
                }
                return CircularProgressIndicator();
              },
            ),
            FlatButton.icon(onPressed: (){AuthenticationServices().signOut();}, icon: Icon(Icons.account_box), label: Text("Logout"))
          ],
        ),
      ),

    );
  }
}
