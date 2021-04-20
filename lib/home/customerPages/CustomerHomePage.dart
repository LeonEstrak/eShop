import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/customerPages/ShopCard.dart';
import 'package:shopwork/services/Authentication.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);
    Future docs = DatabaseServices(uid: user.uid).getListOfMerchantsData();
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () {
        setState(() {
          docs = DatabaseServices(uid: user.uid).getListOfMerchantsData();
        });
        return docs;
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                IconButton(
                    icon: Icon(Icons.menu),
                    // color: Colors.green,
                    onPressed: () => Scaffold.of(context).openDrawer()),
                Center(
                  // heightFactor: 1,
                  child: Text(
                    "Shops",
                    style: TextStyle(
                      fontSize: 40,
                      // color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: docs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> docsList = snapshot.data;
                      return ListView.builder(
                          itemCount: docsList.length,
                          itemBuilder: (context, index) {
                            return ShopCard(
                                shopName: docsList[index]
                                    [Constant.shopName.toString()],
                                address: docsList[index]
                                    [Constant.address.toString()]);
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            )
          ])),
    ));
  }
}
