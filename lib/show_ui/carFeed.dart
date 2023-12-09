import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_carse/models/car_model.dart';
import 'package:fire_carse/show_ui/favorite_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class CarFeed extends StatelessWidget {
  const CarFeed({super.key, required this.userID, required this.car});
  final Car? car;
  final String? userID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, "/detail", arguments: car!),
              child: Hero(
                tag: car!.carName!,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(car!.carUrlImg!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            FavoriteBadge(car: car!, userID: userID),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car!.carName!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "De ${car!.carUserName}",
                    // style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ],
              ),
              Text(formattingDate(car!.carTimesTamp)),
            ],
          ),
        ),
      ],
    );
  }

  formattingDate(Timestamp? timestamp) {
    // initializeDateFormatting('de_DE',null).then((_) => runtimeType);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.yMd();
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
