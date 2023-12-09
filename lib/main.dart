import 'package:fire_carse/services/authentificantion.dart';
import 'package:fire_carse/services/db_services.dart';
import 'package:fire_carse/view/detail/car_detail.dart';
import 'package:fire_carse/view/profile/profile.dart';
import 'package:fire_carse/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/car_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(
          value: AuthService().user,
          initialData: null,
        ),StreamProvider<List<Car>>.value(
          value: DatabaseServices().cars,
          initialData: [],
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Carse ',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/profile': (context) => const Profile(),
        '/detail': (context) => const CarDetail(),
      },
    );
  }
}
