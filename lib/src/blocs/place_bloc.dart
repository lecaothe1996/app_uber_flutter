import 'dart:async';
import '../repository/place_service.dart';


class PlaceBloc {
  var _placeController = StreamController();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    print("key nhap vao: " + keyword);

    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((rs) {
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