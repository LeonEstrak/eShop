import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/database.dart';

///TODO:Implement the EDIT button functionality

/// ### @input: String type: item_name, item_price, item_quantity
///When any card is tapped, this page is opened. It contains a brief info about
///the item. also contains a button allowing the user to edit the item info entered.
class ItemInfoCard extends StatefulWidget {
  final String name;
  final String qty;
  final String price;

  ItemInfoCard({this.name, this.qty, this.price, Key key}) : super(key: key);

  @override
  _ItemInfoCardState createState() =>
      _ItemInfoCardState(name: name, price: price, qty: qty);
}

class _ItemInfoCardState extends State<ItemInfoCard> {
  _ItemInfoCardState({this.name, this.qty, this.price});

  String name;
  String qty;
  String price;

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);

    dynamic result = DatabaseServices(uid: user.uid).downloadItemPhoto(name);

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Item Info",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                ///TODO:Wrap this container with a GestureDetector so when tapped, the image is viewed in fullscreen and also editable.
                Container(
                  child: FutureBuilder(
                    future: result,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data[0])
                          return Image.network(snapshot.data[1]);
                        else
                          return Image.asset(
                            "lib/shared/addimage.png",
                          );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0)
                      ]),
                ),
                SizedBox(height: 30),
                Text("Item Name: $name"),
                SizedBox(height: 15),
                Text("Item Price: Rs.$price"),
                SizedBox(height: 15),
                Text("Item Quantity: $qty units"),
                SizedBox(height: 15),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // TextButton.icon(
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //         context: context,
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.vertical(
                      //                 top: Radius.circular(30))),
                      //         builder: (context) => EditCard(
                      //           name: name,
                      //           price: price,
                      //           qty: qty,
                      //         ),
                      //       );
                      //     },
                      //     icon: Icon(Icons.edit),
                      //     label: Text("Edit")),
                      TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Delete"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              DatabaseServices(uid: user.uid)
                                                  .deleteItem(
                                                      itemName: name,
                                                      itemPrice: price,
                                                      itemQty: qty);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No"))
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete),
                          label: Text("Delete"))
                    ]),
              ],
            ),
          ),
        ),
        bottomSheet: BottomAppBar(
          elevation: 10,
          child: Container(
            // color: Colors.black12,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Center(
                child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 30,
              ),
            )),
          ),
        ));
  }
}
