import 'dart:io';

import 'package:fire_carse/models/car_model.dart';
import 'package:fire_carse/services/db_services.dart';
import 'package:fire_carse/show_ui/show_snack_bar.dart';
import 'package:fire_carse/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarDialog {
  User? user;
  CarDialog({this.user});

  //Affichage de la boitte de dialoque
  void showCardDialog(BuildContext context, ImageSource source) async {
    XFile? pickerFile = await ImagePicker().pickImage(source: source);
    File _file = File(pickerFile!.path);
    final formkey = GlobalKey<FormState>();
    var _carName = '';
    var _carError = "Veillez fournir le nom de la voiture s'il vous plaît";

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: FileImage(_file),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Form(
                      key: formkey,
                      child: TextFormField(
                        maxLength: 25,
                        onChanged: (value) => _carName = value,
                        validator: (value) => _carName == "" ? _carError : null,
                        decoration: const InputDecoration(
                          labelText: "Nom de la voiture",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler"),
                        ),
                        ElevatedButton(
                          onPressed: ()=>  onSubmit(context, formkey, _file, _carName, user),
                          child: const Text("Publier"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }


  void onSubmit(context, formKey, file, carName, user) async{
    if(formKey.currentState!.validate()){
      Navigator.pop(context);
      showNotification(context, "Chargement en cours...");
      DatabaseServices db = DatabaseServices();
      String carUrlImg = await db.uploadFile(file);
      db.addCar(Car(
        carName: carName,
        carUrlImg: carUrlImg,
        carUserID: user!.uid,
        carUserName: user!.displayName
      ));
    }
  }

}
