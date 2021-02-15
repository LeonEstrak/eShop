import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/merchantPages/ItemInfoCard.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

/// ##Merchant Page Home
/// The 0th page or the default page of the [PageView] implemented on the Merchant Home
/// TODO: Documentation to be updated

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
                        children: List.generate(_allItems.length, (index) {
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
  /// TODO: Create a new FILE and refactor to make the function shared
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

// class BuildCard extends StatefulWidget {
//   String name;
//   String qty;
//   String price;
//   BuildCard({this.name, this.price, this.qty, Key key}) : super(key: key);

//   @override
//   _BuildCardState createState() =>
//       _BuildCardState(name: name, price: price, qty: qty);
// }

// class _BuildCardState extends State<BuildCard> {
//   String name;
//   String qty;
//   String price;

//   _BuildCardState({
//     this.name,
//     this.price,
//     this.qty,
//   });

//   @override
//   Widget build(BuildContext context) {}
// }
