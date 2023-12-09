import 'package:fire_carse/models/car_model.dart';
import 'package:fire_carse/services/db_services.dart';
import 'package:fire_carse/show_ui/carFeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarList extends StatelessWidget {
  const CarList({super.key,  this.pageName,  this.userID});
  final String? userID;
  final String? pageName;

  @override
  Widget build(BuildContext context) {
    final _cars = Provider.of<List<Car>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return StreamBuilder(
              stream:
                  DatabaseServices(userID: userID, carID: _cars[index].carID)
                      .myFavoriteCar,
              builder: (context, snapshot) {
                if(pageName == "Profile"){
                  if(!snapshot.hasData) return Container();
                  _cars[index].isMyFavorite = true;
                  return CarFeed(userID: userID, car: _cars[index]);
                }
                if (!snapshot.hasData) {
                  _cars[index].isMyFavorite = false;
                  return CarFeed(userID: userID, car: _cars[index]);
                } else {
                  _cars[index].isMyFavorite = true;
                  return CarFeed(userID: userID, car: _cars[index]);
                }
              });
        },
        childCount: _cars.length,
      ),
    );
  }
}
