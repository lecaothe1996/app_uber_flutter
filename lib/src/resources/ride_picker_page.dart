import 'package:flutter/material.dart';
import 'package:uber_app/src/blocs/place_bloc.dart';

import '../model/place_item_res.dart';

class RidePickerPage extends StatefulWidget {
  const RidePickerPage({Key? key}) : super(key: key);

  @override
  State<RidePickerPage> createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addRessController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addRessController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black12,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 60,
                        child: Center(
                          child: Icon(Icons.location_on),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                _addRessController.text = '';
                              },
                              icon: Icon(Icons.close)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addRessController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (str) {
                            placeBloc.searchPlace(str);
                          },
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 20),
            //   child: StreamBuilder(
            //       stream: placeBloc.placeStream,
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           print('-------------');
            //           print('---------the:'+snapshot.data.toString());
            //           if (snapshot.data == "start") {
            //             return Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           }
            //
            //           print(snapshot.data.toString());
            //           List<PlaceItemRes> places = snapshot.data;
            //           return ListView.separated(
            //               shrinkWrap: true,
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   title: Text(places.elementAt(index).name),
            //                   subtitle: Text(places.elementAt(index).address),
            //                   onTap: () {
            //                     print("on tap");
            //                   },
            //                 );
            //               },
            //               separatorBuilder: (context, index) => Divider(
            //                     height: 1,
            //                     color: Color(0xfff5f5f5),
            //                   ),
            //               itemCount: places.length);
            //         } else {
            //           return Container();
            //         }
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
