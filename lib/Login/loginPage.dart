import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';

/// ### Login Page
/// Form Widget is used to wrap the TextFormFields to validate the info that has been input using the validator key.
/// If "form-valid" email and password is used to log-in to the app. The app uses the navigator to pop to the root route,
/// i.e the [CheckAuthentication] Widget present in Home.dart file which checks the authorisation of the email and password
/// from the Firebase Authentication Server.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;

  String password;

  ///[errorMessage] is generally hidden since the Text is empty. But if data entered is deemed
  ///invalid from the Firebase then the error message is changed error is displayed.
  String errorMessage = " ";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcome"),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$errorMessage",
                  style: TextStyle(color: Colors.primaries[0]),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Center(
                      child: Text('eShop',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    )),
                SizedBox(height: 75),
                TextFormField(
                  //TODO:instead of isEmpty, check for validity of email [use Regular Exp.]
                  validator: (email) =>
                      email.isEmpty ? "Enter your e-mail" : null,
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  onChanged: (String email) {
                    this.email = email;
                    //print("email: $email");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    validator: (password) =>
                        password.isEmpty ? "Please enter your password" : null,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onChanged: (String password) {
                      this.password = password;
                      //print("Password: $password");
                    }),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  //Buttons ROW
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: RaisedButton(
                            //LOGIN BUTTON
                            elevation: 7.0,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic data = await AuthenticationServices
                                    .logInWithEmailAndPassword(email, password);
                                bool userExist = data[0];
                                dynamic userData = data[1];
                                if (userExist == true) {
                                  print(userData);
                                  print("Logged in");
                                  setState(() {
                                    errorMessage = " ";
                                  });
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                } else {
                                  print("Error");
                                  setState(() {
                                    print(userData);
                                    errorMessage = userData
                                        .toString()
                                        .split(new RegExp(r','))[1];
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: RaisedButton(
                            elevation: 7.0,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/RegistrationPage');
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
