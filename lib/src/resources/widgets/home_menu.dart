import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/login_page.dart';
import '../../blocs/PreferenceUtils.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('ic_user.png')),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage('bgr_user.png'), fit: BoxFit.fill),
            ),
            accountName: Text(
              'Họ Và Tên',
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text('lecaothe@gmail.com')),
        // ListTile(
        //   leading: Padding(
        //     padding: EdgeInsets.only(left: 15),
        //     child: Icon(
        //       Icons.person_outline,
        //       color: Colors.blue,
        //     ),
        //   ),
        //   title: Text(
        //     'Thông tin của tôi',
        //     style: TextStyle(fontSize: 18, color: Color(0xff323643)),
        //   ),
        // ),
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
