

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwork/home/MerchantHome.dart';
import 'package:shopwork/services/database.dart';
import 'package:shopwork/shared/constants.dart';


/// ## Home Widget
/// After login the Provider is used which retrieves the FireBaseUser data from the streamProvider
/// using which the type of user is confirmed from the database. Depending on their types, they are 
/// routed to the Merchant section or the Customer section. Since a FutureBuilder is used, until the
/// type of user is confirmed from the database, a Circular Progress Indicator rotates on the screen.
class Home extends StatelessWidget {

///Profile Photos Saved in Home widget so as to not having to download each time the Profile screen is Drawn. 
  static bool isProfileImageAvailable = false;
  static Image profileImage = Image.asset("lib/shared/addimage.png",fit: BoxFit.cover,);

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
