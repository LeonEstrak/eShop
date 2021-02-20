import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopwork/services/database.dart';

class AuthenticationServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //Stream which lets us know changes in condition of log of user
  static Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //Sign in using email and password
  static Future logInWithEmailAndPassword(String email, String password) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      // Sending an array with the first element being a boolean value while the rest being the resultant data
      return [true, result];
    } catch (e) {
      print(e.toString());
      return [false, e];
    }
  }

  //Register using email and password
  static Future registerWithEmailAndPassword(
      {String email,
      String password,
      String typeOfUser,
      String shopName,
      String firstName,
      String lastName,
      String mobile,
      String address}) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      DatabaseServices(uid: result.user.uid).registerUserData(
          shopName: shopName,
          typeOfUser: typeOfUser,
          address: address,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile);
      print(result);
      // Sending an array with the first element being a boolean value while the rest being the resultant data
      return [true, result];
    } catch (e) {
      print(e.toString());
      return [false, e];
    }
  }

  //Signing in anonymously
  static Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
