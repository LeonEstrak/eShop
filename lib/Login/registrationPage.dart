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
  String firstName,
      lastName,
      mobileNumber,
      address,
      email,
      password,
      confirmedPassword,
      typeOfUser;

///[errorMessage] is generally hidden since the Text is empty. But if data entered is deemed 
///invalid from the Firebase then the error message is changed error is displayed.
  String errorMessage=' ';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5,),
              TextFormField(
                validator: (firstName) => firstName.isEmpty ? "Enter your First Name" : null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "First Name"),
                onChanged: (String firstName) {
                  this.firstName = firstName;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (lastName) => lastName.isEmpty ? "Enter your Last Name" : null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Last Name"),
                onChanged: (String lastName) {
                  this.lastName = lastName;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (mobileNumber) => mobileNumber.length!=10 ? "Invalid mobile number" : null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Mobile Number"),
                onChanged: (String number) {
                  this.mobileNumber = number;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (address) => address.isEmpty ? "Enter your Address" : null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Address"),
                onChanged: (String address) {
                  this.address = address;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                //TODO:instead of isEmpty, check for validity of email [use Regular Exp.] [email.contains(new RegExp(r'...'))]
              validator: (email) => email.isEmpty ? "Enter your e-mail" : null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "E-mail"),
              onChanged: (String email) {
                this.email = email;
                //print("email: $email");
              },
            ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (password)=> password.length <= 4?"Password too small":null,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
                onChanged: (String password) {
                  this.password = password;
                  //print("Password: $password");
                }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (confirmedPassword)=>confirmedPassword!=password?"Passwords do not match":null,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()
                ),
                onChanged: (String confirmedPass){
                  this.confirmedPassword = confirmedPass;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: Constant.customer.toString(),
                    groupValue: typeOfUser,
                    onChanged: (String value){setState(() {typeOfUser=value;});},
                  ), Text(Constant.customer.toString()),
                  Radio(
                    value: Constant.merchant.toString(),
                    groupValue: typeOfUser,
                    onChanged: (String value){setState(() {typeOfUser=value;});},
                  ),Text(Constant.merchant.toString())
                ],
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
                          child: Text("Back"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: RaisedButton(
                          child: Text("Register"),
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              dynamic data = await AuthenticationServices.registerWithEmailAndPassword(
                                  firstName: firstName,lastName: lastName,address: address,mobile: mobileNumber,email: email,password: password,typeOfUser: typeOfUser
                              );
                              bool userExist = data[0];
                              dynamic userData = data[1];
                              if(userExist) {
                                print(userData);
                                print("Registered");
                                setState(() {
                                  errorMessage = " ";
                                });
                                Navigator.popUntil(context, ModalRoute.withName('/'));
                              }else{
                                print("Error");
                                setState(() {
                                  print(userData);
                                  errorMessage = userData.toString().split(new RegExp(r','))[1];
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("$errorMessage",style: TextStyle(color: Colors.primaries[0]),),
            ],
          ),
        ),
      ),
    );
  }
}
