import 'dart:io';

import 'package:fire_carse/services/authentificantion.dart';
import 'package:fire_carse/show_ui/show_snack_bar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage("assets/carse.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Fire Carse",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Decouvrez les meilleurs voitures de luxes 2023-2024",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              inLoginProcess
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => signIn(context),
                      child: const Text("Connectez-vous avec Google"),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      setState(() {
      inLoginProcess = true;
      AuthService().signInWithGoogle();
      });

    }
      } on SocketException catch (_){
      showNotification(context, "Aucune connexion internet");
      }
  }
}
