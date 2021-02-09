import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/MerchantHome.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    final userType = DatabaseServices(uid: user.uid).getTypeOfUser();

    return FutureBuilder(
      future: userType,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          String result = snapshot.data.toString();
          if(result==Constant.merchant)
            return MerchantHome();
          else if(result==Constant.customer)
            return Text("TODO: Create a customer home page");
        }else if (snapshot.hasError){
          String result = snapshot.error.toString();
          return Text(result);
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
