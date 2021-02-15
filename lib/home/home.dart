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
/// type of user is confirmed from the database, a Circular Progress Indicator rotates on the screen
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    final userType =
        DatabaseServices(uid: user.uid).getUserData(Constant.typeOfUser);

    return FutureBuilder(
      future: userType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String result = snapshot.data.toString();
          if (result == Constant.merchant.toString())
            return MerchantHome();
          else if (result == Constant.customer.toString())
            return Text("TODO: Create a customer home page");
        } else if (snapshot.hasError) {
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
