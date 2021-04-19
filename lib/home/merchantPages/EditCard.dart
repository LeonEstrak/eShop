import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/database.dart';

class EditCard extends StatefulWidget {
  final String name;
  final String qty;
  final String price;
  EditCard({this.name, this.qty, this.price, Key key}) : super(key: key);

  @override
  _EditCardState createState() =>
      _EditCardState(itemName: name, itemPrice: price, itemQty: qty);
}

class _EditCardState extends State<EditCard> {
  _EditCardState({this.itemName, this.itemQty, this.itemPrice}) {
    originalItemName = this.itemName;
  }
  String originalItemName, itemName, itemPrice, itemQty;

  final formKey = GlobalKey<FormState>();

  ///TODO:Change the itemPhoto name in firebase storage when the item data is edited.

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    ScrollController _controller = ScrollController();

    return Container(
        height: MediaQuery.of(context).size.height * 0.5 +
            MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Edit Item",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        initialValue: "$itemName",
                        onTap: () {
                          _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(milliseconds: 10),
                              curve: Curves.easeOut);
                        },
                        validator: (value) =>
                            value.isEmpty ? "Enter Name" : null,
                        decoration:
                            InputDecoration(labelText: "Enter Name of Product"),
                        onChanged: (value) => itemName = value,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextFormField(
                        initialValue: itemQty,
                        onTap: () {
                          _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(milliseconds: 10),
                              curve: Curves.easeOut);
                        },
                        validator: (value) =>
                            value.isEmpty ? "Enter Quantity" : null,
                        decoration: InputDecoration(
                            labelText: "Enter Quantity of Product"),
                        onChanged: (value) => itemQty = value,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextFormField(
                        initialValue: itemPrice,
                        onTap: () {
                          _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(milliseconds: 10),
                              curve: Curves.easeOut);
                        },
                        validator: (value) =>
                            value.isEmpty ? "Enter Price" : null,
                        decoration: InputDecoration(
                            labelText: "Enter Price of Product"),
                        onChanged: (value) => itemPrice = value,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Center(
                        child: ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  DatabaseServices(uid: user.uid).editItem(
                                      currentItemName: originalItemName,
                                      modifiedItemName: itemName,
                                      modifiedItemQty: itemQty,
                                      modifiedItemPrice: itemPrice);
                                  // dynamic imageData =
                                  //     DatabaseServices(uid: user.uid)
                                  //         .downloadItemPhoto(originalItemName);
                                  // Image image = Image.network(imageData[1]);
                                  // DatabaseServices(uid: user.uid)
                                  //     .uploadItemPhoto(
                                  //         itemName: itemName, image: image);
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
            )));
  }
}
