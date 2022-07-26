import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uber_app/src/blocs/PreferenceUtils.dart';
import 'package:uber_app/src/resources/home_page.dart';
import 'package:uber_app/src/resources/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    PreferenceUtils.init();
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (PreferenceUtils.getBool(PreferenceUtils.keyIsLogin)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'App Uber',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
