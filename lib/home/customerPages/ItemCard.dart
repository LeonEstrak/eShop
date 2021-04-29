import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopwork/home/customerPages/AddItemButton.dart';
import 'package:shopwork/shared/imageDownloader.dart';

class ItemCard extends StatefulWidget {
  final String itemName, itemPrice;
  final DocumentSnapshot documentSnapshot;
  ItemCard({Key key, this.itemName, this.itemPrice, this.documentSnapshot})
      : super(key: key);
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 100,
              clipBehavior: Clip.hardEdge,
              child: itemImageAsWidget(
                  itemName: widget.itemName,
                  uid: widget.documentSnapshot.documentID),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.black12),
            ),
          ),
          Expanded(
            child: Column(children: [
              SizedBox(height: 15),
              Text(
                widget.itemName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "₹ ${widget.itemPrice}",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              AddItemButton(
                itemName: widget.itemName,
                documentSnapshot: widget.documentSnapshot,
              ),
              SizedBox(height: 10),
            ]),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black26
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0)
          ]),
    );
  }
}
