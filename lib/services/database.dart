import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  static final CollectionReference databaseInstance = Firestore.instance.collection("data");

  static final FirebaseStorage _firebaseStorage = FirebaseStorage(storageBucket: "gs://shop-work-12bc7.appspot.com/");

  StorageUploadTask _uploadTask;

  void uploadImage({BuildContext context, File image}) async {
    String filePath = "images/ProfilePhoto/$uid";
    _uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);
    print(_uploadTask);
  }

  Future downloadImage()async{
    String filePath = "images/ProfilePhoto/$uid";
    try{

      String result= await _firebaseStorage.ref().child(filePath).getDownloadURL();
      return [result,true];
    }catch(e){
      return ["invalid File Path",false];
    }
  }

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