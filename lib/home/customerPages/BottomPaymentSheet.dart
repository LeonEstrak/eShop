import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/services/database.dart';

class BottomPaymentSheet extends StatefulWidget {
  @override
  _BottomPaymentSheetState createState() => _BottomPaymentSheetState();
}

class _BottomPaymentSheetState extends State<BottomPaymentSheet> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   width: 25,
          // ),
          Text(
            "Total Amount Payable: ",
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   width: 25,
          // ),
          StreamBuilder(
              stream: DatabaseServices(uid: user.uid).amountPayable,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ElevatedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Place Order"),
                              content: Text(
                                  "All the items currently in your cart will be ordered and with a total payable amount of Rs. ${snapshot.data}. \nWould you like to proceed ?"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(context,
                                            rootNavigator: true)
                                        .pop('dialog'),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12),
                                      textAlign: TextAlign.end,
                                    )),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                      textAlign: TextAlign.end,
                                    ))
                              ],
                            )),
                    child: Text(
                      "₹ ${snapshot.data}",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, spreadRadius: 0.5, color: Colors.grey)
        ],
        color: Colors.white,
      ),
    );
  }
}
