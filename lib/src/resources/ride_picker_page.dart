import 'package:flutter/material.dart';
import 'package:uber_app/src/blocs/place_bloc.dart';
import '../model/place_item_res.dart';

class RidePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(PlaceItemRes, bool) onSelected;
  final bool _isFromAddress;

  RidePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  State<RidePickerPage> createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addRessController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addRessController = TextEditingController(text: widget.selectedAddress);
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
                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                          child: widget._isFromAddress
                              ? Icon(Icons.navigation_outlined, color: Colors.blue)
                              : Icon(Icons.location_on, color: Colors.red),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffF6F6F6),
                padding: EdgeInsets.only(top: 0),
                child: StreamBuilder<List<PlaceItemRes>>(
                    stream: placeBloc.placeStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if ((snapshot.data?.length ?? 0) < 1) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<PlaceItemRes>? places = snapshot.data;
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(places!.elementAt(index).name),
                                subtitle: Text(places.elementAt(index).address),
                                onTap: () {
                                  print("click ListTile");
                                  Navigator.of(context).pop();
                                  widget.onSelected(places.elementAt(index), widget._isFromAddress);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                                  height: 1,
                                  color: Color(0xff000000),
                                ),
                            itemCount: places?.length ?? 0);
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
