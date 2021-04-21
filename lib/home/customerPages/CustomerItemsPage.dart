import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopwork/home/customerPages/ItemCard.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

class CustomerItemsPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  CustomerItemsPage({this.documentSnapshot});

  @override
  _CustomerItemsPageState createState() => _CustomerItemsPageState();
}

class _CustomerItemsPageState extends State<CustomerItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Stack(children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            Center(
              child: Text(
                "Items",
                style: TextStyle(
                  fontSize: 40,
                  // color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              /// Stream Builder is used here to check the database, whenever updated,
              /// the GridView is to be rebuilt.
              stream: DatabaseServices(uid: widget.documentSnapshot.documentID)
                  .allItemsAsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List _allItems = snapshot.data[Constant.items.toString()];

                  ///_allitems.length called on null results in error
                  var itemsLength;
                  if (_allItems == null)
                    itemsLength = 0;
                  else
                    itemsLength = _allItems.length;

                  return RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: ListView.builder(
                        itemCount: itemsLength,

                        ///Physics set to AlwaysScrollabale allows the refreshIndicator to work even when the grid
                        ///length doesnt exceed the viewport. Basically Force Enables the Scroll.
                        physics: AlwaysScrollableScrollPhysics(
                            parent: ScrollPhysics()),
                        primary: false,
                        itemBuilder: (context, index) => ItemCard(
                              itemName: _allItems[index]
                                  [Constant.itemName.toString()],
                              itemPrice: _allItems[index]
                                  [Constant.itemPrice.toString()],
                              documentSnapshot: widget.documentSnapshot,
                            )),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ]),
      )),
    );
  }
}
