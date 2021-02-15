import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

//TODO: Change profile name of every individual user. Add more profile options.

class MerchantPageProfile extends StatefulWidget {
  static bool isProfileImageAvailable = false;
  static Image profileImage = Image.asset(
    "lib/shared/addimage.png",
    fit: BoxFit.cover,
  );

  @override
  _MerchantPageProfileState createState() => _MerchantPageProfileState();
}

class _MerchantPageProfileState extends State<MerchantPageProfile> {
  //~~~~~~~~~~~~~~~~~The Profile Pic related data/variables resides in the MerchantPageProfile class ~~~~~~~~~~~~~~~
  String downloadURL;

  /// ### @input: ImageSource source, FirebaseUser user
  /// ### @output: Future<void>
  ///Choose an image either from the gallery or click one from the Camera depending on the ImageSourcce
  ///specified while function is called. FirebaseUser is required as parameter since DatabaseServices are
  ///being used and intialization of a DatabaseService instance requires the UID of user.
  Future pickImage(ImageSource source, FirebaseUser user) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      MerchantPageProfile.profileImage = Image.file(
        selected,
        fit: BoxFit.cover,
      );
      Navigator.of(context, rootNavigator: true).pop('dialog');
      DatabaseServices(uid: user.uid).uploadProfilePhoto(image: selected);
    });
  }

  /// ### @input: FirebaseUser user
  /// ### @output: Future<void>
  /// Image is retrieved using the DatabaseServices instance from the Firebase Storage.
  /// Retrieved image is stored in the MerchantPageProfile static widget variable.
  Future getImage(FirebaseUser user) async {
    ///[url] is an array of type `[bool,String]`
    dynamic url = await DatabaseServices(uid: user.uid).downloadProfilePhoto();
    if (!mounted) return;
    setState(() {
      MerchantPageProfile.isProfileImageAvailable = url[0];
      downloadURL = url[1];
      if (MerchantPageProfile.isProfileImageAvailable)
        MerchantPageProfile.profileImage = Image.network(
          downloadURL,
          fit: BoxFit.cover,
        );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);

    if (!MerchantPageProfile.isProfileImageAvailable) getImage(user);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: Text("Change Profile Photo"),
                      elevation: 4,
                      actions: <Widget>[
                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~Image Picker~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        FlatButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.camera, user),
                            icon: Icon(Icons.camera_enhance),
                            label: Text("Camera")),
                        FlatButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.gallery, user),
                            icon: Icon(Icons.photo_library),
                            label: Text("Gallery"))
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 150,
                width: 150,
                clipBehavior: Clip.hardEdge,
                child: MerchantPageProfile.profileImage,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black12),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: DatabaseServices(uid: user.uid)
                  .getUserData(Constant.firstName),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return CircularProgressIndicator();
              },
            ),
            Divider(
              height: 50,
            ),
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
