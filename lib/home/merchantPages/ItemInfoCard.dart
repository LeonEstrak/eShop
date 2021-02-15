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
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    label: Text("Edit")),
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("Back"))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
