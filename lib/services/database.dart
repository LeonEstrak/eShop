import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference databaseInstance = Firestore.instance.collection("data");

  Future registerUserData({String typeOfUser,String firstName, String lastName, String address, String mobile}) async{
    return await databaseInstance.document(uid).setData({
      "Type of User":typeOfUser,
      "First Name": firstName,
      "Last Name": lastName,
      "Address": address,
      "Mobile Number": mobile
    });
  }

  Future getTypeOfUser()async{
    String result;
    await databaseInstance.document(uid).get().then((documentSnapshot) =>
      result = documentSnapshot.data["Type of User"].toString()
    );
    return result;
  }

}