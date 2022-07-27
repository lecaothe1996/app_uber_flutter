import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    // tạo user
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      // tao uer thanh cong
      _createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
      print(user);
    }).catchError((err) {
      // error
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = {'name': name, 'phone': phone};
    // ghi dữ liệu lên database
    var ref = FirebaseDatabase.instance.reference().child('users');
    ref.child(userId).set(user).then((user) {
      // thành công gọi hàm onSuccess
      onSuccess();
    }).catchError((err) {
      // error
      onRegisterError('Signup fail, please try again');
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print('=============');
    print(code);
    switch (code) {
      case 'invalid-email':
      case 'ERROR_INVALID_CREDENTIAL':
        onRegisterError('Invalid email');
        break;
      case 'email-already-in-use':
        onRegisterError('Email has existed');
        break;
      case 'weak-password':
        onRegisterError('The password is not strong enough');
        break;
      default:
        onRegisterError('Signup fail, please try again 11');
        break;
    }
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      // print('========= on signin in success');
      onSuccess();
    }).catchError((err) {
      onSignInError('Đăng nhập không thành công, vui lòng thử lại.');
    });
  }

  Future resetPass(String email, Function onSuccess,
      Function(String) onForgotPasswordError) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim()).then((user) {
      // print('========= on resetPass in success');

      onSuccess();
    }).catchError((err) {
      onForgotPasswordError('Email không đúng, vui lòng thử lại.');
    });

    print('========= on resetPass in success');
    print('$email');
  }
}
