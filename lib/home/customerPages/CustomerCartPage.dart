import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/customerPages/ItemCard.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

class CustomerCartPage extends StatefulWidget {
  @override
  _CustomerCartPageState createState() => _CustomerCartPageState();
}

class _CustomerCartPageState extends State<CustomerCartPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);
    Future itemsInCart = DatabaseServices(uid: user.uid).allItemsInCart;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          setState(() {
            itemsInCart = DatabaseServices(uid: user.uid).allItemsInCart;
          });
          return itemsInCart;
        },
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 40,
                  // color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: itemsInCart,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List itemMap = snapshot.data;
                  return ListView.builder(
                      itemCount: itemMap.length,
                      itemBuilder: (context, index) => ItemCard(
                            documentID: itemMap[index][Constant.uid.toString()],
                            itemName: itemMap[index]
                                [Constant.itemName.toString()],
                            itemPrice: double.tryParse((itemMap[index]
                                            [Constant.amount.toString()] /
                                        itemMap[index]
                                            [Constant.itemQty.toString()])
                                    .toString())
                                .toInt()
                                .toString(),
                            fromCartPage: true,
                          ));
                }
                return Center(child: CircularProgressIndicator());
              },
            ))
          ],
        )),
      ),
    );
  }
}
