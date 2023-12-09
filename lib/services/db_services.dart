import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_carse/models/car_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  String? userID;
  String? carID;

  DatabaseServices({this.userID, this.carID});


  // declaration et initialisation
  CollectionReference _cars = FirebaseFirestore.instance.collection("cars");
  FirebaseStorage _storage = FirebaseStorage.instance;

  //upload de l'image vers Firebase storage
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child("cars/${DateTime.now()}.png");
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

// ajout de la voiture dans la Base de donnée
  void addCar(Car car) {
    _cars.add({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserID": car.carUserID,
      "carUserName": car.carUserName,
      "carTimestamp": FieldValue.serverTimestamp(),
      "carFavoriteCount": 0,
    });
  }

// recuperation de toute les voiture en temps réel
  Stream<List<Car>> get cars {
    Query queryCars = _cars.orderBy("carTimestamp", descending: true);
    return queryCars.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Car(
          carID: doc.id,
          carName: doc.get("carName"),
          carUrlImg: doc.get("carUrlImg"),
          carUserID: doc.get("carUserID"),
          carUserName: doc.get("carUserName"),
          carFavoriteCount: doc.get("carFavoriteCount"),
          carTimesTamp: doc.get("carTimestamp"),
        );
      }).toList();
    });
  }

// ajout de la voiture favoris dans une sous-collection
  void addFavoriteCar(Car car, String userID) async {
    final carDocReft = _cars.doc(car.carID);
    final favoriteBy = carDocReft.collection('favoriteBy');
    int carFavoriteCount = car.carFavoriteCount!;
    int increasecount = carFavoriteCount += 1;
    favoriteBy.doc(userID).set({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserID": car.carUserID,
      "carUserName": car.carUserName,
      "carTimestamp": car.carTimesTamp,
      "carFavoriteCount": increasecount,
    });
    carDocReft.update({
      "carFavoriteCount": increasecount
    });
  }


  // retirer la voiture dans la liste de favorites

  void removeFavoriteCar(Car car, String userID) async {
    final carDocReft = _cars.doc(car.carID);
    final favoriteBy = carDocReft.collection('favoriteBy');
    int carFavoriteCount = car.carFavoriteCount!;
    int increasecount = carFavoriteCount -= 1;
    carDocReft.update({
      "carFavoriteCount": increasecount
    });
    favoriteBy.doc(userID).delete();
  }

  // récuperation des voitures favorite de l'utilisateur en temps réel

Stream<Car> get myFavoriteCar{
    final favoriteBy = _cars.doc(carID).collection("favoriteBy");
    return favoriteBy.doc(userID).snapshots().map((doc){
      return Car(
      carID: doc.id,
      carName: doc.get("carName"),
    carUrlImg: doc.get("carUrlImg"),
    carUserID: doc.get("carUserID"),
    carUserName: doc.get("carUserName"),
    carFavoriteCount: doc.get("carFavoriteCount"),
    carTimesTamp: doc.get("carTimestamp"),
    );
    });
    }

// Supperssion de la voiture dans base de données

Future<void> deletCar(String carID)=> _cars.doc(carID).delete();

}
