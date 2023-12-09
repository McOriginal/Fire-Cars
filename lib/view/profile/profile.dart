import 'package:fire_carse/show_ui/car_list.dart';
import 'package:fire_carse/view/profile/profile_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(user: user),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 24.0, left: 16.0, bottom: 12.0),
                    child: Text(
                      "Vos voitures favoris",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            CarList(pageName: "Profile", userID: user!.uid),
          ],
        ),
      ),
    );
  }
}
