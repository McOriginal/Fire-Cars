import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? carID;
  String? carName;
  String? carUserName;
  String? carUrlImg;
  String? carUserID;
  Timestamp? carTimesTamp;
  bool? isMyFavorite;
  int? carFavoriteCount;

  Car({
    this.carID,
    this.carName,
    this.carUserName,
    this.carUrlImg,
    this.carUserID,
    this.carTimesTamp,
    this.isMyFavorite,
    this.carFavoriteCount,
  });
}
