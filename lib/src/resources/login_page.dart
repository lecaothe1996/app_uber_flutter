import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_app/src/app.dart';
import 'package:uber_app/src/resources/dialog/loading_dialog.dart';
import 'package:uber_app/src/resources/dialog/msg_dialog.dart';
import 'package:uber_app/src/resources/home_page.dart';
import 'package:uber_app/src/resources/register_page.dart';
import '../blocs/PreferenceUtils.dart';
import '../blocs/auth_bloc.dart';
import 'widgets/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //hide password
  bool _obscureText = true;

  //
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }

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
                  'Chào Mừng Trở Lại',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Text(
                  'Đăng nhập để tiếp tục sử dụng iCab',
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.emailStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: Icon(Icons.mail_outlined),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1))),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.passStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _passController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // print('click pass');
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1))),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    print('Click quên mật khẩu?');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(fontSize: 16, color: Color(0xff3277D8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RaisedButton(
                    onPressed: _onLoginClick,
                    child: Text(
                      'Đăng Nhập',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: RichText(
                  text: TextSpan(
                    text: 'Người dùng mới?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff606470),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          text: ' Đăng ký một tài khoản mới',
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

  void _onLoginClick() {
    var isValid = authBloc.isValid(
        toString(), toString(), _emailController.text, _passController.text);

    if (isValid) {
      String email = _emailController.text;
      String pass = _passController.text;

      var authBloc = MyApp.of(context)?.authBloc;
      // Hien pop-up loading...
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc!.signIn(email, pass, () {
        // Luu thong tin dang nhap
        PreferenceUtils.setBool(PreferenceUtils.keyIsLogin, true);
        // An pop-up loading...
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Log-In', msg);
      });
    }
  }
}
