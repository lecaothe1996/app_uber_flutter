import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/src/resources/widgets/home_menu.dart';
import 'package:uber_app/src/resources/widgets/ride_picker.dart';

import '../model/place_item_res.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(10.7915178, 106.7271422), zoom: 14.4746),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text(
                      'Uber App',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        print('Click menu');
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {
                          print('Click nitifi');
                        },
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
  }
}
