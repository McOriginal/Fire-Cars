import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.user});
  //**********************
  final User? user;
// *****************

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("Fire cars"),
      elevation: 0.8,
      forceElevated: true,
      floating: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
        child: Hero(
          tag: user!.photoURL!,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(user!.photoURL!),
          ),
        ),
          ),
        ),
      ],
    );
  }
}
