import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/login_page.dart';

import '../utils/PreferenceUtils.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.person_outline,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xff323643)
            ),
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
            'Ride History',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff323643)
            ),
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
            'Offers',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff323643)
            ),
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
            'Notifications',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff323643)
            ),
          ),
        ),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.help_outline,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Help & Support',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff323643)
            ),
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
            'Logout',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff323643)
            ),
          ),
        ),
      ],
    );
  }
}
