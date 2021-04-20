import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  //TODO: Add Profile Photo from DB
  final String shopName, address;
  const ShopCard({this.shopName, this.address, Key key}) : super(key: key);

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
              child: Image.asset(
                "lib/shared/addimage.png",
                fit: BoxFit.cover,
              ),
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
                    this.shopName,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(
                    this.address,
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
    );
  }
}
