import 'package:flutter/material.dart';
import 'package:uber_app/src/resources/ride_picker_page.dart';
import '../../model/place_item_res.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;

  RidePicker(this.onSelected);

  @override
  State<RidePicker> createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes? fromAddress;
  PlaceItemRes? toAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            // offset: Offset(0, 5),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                print('click To');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RidePickerPage(toAddress == null ? "" : toAddress!.name,
                                (place, isFrom) {
                              widget.onSelected(place, isFrom);
                              toAddress = place;
                              setState(() {});
                            }, false)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 50,
                      child: Center(
                        child:
                        Icon(Icons.location_on, color: Colors.red),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 20,
                      height: 50,
                      child: Center(
                        child: Icon(Icons.navigate_next, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 15),
                      child: Text(
                        // 'Home',
                        toAddress == null ? "Chọn địa chỉ đến" : toAddress!.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                print('click from');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RidePickerPage(
                            fromAddress == null ? "" : fromAddress!.name,
                            (place, isFrom) {
                          widget.onSelected(place, isFrom);
                          fromAddress = place;
                          setState(() {});
                        }, true)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 50,
                      child: Center(
                        child: Icon(Icons.navigation_outlined, color: Colors.blue),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 20,
                      height: 50,
                      child: Center(
                        child: Icon(Icons.navigate_next, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 15),
                      child: Text(
                        // '847a, Tạ Quang Bửu, P5, Q8, TP.HCM',
                        fromAddress == null ? "Chọn địa chỉ bắt đầu" : fromAddress!.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
