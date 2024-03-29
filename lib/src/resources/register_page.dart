import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:uber_app/src/blocs/auth_bloc.dart';
import 'package:uber_app/src/resources/dialog/loading_dialog.dart';
import 'package:uber_app/src/resources/dialog/msg_dialog.dart';
import 'package:uber_app/src/resources/home_page.dart';
import 'package:uber_app/src/resources/login_page.dart';

import '../blocs/PreferenceUtils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //show password
  bool _obscureText = true;
  //
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xff3277D8)),
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 0,
              ),
              Image.asset('ic_car_red.png', width: 196, height: 80),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  'Chào Mừng Đến Với iCab!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: const Text(
                  'Đăng ký với iCab bằng các bước đơn giản',
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.nameStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: const Icon(Icons.person_outline),
                            labelText: 'Họ Và Tên',
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.phoneStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _phoneController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: const Icon(Icons.phone_outlined),
                            labelText: 'Số Điện Thoại',
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1))),
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
                        textInputAction: TextInputAction.done,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            labelText: 'Mật Khẩu',
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1))),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RaisedButton(
                    onPressed: _onSigUpClicked,
                    child: const Text(
                      'Đăng Ký',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: const Color(0xff3277D8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: RichText(
                  text: TextSpan(
                    text: 'Đã là người dùng?',
                    style: const TextStyle(
                        fontSize: 16, color: const Color(0xff606470)),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          text: ' Đăng nhập ngay bây giờ',
                          style: const TextStyle(
                              fontSize: 16, color: const Color(0xff3277D8))),
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

  _onSigUpClicked() {
    var isValid = authBloc.isValid(_nameController.text, _phoneController.text,
        _emailController.text, _passController.text);
    if (isValid) {
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Đang tải...');
      // create sing up
      authBloc.signUp(_emailController.text, _passController.text,
          _phoneController.text, _nameController.text, () {
        // Luu thong tin dang nhap
        PreferenceUtils.setBool(PreferenceUtils.keyIsLogin, true);
        // hide loading dialog
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }, (msg) {
        // hide loading dialog
        LoadingDialog.hideLoadingDialog(context);
        // show msg dialog
        MsgDialog.showMsgDialog(context, 'Thông báo', msg);
      });
      // print('done');
    }
  }
}
