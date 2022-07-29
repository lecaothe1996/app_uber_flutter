import 'dart:async';
import '../model/place_item_res.dart';
import '../repository/place_service.dart';


class PlaceBloc {
  var _placeController = StreamController<List<PlaceItemRes>>();
  Stream<List<PlaceItemRes>> get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    // print("key nhap vao: " + keyword);
    _placeController.sink.add([]);

    PlaceService.searchPlace(keyword).then((rs) {
      print('rs.length');
      rs.forEach((element) {
        print('object');
        print(element.address);
      });
      print(rs.length);
      _placeController.sink.add(rs);
    }).catchError((Object error) {
     // _placeController.sink.add("stop");
      print('loiiiiiiiiiiiiiiiii');
      // return null;
    });
  }

  void dispose() {
    _placeController.close();
  }
}