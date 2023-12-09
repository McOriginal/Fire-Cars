import 'package:fire_carse/models/car_model.dart';
import 'package:fire_carse/services/db_services.dart';
import 'package:flutter/material.dart';

class FavoriteBadge extends StatefulWidget {
  const FavoriteBadge({super.key, required this.car, required this.userID});

  final Car? car;
  final String? userID;

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: 4.0,
      right: 12.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white.withOpacity(0.7),
        ),
        child: widget.car!.isMyFavorite!
            ? GestureDetector(
             onTap: ()=> DatabaseServices().removeFavoriteCar(widget.car!, widget.userID!),
              child: Row(
                  children: [
                    Text(
                      "${widget.car!.carFavoriteCount}",
                      style:const  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
            )
            : GestureDetector(
             onTap: ()=> DatabaseServices().addFavoriteCar(widget.car!, widget.userID!),
              child: Row( children: [
          widget.car!.carFavoriteCount! >0 ?
          Text(
              "${widget.car!.carFavoriteCount}",
              style:const TextStyle(
                fontWeight: FontWeight.bold,
              ),
          )
          : Container(),
          const Icon(
              Icons.favorite,

          ),
        ],),
            ),
      ),
    );
  }
}
