import 'package:flutter/material.dart';
import 'package:uber_app/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uber_app/src/blocs/auth_bloc.dart';
import 'package:uber_app/src/resources/splash_screen_page.dart';

void main() async {
  // fix loi Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // chay app
  runApp(MyApp(
      new AuthBloc(),
      MaterialApp(
        home: SplashScreen(),
      )));
}
