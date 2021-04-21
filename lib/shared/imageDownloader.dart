import 'package:shopwork/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Widget imageFromCache({String timeStamp}) => FutureBuilder(future: DatabaseServices.getPhotoURL(timeStamp: timeStamp),builder: (context,snapshot){},)
/// ### Return: CachedNetworkImage <Object>
/// Looks up if the image is present in the cache, if not, download it from network.
Widget itemImageAsWidget({String itemName, String uid}) {
  return FutureBuilder(
      future: DatabaseServices(uid: uid).downloadItemPhoto(itemName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0]) {
            CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
              imageUrl: snapshot.data[1],
              fit: BoxFit.cover,
            );
            return (cachedNetworkImage);
          } else
            return Image.asset(
              "lib/shared/addimage.png",
              fit: BoxFit.cover,
            );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
            constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
          ),
        );
      });
}

Widget profilePhotoAsWidget({String uid}) {
  return FutureBuilder(
      future: DatabaseServices(uid: uid).getProfilePhotoURL(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0]) {
            CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
              imageUrl: snapshot.data[1],
              fit: BoxFit.cover,
            );
            return (cachedNetworkImage);
          } else
            return Image.asset("lib/shared/addimage.png", fit: BoxFit.cover);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
            constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
          ),
        );
      });
}
