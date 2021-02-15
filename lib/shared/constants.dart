import 'package:flutter/cupertino.dart';

/// ### Constants
/// #### Only static members. Do not instantiate.
/// Since strings are used in a .json file, discrepancy in letter case or spelling can cause error in retrieval of data.
/// To avoid such from happening, this class should be used to when requesting data from the database.
class Constant {
  static Constant customer = Constant._("Customer"),
      merchant = Constant._("Merchant"),
      typeOfUser = Constant._("Type of User"),
      firstName = Constant._("First Name"),
      lastName = Constant._("Last Name"),
      address = Constant._("Address"),
      mobile = Constant._("Mobile Number"),
      items = Constant._("Items"),
      itemName = Constant._("Item Name"),
      itemQty = Constant._("Item Quantity"),
      itemPrice = Constant._("Item Price");

  String _value;

  static GlobalKey _contextKey = GlobalKey();

  static GlobalKey get contextKey => _contextKey;

  @override
  String toString() {
    return _value;
  }

  Constant._(String string) {
    _value = string;
  }
}
