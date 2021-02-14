import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/database.dart';

/// ### Add Card
/// Called when the floating action button of the Merchant Home is pressed. Used to enter
/// data for the new item that is to be added to the shop list of Merchant.
/// Form Field Validation and [isImageAvailable] is used to verify the availability of all
/// required data before uploading to the Firebase.
class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool isImageAvailable = false;
  String downloadURL;
  final formKey = GlobalKey<FormState>();
  String itemName, itemQty, itemPrice, errorMessage = ' ';
  File image;

  Image defaultImage = Image.asset(
    "lib/shared/addimage.png",
    fit: BoxFit.cover,
  );

  Future pickImage(
      ImageSource source, FirebaseUser user, String itemName) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      image = selected;
      if (selected != null) isImageAvailable = true;
    });
  }

  //Not needed right now here....
  Future getImage(FirebaseUser user) async {
    //returns an array where the 0th position is the actual link and second part is whether the link is valid or not
    dynamic url =
        await DatabaseServices(uid: user.uid).downloadItemPhoto(itemName);
    setState(() {
      isImageAvailable = url[0];
      downloadURL = url[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Add Item",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // errorMessage==" "? Text("$errorMessage",style: TextStyle(color: Colors.primaries[0]),): SizedBox(height: 0,),
            Text(
              "$errorMessage",
              style: TextStyle(color: Colors.primaries[0]),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: Text("Change Item Photo"),
                      elevation: 4,
                      actions: <Widget>[
                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~Image Picker~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        FlatButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.camera, user, itemName),
                            icon: Icon(Icons.camera_enhance),
                            label: Text("Camera")),
                        FlatButton.icon(
                            onPressed: () =>
                                pickImage(ImageSource.gallery, user, itemName),
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
                child: image != null
                    ? Image.file(
                        image,
                        fit: BoxFit.cover,
                      )
                    : defaultImage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black12,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) => value.isEmpty ? "Enter Name" : null,
                    decoration:
                        InputDecoration(labelText: "Enter Name of Product"),
                    onChanged: (value) => itemName = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "Enter Quantity" : null,
                    decoration:
                        InputDecoration(labelText: "Enter Quantity of Product"),
                    onChanged: (value) => itemQty = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value.isEmpty ? "Enter Price" : null,
                    decoration:
                        InputDecoration(labelText: "Enter Price of Product"),
                    onChanged: (value) => itemPrice = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if (!isImageAvailable) {
                            setState(() {
                              errorMessage = "Cannot Leave Image Blank";
                            });
                          }
                          if (formKey.currentState.validate() &&
                              isImageAvailable) {
                            //TODO: Data of the item to be saved in the database(JSON). Only image is being stored right now.
                            setState(() {
                              DatabaseServices(uid: user.uid).uploadItemPhoto(
                                  itemName: itemName, image: image);
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                          }
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
