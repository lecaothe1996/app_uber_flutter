import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone, Function onSuccess) {
    // tạo user
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      // tao uer thanh cong
      _createUser(user.user!.uid, name, phone, onSuccess);
      print(user);
    }).catchError((user) {
      // TODO
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = {'name': name, 'phone': phone};
    // ghi dữ liệu lên database
    var ref = FirebaseDatabase.instance.reference().child('users');
    ref.child(userId).set(user).then((user) {
      // thành công gọi hàm onSuccess
      onSuccess();
    }).catchError((err) {
      // TODO
    });
  }
}
