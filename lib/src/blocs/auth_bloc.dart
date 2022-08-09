import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_app/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuthen = FirAuth();

  final StreamController _nameController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();

  var _avatarController = StreamController<String>();
  Stream<String> get avatarCrl => _avatarController.stream;

  Stream get nameStream => _nameController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get passStream => _passController.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError('Nhập Họ Và Tên');
      return false;
    }
    _nameController.sink.add('OK');

    if (phone == null || phone.length == 0) {
      _phoneController.sink.addError('Nhập Số Điện Thoại');
      return false;
    }
    _phoneController.sink.add('OK');

    if (email == null || email.length == 0) {
      _emailController.sink.addError('Nhập Email');
      return false;
    }
    _emailController.sink.add('OK');

    if (pass == null || pass.length < 6) {
      _passController.sink.addError('Mật khẩu trên 6 ký tự');
      return false;
    }
    _passController.sink.add('OK');

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onRegisterError) {
    _firAuthen.signUp(email, pass, name, phone, onSuccess, onRegisterError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuthen.signIn(email, pass, onSuccess, onSignInError);
  }

  void resetPass(String email, Function onSuccess,
      Function(String) onForgotPasswordError) {
    _firAuthen.resetPass(email, onSuccess, onForgotPasswordError);
  }

  Future<String?> getCurrentUserEmail() async {
    _firAuthen.getCurrentUserEmail();
    // print('User Email bloc: ${_firAuthen.getCurrentUserEmail()}');
    return _firAuthen.getCurrentUserEmail();
  }

  Future<String?> getUserName() async {
    _firAuthen.getUserName();
    // print('User Name bloc: ${_firAuthen.getUserName()}');
    return _firAuthen.getUserName();
  }

  // Future<String?> getImage() async {
  //   _firAuthen.getImage();
  //   return _firAuthen.getImage();
  // }
  void getImage() {
    _firAuthen.getImage().then((value) {
      _avatarController.sink.add(value ?? "");
    });
  }
  void avatarImage() {
    _firAuthen.upLoadImage().then((value) {
      print('value: $value');
      _avatarController.sink.add(value ?? "");
    });
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passController.close();
  }
}
