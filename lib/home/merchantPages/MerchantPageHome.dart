import 'package:flutter/material.dart';

class MerchantPageHome extends StatefulWidget {
  @override
  _MerchantPageHomeState createState() => _MerchantPageHomeState();
}

class _MerchantPageHomeState extends State<MerchantPageHome> {
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
                children: <Widget>[
                  //TODO: Do something with the build cards. Link em to Firebase and fetch data to be displayed
                  _buildCard(),
                  _buildCard(),
                  _buildCard(),
                  _buildCard(),
                  _buildCard(),
                  _buildCard(),
                  _buildCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard() {
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