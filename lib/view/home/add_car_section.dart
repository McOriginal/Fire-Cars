import 'dart:io';

import 'package:fire_carse/view/home/show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../show_ui/show_snack_bar.dart';

class AddCarSection extends StatelessWidget {
  const AddCarSection({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salut"),
                    Text(
                      user!.displayName!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      child: IconButton(
                        onPressed: () => showCardDialog(context, user!),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

  }

  Future showCardDialog(BuildContext context, User user) async{
    try {
      final result = await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      CarDialog(user: user).showCardDialog(context, ImageSource.gallery);

      }
      } on SocketException catch (_){
        showNotification(context, "Aucune connexion internet");
      }
  }
}
