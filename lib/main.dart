import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/Authentication.dart';
import 'package:shopwork/home.dart';
import 'package:shopwork/loginPage.dart';
import 'package:shopwork/registrationPage.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  const Application({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return StreamProvider.value(
      value: AuthenticationServices().user ,
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
