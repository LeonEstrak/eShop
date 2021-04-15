import 'package:shopwork/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Widget imageFromCache({String timeStamp}) => FutureBuilder(future: DatabaseServices.getPhotoURL(timeStamp: timeStamp),builder: (context,snapshot){},)
/// # Return: CachedNetworkImage <Object>
/// Looks up if the image is present in the cache, if not, download it from network.
Widget imageAsWidget({String itemName}) {
  FutureBuilder(
      future: DatabaseServices().downloadItemPhoto(itemName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0]) {
            CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
              imageUrl: snapshot.data[1],
            );
            return (cachedNetworkImage);
          } else
            return Image.asset(
              "shared/addimage.png",
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
