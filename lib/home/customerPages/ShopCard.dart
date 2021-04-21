import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopwork/home/customerPages/CustomerItemsPage.dart';
import 'package:shopwork/shared/constants.dart';
import 'package:shopwork/shared/imageDownloader.dart';

class ShopCard extends StatelessWidget {
  //TODO: Add Profile Photo from DB
  final DocumentSnapshot documentSnapshot;
  const ShopCard({this.documentSnapshot, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerItemsPage(
                      documentSnapshot: documentSnapshot,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.hardEdge,
                child: profilePhotoAsWidget(uid: documentSnapshot.documentID),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.black12),
              ),
            ),
            Expanded(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      documentSnapshot.data[Constant.shopName.toString()],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 15),
                    Text(
                      documentSnapshot.data[Constant.address.toString()],
                      style: TextStyle(fontSize: 15),
                    )
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
      ),
    );
  }
}
