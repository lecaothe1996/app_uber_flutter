import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              child: Container(
                height: 100,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        msg,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}
