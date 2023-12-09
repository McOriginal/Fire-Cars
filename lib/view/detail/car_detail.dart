import 'package:fire_carse/models/car_model.dart';
import 'package:fire_carse/services/db_services.dart';
import 'package:fire_carse/show_ui/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CarDetail extends StatelessWidget {
  const CarDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final _userID = Provider.of<User?>(context)!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          car.carName!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme:const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          car.carUserID == _userID
              ? IconButton(
                  onPressed: () => onDeleteCar(context, car),
                  icon: const Icon(Icons.delete),
                )
              : Container(),
        ],
      ),
      body: InteractiveViewer(
        child: Hero(
          tag: car.carName!,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(car.carUrlImg!),
                  ),),
            ),
          ),
        ),
      ),
    );
  }

  void onDeleteCar(BuildContext context, Car car) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "Voulez vous vraiment supprimer cette voiture ${car.carName} ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:const Text("Annuler"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  DatabaseServices().deletCar(car.carID!);
                  showNotification(context, "Supprimé avec succès");
                },
                child: const Text("Supprimer"),
              ),
            ],
          );
        });
  }
}
