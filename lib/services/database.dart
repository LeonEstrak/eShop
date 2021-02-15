import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopwork/shared/constants.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  static final CollectionReference userDatabaseInstance =
      Firestore.instance.collection("data");
  static final CollectionReference itemsDatabaseInstance =
      Firestore.instance.collection("items");

  static final FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: "gs://shop-work-2f412.appspot.com");

  static StorageUploadTask uploadTask;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~VVVV Profile Photo VVVV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ///Uploads the profile image to `"images/ProfilePhoto/$uid"` in the Firebase Storage.
  void uploadProfilePhoto({File image}) async {
    //TODO: Error Handling while uploading the profile photo[Back End]
    String filePath = "images/ProfilePhoto/$uid";
    uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);
    print(uploadTask);
  }

  /// ### @output: Future<bool,String>
  ///Downloads the profile image from `"images/ProfilePhoto/$uid"` in the Firebase Storage.
  /// 0th position is a bool which tells if the image was found or not.
  /// 1st position is a String which is the downloadURL when 0th pos is true.
  Future<List> downloadProfilePhoto() async {
    String filePath = "images/ProfilePhoto/$uid";
    try {
      String result =
          await _firebaseStorage.ref().child(filePath).getDownloadURL();
      return [true, result];
    } catch (e) {
      return [false, "none"];
    }
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~VVVV Item Photo VVVV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ///Uploads the profile image to `"images/$uid/items/$itemName"` in the Firebase Storage.
  void uploadItemPhoto({File image, String itemName}) {
    itemName = itemName.toLowerCase();
    String filePath = "images/$uid/items/$itemName";
    try {
      uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);
      print(uploadTask.toString());
      //      return true;
    } catch (e) {
      print(e.toString());
      //      return false;
    }
  }

  /// ### @output: Future<bool,String>
  ///Downloads the item image from `"images/$uid/items/$itemName"` in the Firebase Storage.
  /// 0th position is a bool which tells if the image was found or not.
  /// 1st position is a String which is the downloadURL when 0th pos is true.
  Future<List> downloadItemPhoto(String itemName) async {
    itemName = itemName.toLowerCase();
    String filePath = "images/$uid/items/$itemName";
    try {
      // await _uploadTask.isComplete;
      String result =
          await _firebaseStorage.ref().child(filePath).getDownloadURL();
      print(result);
      return [true, result];
    } catch (e) {
      print(e.toString());
      try {
        ///Nested TRY-CATCH, retries to fetch data after 5 seconds if data not found.
        await Future.delayed(Duration(seconds: 5), () {});
        String result =
            await _firebaseStorage.ref().child(filePath).getDownloadURL();
        print(result);
        return [true, result];
      } catch (e) {
        print(e.toString());
        return [false, "lib/shared/addimage.png"];
      }
    }
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~VVVV Item Data VVVV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  /// This function appends data in the form of key value pair in the existing database.
  /// Stores the registered data in the form of an array in a .json file with the `Items` as the root key
  /// The array contains Map<String,String> as values.
  /// For Example,
  /// ```
  /// "Items":[
  /// {"Item Name": "carrots", "Item Quantity": "20", "Item Price":"40"},
  /// {"Item Name": "raddish", "Item Quantity": "20", "Item Price":"65"}
  /// ]
  /// ```
  /// All item names will be stored in lower case
  Future<void> merchantAddItemData(
      {String itemName, String itemQty, String itemPrice}) async {
    List itemMap = await allItems;
    itemMap.add({
      Constant.itemName.toString(): itemName.toLowerCase(),
      Constant.itemQty.toString(): itemQty,
      Constant.itemPrice.toString(): itemPrice,
    });
    print(itemMap);
    return await itemsDatabaseInstance
        .document(uid)
        .setData({Constant.items.toString(): itemMap});
  }

  /// Returns a List of Key:Value pair.
  /// All items the user has registered in the database.
  /// ```
  /// "Items":[
  /// {"Item Name": "carrots", "Item Quantity": "29", "Item Price":"40"},
  /// {"Item Name": "raddish", "Item Quantity": "17", "Item Price":"65"}
  /// ]
  /// ```
  /// #### All shop items : For Merchants
  /// #### All cart items : For Customer
  Future<List> get allItems async {
    List itemMap;
    try {
      await itemsDatabaseInstance.document(uid).get().then((documentSnapshot) =>
          itemMap = documentSnapshot.data[Constant.items.toString()]);
    } catch (e) {
      itemMap = [
        {"Error": e.toString()}
      ];
    }
    print(itemMap);
    return itemMap;
  }

  ///Strean used to check the change in the data of items Uploaded
  Stream<dynamic> get allItemsAsStream {
    return itemsDatabaseInstance.document(uid).snapshots();
  }

  /// ### @input: String
  /// ### @output: Map<String, String>
  /// Returns a key value pair Map containing information of a single item
  Future<Map<String, String>> getSingleItemData(String itemName) async {
    Map<String, String> result;
    try {
      await itemsDatabaseInstance.document(uid).get().then((documentSnapshot) {
        List<dynamic> tempArray =
            documentSnapshot.data[Constant.items.toString()];
        for (var item in tempArray) {
          if (item[Constant.itemName.toString()] == itemName.toLowerCase()) {
            result = item;
          }
        }
      });
    } catch (e) {
      result = {"Error": e.toString()};
    }
    return result;
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~VVVV User Data VVVV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  /// Registers user info to the user database.
  /// Initializes a blank array in the item database.
  /// For Merchants, it is all the items that they hold to sell.
  /// For Customers, it is all the items present in their carts.
  Future<void> registerUserData(
      {String typeOfUser,
      String firstName,
      String lastName,
      String address,
      String mobile}) async {
    await itemsDatabaseInstance
        .document(uid)
        .setData({Constant.items.toString(): []});
    return await userDatabaseInstance.document(uid).setData({
      Constant.typeOfUser.toString(): typeOfUser,
      Constant.firstName.toString(): firstName,
      Constant.lastName.toString(): lastName,
      Constant.address.toString(): address,
      Constant.mobile.toString(): mobile
    });
  }

  /// ### @input: Constant Class
  /// ### @output: String
  /// Returns a String containing information of the user
  Future<String> getUserData(Constant object) async {
    String result;
    try {
      await userDatabaseInstance.document(uid).get().then((documentSnapshot) =>
          result = documentSnapshot.data[object.toString()].toString());
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
