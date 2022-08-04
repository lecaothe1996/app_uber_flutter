import 'package:flutter/material.dart';

import '../../blocs/auth_bloc.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: [
                FlatButton(
                    color: Color(0xff3277D8),
                    onPressed: () {
                      Navigator.of(context).pop(MsgDialog);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ],
            ));
  }
}
