import 'package:flutter/material.dart';

class MerchantPageHome extends StatefulWidget {

  static void setCounter(int value){
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

  static int count =1;

  static List<Widget> widgetList = [
    buildCard(),
    buildCard(),
    buildCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              "Shop",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.count(
                primary: false,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                children: List.generate(count, (index) => buildCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List generateList(int count, List listObject){
  return List.generate(count, (index) => listObject[index]);
}

Widget buildCard() {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
    child: InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0
            )
            ]
        ),
      ),
    ),
  );
}