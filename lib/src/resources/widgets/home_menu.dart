import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/dialog/loading_dialog.dart';
import 'package:uber_app/src/resources/login_page.dart';
import '../../blocs/PreferenceUtils.dart';
import '../../blocs/auth_bloc.dart';
import '../dialog/msg_dialog.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: FutureBuilder<String?>(
                    future: authBloc.getImage(),
                    builder: (context, snapshot) {
                      print('Image: ${snapshot.data.toString()}');
                      if (snapshot.hasData) {
                        // LoadingDialog.hideLoadingDialog(context);
                        return Image.network(snapshot.data.toString());
                      }
                      return Image.asset('ic_user.png');
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      color: Colors.grey,
                      onPressed: () {
                        print('click image');
                        authBloc.upLoadImage();
                        // LoadingDialog.showLoadingDialog(context, "Đang tải...");
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 16,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(image: AssetImage('bgr_user.png'), fit: BoxFit.fill),
          ),
          accountName: FutureBuilder<String?>(
            future: authBloc.getUserName(),
            builder: (context, snapshot) {
              return Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 18),
              );
            },
          ),
          accountEmail: FutureBuilder<String?>(
            future: authBloc.getCurrentUserEmail(),
            builder: (context, snapshot) {
              return Text(snapshot.data.toString());
            },
          ),
        ),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.history,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Lịch sử đi xe',
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.local_offer_outlined,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Ưu đãi',
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Thông báo',
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
          trailing: ClipOval(
            child: Container(
              width: 18,
              height: 18,
              color: Colors.red,
              child: Center(
                child: Text(
                  '8',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Divider(),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.help_outline,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Trợ giúp & Hỗ trợ',
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
            PreferenceUtils.clearData();
          },
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.logout_outlined,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
      ],
    );
  }
}
