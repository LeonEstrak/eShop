import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/merchantPages/ItemInfoCard.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

/// ##Merchant Page Home
/// The 0th page or the default page of the [PageView] implemented on the Merchant Home
///
/// A `imageMap` variable is used to save the downloaded images so that everytime the
/// viewport is changed the StreamBuilder does not have to download the images everytime.
/// This saves our limited firebase bandwidth.

class MerchantPageHome extends StatefulWidget {
  ///Saves all the data of the home page widgets i.e Widget List cache
  static Map imageMap = {};

  @override
  _MerchantPageHomeState createState() => _MerchantPageHomeState();
}

class _MerchantPageHomeState extends State<MerchantPageHome> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);

    final GlobalKey<RefreshIndicatorState> _refreshIndicator =
        GlobalKey<RefreshIndicatorState>();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer()),
                Center(
                  heightFactor: 1.35,
                  child: Text(
                    "Shop",
                    style: TextStyle(
                      fontSize: 30,
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
              child: StreamBuilder(
                /// Stream Builder is used here to check the database, whenever updated,
                /// the GridView is to be rebuilt.
                stream: DatabaseServices(uid: user.uid).allItemsAsStream,
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
                      key: _refreshIndicator,
                      onRefresh: () {
                        setState(() {
                          ///Whenever refreshed. Empties the cached widget list.
                          MerchantPageHome.imageMap.clear();
                        });
                        return;
                      },
                      child: GridView.count(
                        ///Physics set to AlwaysScrollabale allows the refreshIndicator to work even when the grid
                        ///length doesnt exceed the viewport. Basically Force Enables the Scroll.
                        physics: AlwaysScrollableScrollPhysics(
                            parent: ScrollPhysics()),
                        primary: false,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        children: List.generate(itemsLength, (index) {
                          return buildCard(
                            context: context,
                            user: user,
                            name: _allItems[index]
                                [Constant.itemName.toString()],
                            price: _allItems[index]
                                [Constant.itemPrice.toString()],
                            qty: _allItems[index][Constant.itemQty.toString()],
                          );
                        }),
                      ),
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
    );
  }
}

///Used to build the Small Cards displayed in the Grid View
Widget buildCard(
    {BuildContext context,
    String name,
    String qty,
    String price,
    FirebaseUser user}) {
  dynamic result = DatabaseServices(uid: user.uid).downloadItemPhoto(name);

  /// Looks up if the image is present in the cache, if not, download it from network.
  Widget imageDownloader() {
    Image image;
    if (MerchantPageHome.imageMap[name] == null) {
      return FutureBuilder(
          future: result,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0]) {
                image = Image.network(
                  snapshot.data[1],
                  fit: BoxFit.cover,
                );
                MerchantPageHome.imageMap.addAll({name: image});
                return image;
              } else
                return Image.asset(
                  "lib/shared/addimage.png",
                  fit: BoxFit.fill,
                );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          });
    } else
      return MerchantPageHome.imageMap[name];
  }

  return Padding(
    padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemInfoCard(
                      name: name,
                      price: price,
                      qty: qty,
                    )));
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              clipBehavior: Clip.hardEdge,
              child: imageDownloader(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
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
