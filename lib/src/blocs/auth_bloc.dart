import 'dart:async';

class AuthBloc {
  final StreamController _nameController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if(name == null || name.length == 0) {
      _nameController.sink.addError('Enter name');
      return false;
    }
    _nameController.sink.add('OK');

    if(phone == null || phone.length == 0) {
      _phoneController.sink.addError('Enter phone');
      return false;
    }
    _phoneController.sink.add('OK');

    if(email == null || email.length == 0) {
      _emailController.sink.addError('Enter email');
      return false;
    }
    _emailController.sink.add('OK');

    if(pass == null || pass.length < 6) {
      _passController.sink.addError('Password over 5 characters');
      return false;
    }
    _passController.sink.add('OK');

    return true;
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passController.close();
  }
}