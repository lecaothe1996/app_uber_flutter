import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/login_page.dart';

import '../app.dart';
import '../blocs/auth_bloc.dart';
import 'dialog/loading_dialog.dart';
import 'dialog/msg_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xff3277D8)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nhập email của bạn và chúng tôi sẽ gửi cho bạn một liên kết đặt lại mật khẩu',
              style: TextStyle(
                height: 1.5,
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              // textScaleFactor: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.done,
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
              padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: RaisedButton(
                  onPressed: _onPasswordResetClick,
                  child: Text(
                    'Đặt Lại Mật Khẩu',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Color(0xff3277D8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPasswordResetClick() {
    var isValid = authBloc.isValid(
        toString(), toString(), _emailController.text, toString());

    if (isValid) {
      String email = _emailController.text;

      var authBloc = MyApp.of(context)?.authBloc;
      // Hien pop-up loading...
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc!.resetPass(email, (onSuccess) {
        // An pop-up loading...
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Thông báo', onSuccess);
        _emailController.text = '';
        // Navigator.pop(context);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Thông báo', msg);
      });
    }
  }
}
