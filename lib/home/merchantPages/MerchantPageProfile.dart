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

//TODO: Add more profile options.

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
      if (selected != null)
        MerchantPageProfile.profileImage = Image.file(
          selected,
          fit: BoxFit.cover,
        );
      Navigator.of(context, rootNavigator: true).pop('dialog');
      DatabaseServices(uid: user.uid).uploadProfilePhoto(image: selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
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
                        TextButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.camera, user),
                            icon: Icon(Icons.camera_enhance),
                            label: Text("Camera")),
                        TextButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.gallery, user),
                            icon: Icon(Icons.photo_library),
                            label: Text("Gallery"))
                      ],
                    );
                  },
                );
              },
              child: FutureBuilder(
                future: DatabaseServices(uid: user.uid).getProfilePhotoURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data[0])
                      return Container(
                        height: 150,
                        width: 150,
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(snapshot.data[1]),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black12),
                      );
                  }
                  return Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.hardEdge,
                    child: MerchantPageProfile.profileImage,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black12),
                  );
                },
              ),
              // child: Container(
              //   height: 150,
              //   width: 150,
              //   clipBehavior: Clip.hardEdge,
              //   child: MerchantPageProfile.profileImage,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       color: Colors.black12),
              // ),
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
            TextButton.icon(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      String shopName;
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                            height: 300,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder(
                                    future: DatabaseServices(uid: user.uid)
                                        .shopName,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          children: <Widget>[
                                            Text(
                                              "Current Shop Name:",
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              " ${snapshot.data}",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 30),
                                            )
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Shop Name: ${snapshot.error}");
                                      }
                                      return CircularProgressIndicator();
                                    }),
                                SizedBox(height: 30),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: "Enter New Shop Name",
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  onChanged: (value) {
                                    shopName = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  onPressed: () {
                                    if (shopName == null ||
                                        shopName.length == 0) return;
                                    DatabaseServices(uid: user.uid)
                                        .setShopName(shopName);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Submit"),
                                )
                              ],
                            )),
                      );
                    }),
                icon: Icon(Icons.shopping_basket),
                label: Text("Shop Name")),
            TextButton.icon(
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
