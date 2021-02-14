import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

/// ##Merchant Page Home
/// The 0th page or the default page of the [PageView] implemented on the Merchant Home
/// TODO: Documentation to be updated

class MerchantPageHome extends StatefulWidget {
  static void setCounter(int value) {
    _MerchantPageHomeState.count = value;
  }

  static int getCounter() {
    return _MerchantPageHomeState.count;
  }

  @override
  _MerchantPageHomeState createState() => _MerchantPageHomeState();
}

class _MerchantPageHomeState extends State<MerchantPageHome> {
  //TODO:Cards on display should show information fetched from network

  static int count = 1;

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);

    // Future<List> allShopItems = DatabaseServices(uid: user.uid).allItems;

    final GlobalKey<RefreshIndicatorState> _refreshIndicator =
        GlobalKey<RefreshIndicatorState>();

    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicator,
        onRefresh: () {
          setState(() {});
          return;
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Shop",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  /// Stream Builder is used here to check the database, whenever updated,
                  /// the GridView is to be rebuilt.
                  stream: DatabaseServices(uid: user.uid).allItemsAsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List _allItems = snapshot.data[Constant.items.toString()];
                      return GridView.count(
                        primary: false,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        children: List.generate(
                            _allItems.length,
                            (index) => buildCard(
                                name: _allItems[index]
                                    [Constant.itemName.toString()],
                                price: _allItems[index]
                                    [Constant.itemPrice.toString()],
                                qty: _allItems[index]
                                    [Constant.itemQty.toString()],
                                user: user)),
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
            ],
          ),
        ),
      ),
    );
  }
}

///Used to build the Small Cards displayed in the Grid View
Widget buildCard({String name, String qty, String price, FirebaseUser user}) {
  dynamic result = DatabaseServices(uid: user.uid).downloadItemPhoto(name);

  return Padding(
    padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
    child: InkWell(
      onTap: () {},
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              clipBehavior: Clip.hardEdge,
              child: FutureBuilder(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(snapshot.data[1]);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return CircularProgressIndicator();
                },
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.black12),
            ),
            Text("Name: $name"),
            Text("Price: $price"),
            Text("Quantity: $qty"),
          ],
        ),
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
    ),
  );
}

/*
 child: StreamBuilder(
                  stream: DatabaseServices.uploadTask != null
                      ? DatabaseServices.uploadTask.events
                      : DatabaseServices(uid: user.uid).allItemsAsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return FutureBuilder(
                        future: result,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot.data[1]);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                  }),
              
 */
