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
  final formKey = GlobalKey<FormState>();
  String itemName, itemQty, itemPrice, errorMessage = ' ', uploadMessage = ' ';
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
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (selected != null) isImageAvailable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    /// This controller is used to scroll to when keyboard overlaps over the textField
    ScrollController _controller = ScrollController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        controller: _controller,
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
              height: 10,
            ),
            // errorMessage==" "? Text("$errorMessage",style: TextStyle(color: Colors.primaries[0]),): SizedBox(height: 0,),
            Text(
              "$errorMessage",
              style: TextStyle(color: Colors.primaries[0]),
            ),
            SizedBox(
              height: 10,
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
                    onTap: () {
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 10),
                          curve: Curves.easeOut);
                    },
                    validator: (value) => value.isEmpty ? "Enter Name" : null,
                    decoration:
                        InputDecoration(labelText: "Enter Name of Product"),
                    onChanged: (value) => itemName = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onTap: () {
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 10),
                          curve: Curves.easeOut);
                    },
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
                    onTap: () {
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 10),
                          curve: Curves.easeOut);
                    },
                    validator: (value) => value.isEmpty ? "Enter Price" : null,
                    decoration:
                        InputDecoration(labelText: "Enter Price of Product"),
                    onChanged: (value) => itemPrice = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(uploadMessage),
                  Center(
                    child: RaisedButton(
                        elevation: 7.0,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          if (!isImageAvailable) {
                            setState(() {
                              errorMessage = "Cannot Leave Image Blank";
                            });
                          }
                          if (formKey.currentState.validate() &&
                              isImageAvailable) {
                            setState(() {
                              /// Pressing the submit button uploads the photo and item info to database
                              DatabaseServices(uid: user.uid).uploadItemPhoto(
                                  itemName: itemName, image: image);
                              DatabaseServices(uid: user.uid)
                                  .merchantAddItemData(
                                      itemName: itemName,
                                      itemQty: itemQty,
                                      itemPrice: itemPrice);
                              uploadMessage =
                                  "Please Wait... Data being uploaded";
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
