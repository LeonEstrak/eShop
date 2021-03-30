import 'package:flutter/material.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/shared/constants.dart';

/// ### Registration Page
/// The TextFormFields are all wrapped with a single Form field idientified by a Global Form key.
/// If Registration is successful the Navigator is popped back to the Home where CheckAuthentication
/// widget runs and Stream value is used to login to the main app.
/// If unsuccessful then error is displayed in the screen using the [errorMessage] variable.

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String shopName,
      firstName,
      lastName,
      mobileNumber,
      address,
      email,
      password,
      confirmedPassword,
      typeOfUser;

  ///[errorMessage] is generally hidden since the Text is empty. But if data entered is deemed
  ///invalid from the Firebase then the error message is changed error is displayed.
  String errorMessage = ' ';

  final _formKey = GlobalKey<FormState>();

  InputDecoration myInputDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)));
  }

  Widget askShopName() {
    if (typeOfUser == Constant.merchant.toString())
      return TextFormField(
        validator: (shopName) =>
            shopName.isEmpty ? "Enter your Shop Name" : null,
        decoration: myInputDecoration("Shop Name"),
        onChanged: (String shopName) {
          this.shopName = shopName;
        },
      );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formKey,
          child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 35, 0.0, 0.0),
                child: Text(
                  'SignUp',
                  style: TextStyle(
                      fontSize: 65.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
              //   child: Text(
              //     "Become a Merchant",
              //     style: TextStyle(color: Colors.green),
              //   ),
              // ),
              SizedBox(
                height: 25,
              ),

              SizedBox(height: 15),
              TextFormField(
                validator: (firstName) =>
                    firstName.isEmpty ? "Enter your First Name" : null,
                decoration: myInputDecoration("First Name"),
                onChanged: (String firstName) {
                  this.firstName = firstName;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (lastName) =>
                    lastName.isEmpty ? "Enter your Last Name" : null,
                decoration: myInputDecoration("Last Name"),
                onChanged: (String lastName) {
                  this.lastName = lastName;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (mobileNumber) =>
                    mobileNumber.length != 10 ? "Invalid mobile number" : null,
                decoration: myInputDecoration("Mobile"),
                keyboardType: TextInputType.phone,
                onChanged: (String number) {
                  this.mobileNumber = number;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (address) =>
                    address.isEmpty ? "Enter your Address" : null,
                decoration: myInputDecoration("Address"),
                onChanged: (String address) {
                  this.address = address;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                //TODO:instead of isEmpty, check for validity of email [use Regular Exp.] [email.contains(new RegExp(r'...'))]
                validator: (email) =>
                    email.isEmpty ? "Enter your e-mail" : null,
                decoration: myInputDecoration("E-Mail"),
                onChanged: (String email) {
                  this.email = email;
                  //print("email: $email");
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  validator: (password) =>
                      password.length <= 4 ? "Password too small" : null,
                  obscureText: true,
                  decoration: myInputDecoration("Password"),
                  onChanged: (String password) {
                    this.password = password;
                    //print("Password: $password");
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (confirmedPassword) => confirmedPassword != password
                    ? "Passwords do not match"
                    : null,
                obscureText: true,
                decoration: myInputDecoration("Confirm Password"),
                onChanged: (String confirmedPass) {
                  this.confirmedPassword = confirmedPass;
                },
              ),
              SizedBox(
                height: 10,
              ),
              askShopName(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: Constant.customer.toString(),
                    groupValue: typeOfUser,
                    onChanged: (String value) {
                      setState(() {
                        typeOfUser = value;
                      });
                    },
                  ),
                  Text(Constant.customer.toString()),
                  Radio(
                    value: Constant.merchant.toString(),
                    groupValue: typeOfUser,
                    onChanged: (String value) {
                      setState(() {
                        typeOfUser = value;
                      });
                    },
                  ),
                  Text(Constant.merchant.toString())
                ],
              ),
              SizedBox(
                height: 100,
                //Buttons ROW
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Container(
                          height: 40,
                          child: RaisedButton(
                            elevation: 7.0,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Container(
                          height: 40,
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
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic data = await AuthenticationServices
                                    .registerWithEmailAndPassword(
                                        shopName: shopName,
                                        firstName: firstName,
                                        lastName: lastName,
                                        address: address,
                                        mobile: mobileNumber,
                                        email: email,
                                        password: password,
                                        typeOfUser: typeOfUser);
                                bool userExist = data[0];
                                dynamic userData = data[1];
                                if (userExist) {
                                  print(userData);
                                  print("Registered");
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$errorMessage",
                style: TextStyle(color: Colors.primaries[0]),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
