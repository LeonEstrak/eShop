import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';

//TODO: Change profile name of every individual user. Add more profile options.

class MerchantPageProfile extends StatefulWidget {
  @override
  _MerchantPageProfileState createState() => _MerchantPageProfileState();
}

class _MerchantPageProfileState extends State<MerchantPageProfile> {

  File image ;
  bool isImageAvailable=false;
  String downloadURL;

  Future pickImage(ImageSource source,FirebaseUser user)async{
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      image = selected;
      Navigator.of(context, rootNavigator: true).pop('dialog');
      DatabaseServices(uid:user.uid).uploadImage(context: context,image: selected);
    });
  }

  Future getImage(FirebaseUser user)async{

    //returns an array where the 0th position is the actual link and second part is whether the link is valid or not
    dynamic url = await DatabaseServices(uid:user.uid).downloadImage();
    setState(() {
      downloadURL = url[0];
      isImageAvailable=url[1];
    });
  }

  @override
  Widget build(BuildContext context) {

    FirebaseUser user = Provider.of(context);

    getImage(user);

    return SafeArea(
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
              child: isImageAvailable ? Image.network(downloadURL) : Image.asset("lib/shared/One piece.png") ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black
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
    );
  }
}
