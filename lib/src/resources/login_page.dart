import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/register_page.dart';



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
                height: 100,
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
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1))),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RaisedButton(
                    onPressed: ArgumentError.notNull,
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: RichText(
                  text: TextSpan(
                    text: 'New User?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff606470),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer() ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                          text: '   Sign up for a new account',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff3277D8))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
