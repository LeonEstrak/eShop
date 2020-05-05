import 'package:flutter/material.dart';
import 'package:shopwork/loginPage.dart';
import 'package:shopwork/registrationPage.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/LoginPage',
  routes: {
    '/LoginPage': (context) => LoginPage(),
    '/RegistrationPage': (context) => RegistrationPage()
  },
));

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
