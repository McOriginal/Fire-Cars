import 'package:fire_carse/show_ui/car_list.dart';
import 'package:fire_carse/view/home/add_car_section.dart';
import 'package:fire_carse/view/home/home_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
         slivers: [
           HomeAppBar(user: user),
           AddCarSection(user: user),
           CarList(userID: user!.uid),
         ],
        ),
      ),
    );
  }
}
