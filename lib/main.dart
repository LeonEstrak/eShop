///
/// ### Main file
/// The app is initially divided into two parts, the first part being the Login/Register Screen,
/// second part being the main app. 
/// When the app is started, a Stream is used to check whether the app is able to establish a 
/// secure connection with the firebase authenticator. The stream outputs the user info if the 
/// connection is established, using which the main app is booted, loading all the user info 
/// from the cloud database.
/// 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/Login/loginPage.dart';
import 'package:shopwork/home/merchantPages/AddCard.dart';
import 'package:shopwork/home/merchantPages/ItemInfoCard.dart';
import 'package:shopwork/services/Authentication.dart';
import 'Login/registrationPage.dart';
import 'home/home.dart';

//TODO: Create a loading screen

void main() => runApp(Application());

class Application extends StatelessWidget {
  const Application({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
/// StreamProvider.value allows the FirebaseUser variable info to be carried down the Widget 
/// tree to be used wherever needed after the given point. Since this is the beginning of the
/// Widget tree, the user data can be used anywhere in the app.
    return StreamProvider.value(
      value: AuthenticationServices.user,
      child: MaterialApp(
//        theme: ThemeData(brightness: Brightness.dark),
        initialRoute: '/',
        routes: {
          '/': (context) => CheckAuthentication(),
          '/AddCard': (context) => AddCard(),
          '/ItemInfoCard':(context)=> ItemInfoCard(),
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
/// Using the stream property of Firebase, we check whether a user is logged in or not.
/// If logged in, redirect to Home Screen else redirect to the login page.
    if (user != null)
      return Home();
    else
      return LoginPage();
  }
}