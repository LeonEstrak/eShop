import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/home.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';

//TODO: Change profile name of every individual user. Add more profile options.

class MerchantPageProfile extends StatefulWidget {
  @override
  _MerchantPageProfileState createState() => _MerchantPageProfileState();
}

class _MerchantPageProfileState extends State<MerchantPageProfile> {

  //~~~~~~~~~~~~~~~~~All the Profile Pic related data resides in the HOME widget ~~~~~~~~~~~~~~~
//  File image;
//  Image profileImage = Image.asset("lib/shared/addimage.png",fit: BoxFit.cover,);
//  bool isImageAvailable=false;
  String downloadURL;

  Future pickImage(ImageSource source,FirebaseUser user)async{
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      Home.profileImage = Image.file(selected,fit: BoxFit.cover,);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      DatabaseServices(uid:user.uid).uploadProfilePhoto(image: selected);
    });
  }

  Future getImage(FirebaseUser user)async{
    //returns an array where the 0th position is the actual link and second part is whether the link is valid or not
    dynamic url = await DatabaseServices(uid:user.uid).downloadProfilePhoto();
    setState(() {
      Home.isProfileImageAvailable=url[0];
      downloadURL = url[1];
      if(Home.isProfileImageAvailable)
        Home.profileImage = Image.network(downloadURL,fit: BoxFit.cover,);
    });
  }

  @override
  Widget build(BuildContext context) {

    FirebaseUser user = Provider.of(context);

    if(!Home.isProfileImageAvailable)
      getImage(user);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 25,),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        title: Text("Change Profile Photo"),
                        elevation: 4,
                        actions: <Widget>[
                          //~~~~~~~~~~~~~~~~~~~~~~~~~~~~Image Picker~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          FlatButton.icon(onPressed: ()=>pickImage(ImageSource.camera,user), icon: Icon(Icons.camera_enhance), label: Text("Camera")),
                          FlatButton.icon(onPressed: ()=>pickImage(ImageSource.gallery,user), icon: Icon(Icons.photo_library), label: Text("Gallery"))
                        ],
                      );
                    },
                );
              },
              child: Container(
                height:150,
                width: 150,
                clipBehavior: Clip.hardEdge,
                child: Home.profileImage ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black12
                ),
              ),
            ),
            SizedBox(height: 25,),
            Text(
                "Aniket Chakraborty",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Divider(height: 50,),
            FlatButton.icon(
                onPressed: () {
                  AuthenticationServices.signOut();
                },
                icon: Icon(Icons.person_outline),
                label: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
