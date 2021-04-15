import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopwork/shared/imageDownloader.dart';

class ItemBuyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ItemBuyPageState();
  }
}

class ItemBuyPageState extends State<ItemBuyPage> {
//  int selected_qty = 0;
  String rupee = "\u20B9";
  int no_of_units = 1;
  @override
  Widget build(BuildContext context) {
    _showModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                height: 300,
                padding: new EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(padding: const EdgeInsets.all(7)),
                    new Text("Select Quantity",
                        style: new TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400)),
                    const Padding(padding: const EdgeInsets.all(12)),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new FlatButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => setModalState(() {
                                  if (no_of_units != 1) no_of_units--;
                                }),
                            child: new Container(
                              child: new Icon(Icons.remove),
                              decoration: new BoxDecoration(
                                  border: Border.all(
                                      width: 1.6, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            )),
                        new Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: new Text(
                            '$no_of_units',
                            style: new TextStyle(fontSize: 20),
                          ),
                        ),
                        new FlatButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => setModalState(() {
                                  no_of_units++;
                                }),
                            child: new Container(
                              child: new Icon(Icons.add),
                              decoration: new BoxDecoration(
                                  border: Border.all(
                                      width: 1.6, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            )),
                      ],
                    ),
                    const Padding(padding: const EdgeInsets.all(10)),
                    new FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => debugPrint('Added to Cart'),
                        child: new Container(
                          height: 40,
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.shopping_cart,
                                  color: Colors.green,
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                ),
                                new Text(
                                  "Add to Cart",
                                  style: new TextStyle(color: Colors.green),
                                )
                              ]),
                          decoration: new BoxDecoration(
                              border:
                                  Border.all(width: 1.6, color: Colors.green),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        )),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    new FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => debugPrint('Buy Directly'),
                        child: new Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: new Text(
                            "Buy Now",
                            style: new TextStyle(color: Colors.white),
                          ),
                          decoration: new BoxDecoration(
                              color: Colors.green,
                              border:
                                  Border.all(width: 1.6, color: Colors.green),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ))
                  ],
                ),
              );
            });
          }); //Old Builder
    }

    return new Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Text("eShop"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.shopping_cart),
              onPressed: () => debugPrint("Icon Tapped"))
        ],
      ),
      body: new ListView(children: <Widget>[
        new Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 5, right: 5),
          color: Colors.white,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(padding: const EdgeInsets.all(5)),
              new Container(
                padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                decoration: new BoxDecoration(
                    color: Colors.green.shade100,
                    border: Border.all(width: 2, color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: new Text(
                  "{shop.link[itemList[2]]}",
                  style:
                      new TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
              new Container(
                height: 28,
                alignment: Alignment.centerLeft,
                child: new Text(
                  "{itemList[0]}", //, ${item_options[selected_qty]['weight']}
                  style:
                      new TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
              new Container(
                height: 22,
                alignment: Alignment.centerLeft,
                child: new Text(
                  "$rupee {itemList[1]}", //${item_options[selected_qty]['price']}
                  style:
                      new TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
              new Container(
                height: 14,
                alignment: Alignment.centerLeft,
                child: new Text(
                  "(Inclusive of all taxes)",
                  style: new TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
              new Padding(padding: const EdgeInsets.all(8)),
              new Container(
                  alignment: Alignment.center,
                  height: 350,
                  child: imageAsWidget(itemName: 'itemList[0].toString()')),
              new Padding(padding: const EdgeInsets.all(3)),
            ],
          ),
        ),
//        new Padding(padding: const EdgeInsets.all(0.5)),
//        new Container(
//          alignment: Alignment.topCenter,
//          padding: EdgeInsets.only(left: 5, right: 5),
//          color: Colors.white,
//          child: new Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              new Padding(padding: const EdgeInsets.all(7)),
//              new Container(
//                height: 28,
//                alignment: Alignment.centerLeft,
//                child: new Text(
//                  "Pack Sizes",
//                  style:
//                      new TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
//                  textAlign: TextAlign.left,
//                  textDirection: TextDirection.ltr,
//                ),
//              ),
//              new Padding(padding: const EdgeInsets.all(7)),
//              weightOptions(context, 0),
//              new Padding(padding: const EdgeInsets.all(5)),
//              weightOptions(context, 1),
//              new Padding(padding: const EdgeInsets.all(5)),
//              weightOptions(context, 2),
//              new Padding(padding: const EdgeInsets.all(5)),
//            ],
//          ),
//        ),
        new Padding(padding: const EdgeInsets.all(5)),
        new Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 13, bottom: 13, left: 5),
            //  alignment: Alignment.topCenter,
            child: new Text(
              "About this Product",
              style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            )),
        new Padding(padding: const EdgeInsets.all(0.5)),
        new Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 5, right: 5),
          color: Colors.white,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ExpansionTile(
                title: new Text(
                  "About the product",
                  style:
                      new TextStyle(fontSize: 20, color: Colors.grey.shade600),
                ),
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 18, right: 15),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "Bring a little magic to your Kids day with the delicious taste of Kelloggs Chocos. Kelloggs Chocos is a Solid and Nourishing food for your kids to get going and it has the protein and fibre of 1 Roti, along with 10 Vitamins and minerals. Kelloggs Chocos is high in calcium, low in fat and naturally cholesterol free. Crafted to make your Kids milk bowl tasty and fun, our chocolaty, crunchy and grain-based cereal makes for a tasty pick-me-up at school or work, as an afternoon bite, or a late-night treat. A travel-ready food, Kelloggs Chocos are an ideal companion for lunchboxes, after-school snacks, and busy, on-the-go moments. Just add milk or enjoy as a crispy treat straight from the box. Yummy Chocolaty cereal with whole grain that your kids will love, with Protein and fibre of 1 Roti. Give your Kids a Solid start to the day with the grain-based yummy chocolaty Kelloggs Chocos. Kelloggs Chocos is a food high in calcium, iron and B-Group Vitamins.No preservatives have been added.",
                      style: new TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(10)),
                ],
              ),
              new ExpansionTile(
                title: new Text(
                  "Ingredients",
                  style:
                      new TextStyle(fontSize: 20, color: Colors.grey.shade600),
                ),
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 18, right: 15),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "Whole wheat flour (28%), Sugar, Wheat flour, Corn flour, Cocoa solids (de-fatted 5%), Edible vegetable oil, Minerals, Malt extract, Iodized salt,Vitamins, Colour (INS 150d) and Antioxidant (INS 320)CONTAINS PERMITTED NATURAL COLOUR & ADDED FLAVOURS(NATURE-IDENTICAL & ARTIFICIAL FLAVOURING SUBSTANCES-CREAM)",
                      style: new TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(10)),
                ],
              ),
              new ExpansionTile(
                title: new Text(
                  "Sold By",
                  style:
                      new TextStyle(fontSize: 20, color: Colors.grey.shade600),
                ),
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 18, right: 15),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "DMART\nPlot No 9, Kamaladevi Birajdar Marg\nNerul East, Sector 21\nNerul, Navi Mumbai\nMaharashtra 400706",
                      style: new TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(10)),
                ],
              ),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.all(5)),
        new Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          height: 60,
          child: new Row(
            //   alignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                  flex: 5,
                  child: new FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => _showModalBottomSheet(context),
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Icon(
                                Icons.shopping_cart,
                                color: Colors.green,
                              ),
                              new Text(
                                "Add to Cart",
                                style: new TextStyle(color: Colors.green),
                              )
                            ]),
                      ))),
              new Expanded(
                  flex: 5,
                  child: new FlatButton(
                      color: Colors.green,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => _showModalBottomSheet(context),
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.green,
                        child: new Text(
                          "Buy Now",
                          style: new TextStyle(color: Colors.white),
                        ),
                      )))
            ],
          ),
        )
      ]),
    );
  }
}
