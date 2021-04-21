import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

class CustomerProfilePage extends StatefulWidget {
  static Image profileImage =
      Image.asset("lib/shared/addimage.png", fit: BoxFit.cover);
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  /// ### @input: ImageSource source, FirebaseUser user
  /// ### @output: Future<void>
  ///Choose an image either from the gallery or click one from the Camera depending on the ImageSourcce
  ///specified while function is called. FirebaseUser is required as parameter since DatabaseServices are
  ///being used and intialization of a DatabaseService instance requires the UID of user.
  Future pickImage(ImageSource source, FirebaseUser user) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      CustomerProfilePage.profileImage = Image.file(
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

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.5,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 50,
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
                  if (snapshot.hasData && snapshot.data[0]) {
                    CustomerProfilePage.profileImage =
                        Image.network(snapshot.data[1]);
                    return Container(
                      height: 150,
                      width: 150,
                      clipBehavior: Clip.hardEdge,
                      child: CustomerProfilePage.profileImage,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black12),
                    );
                  } else if ((snapshot.hasData && !snapshot.data[0]) ||
                      snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Container(
                      height: 150,
                      width: 150,
                      clipBehavior: Clip.hardEdge,
                      child: CustomerProfilePage.profileImage,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black12),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
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
            SizedBox(
              height: 25,
            ),
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
