import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/Login/loginPage.dart';
import 'package:shopwork/services/Authentication.dart';
import 'Login/registrationPage.dart';
import 'home/home.dart';

//TODO: Create a loading screen
//TODO: Update the data base as soon as registration hits, name, mobile, address etc.
//TODO: Create a proper Registration Form.

void main() => runApp(Application());

class Application extends StatelessWidget {
  const Application({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      //This streamProvider.value is carried down to the whole widget tree and can be used wherever needed
      value: AuthenticationServices().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => CheckAuthentication(),
          '/LoginPage': (context) => LoginPage(),
          '/RegistrationPage': (context) => RegistrationPage()
        },
      ),
    );
  }
}

class CheckAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    //Using the stream property of Firebase, we check whether a user is logged in or not.
    //if logged in, redirect to Home Screen else redirect to LoginPage()
    if (user != null)
      return Home();
    else
      return LoginPage();
  }
}

//
//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Who are you ?"),
//      ),
//      body: Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Expanded(
//              child: Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: RaisedButton.icon(
//                  icon: Icon(Icons.person),
//                  onPressed: (){},
//                  label: Text("Customer"),
//                ),
//              ),
//            ),
//            Expanded(
//              child: Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: RaisedButton.icon(
//                  icon: Icon(Icons.shopping_cart),
//                  onPressed: (){},
//                  label: Text("Merchant"),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
