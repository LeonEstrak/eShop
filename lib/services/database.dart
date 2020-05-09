import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference databaseInstance = Firestore.instance.collection("data");

  Future registerUserData({String typeOfUser}) async{
    return await databaseInstance.document(uid).setData({
      "Type of User":typeOfUser
    });
  }
}