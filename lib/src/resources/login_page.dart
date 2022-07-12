import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Image.asset('ic_car_green.png', width: 196, height: 80),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Text(
                  'Login to continue using iCab',
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 145, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1))),
                ),
              ),
              Text('Forgot password?')
            ],
          ),
        ),
      ),
    );
  }
}
