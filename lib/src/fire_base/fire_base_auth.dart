import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> upLoadImage() async {
    try {
      // Pick an image
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // Crop image
      if (image != null) {
        final CroppedFile? cropImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          cropStyle: CropStyle.circle,
          compressQuality: 100,
          maxHeight: 500,
          maxWidth: 500,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cắt Ảnh',
                toolbarColor: Colors.blue,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,),
            IOSUiSettings(
              title: 'Cắt Ảnh',
            ),
          ],
        );
        // print('Image picker: $cropImage');
        //get Uid User
        User? cuser = await _firebaseAuth.currentUser;
        //upload image to firebase storage
        await FirebaseStorage.instance.ref("users/${cuser!.uid}/images/${cuser.uid}").putFile(File(cropImage!.path));
        final imageUrl = await FirebaseStorage.instance.ref("users/${cuser.uid}/images/${cuser.uid}").getDownloadURL();
        print('image url updated: ${imageUrl.toString()}');
        return imageUrl;
      }
    } on FirebaseAuthException catch (e) {
      print('loi upload image: ${e.message}');
    }
  }

  Future<String?> getImage() async {
    try {
      User? cuser = await _firebaseAuth.currentUser;
      // print('User cuser: ${cuser}');

      final imageUrl = await FirebaseStorage.instance.ref("users/${cuser!.uid}/images/${cuser.uid}").getDownloadURL();
      // print('url image: ${imageUrl.toString()}');

      return imageUrl.toString();
    } on FirebaseAuthException catch (e) {
      print('Lỗi get Image: ${e.message}');
    }
    return null;
  }

  Future<String?> getUserName() async {
    try {
      User? cuser = await _firebaseAuth.currentUser;
      // print('User cuser: ${cuser}');
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${cuser!.uid}/name");
      // Get the data once
      DatabaseEvent event = await ref.once();
      // Print the data of the snapshot
      // print('UserName: ${event.snapshot.value}');
      return event.snapshot.value.toString();
    } on FirebaseAuthException catch (e) {
      print('Lỗi getUserName: ${e.message}');
    }
    return null;
  }

  Future<String?> getCurrentUserEmail() async {
    try {
      // get userEmail
      final userEmail = await _firebaseAuth.currentUser?.email;
      // print('User Email: ${userEmail}');
      return userEmail;
    } on FirebaseAuthException catch (e) {
      // print('Failed get userEmail: ${e.code}');
      print('Lỗi getCurrentUserEmail: ${e.message}');
    }
    return null;
  }

  void signUp(
      String email, String pass, String name, String phone, Function onSuccess, Function(String) onRegisterError) {
    // tạo user
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass).then((user) {
      // tao uer thanh cong
      _createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
      print(user);
    }).catchError((err) {
      // error
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess, Function(String) onRegisterError) {
    var user = {'name': name, 'phone': phone};
    // ghi dữ liệu lên database
    var ref = FirebaseDatabase.instance.reference().child('users');
    ref.child(userId).set(user).then((user) {
      // thành công gọi hàm onSuccess
      onSuccess();
    }).catchError((err) {
      // error
      onRegisterError('Đăng ký không thành công, vui lòng thử lại');
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print('=============');
    print(code);
    switch (code) {
      case 'invalid-email':
      case 'ERROR_INVALID_CREDENTIAL':
        onRegisterError('Email không hợp lệ');
        break;
      case 'email-already-in-use':
        onRegisterError('Email đã tồn tại');
        break;
      case 'weak-password':
        onRegisterError('Mật khẩu không đủ mạnh');
        break;
      default:
        onRegisterError('Đăng ký không thành công, vui lòng thử lại');
        break;
    }
  }

  void signIn(String email, String pass, Function onSuccess, Function(String) onSignInError) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      // print('========= on signin in success');
      onSuccess();
    }).catchError((err) {
      onSignInError('Email hoặc mật khẩu không đúng, vui lòng thử lại.');
    });
  }

  Future resetPass(String email, Function onSuccess, Function(String) onForgotPasswordError) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim()).then((user) {
      // print('========= on resetPass in success');

      onSuccess('Liên kết đặt lại mật khẩu đã được gửi! Kiểm tra Email của bạn.');
    }).catchError((err) {
      onForgotPasswordError('Email không đúng, vui lòng thử lại.');
    });

    // print('========= on resetPass in success');
    // print('$email');
  }
}
