import 'dart:ffi';

class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;
  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
    List<PlaceItemRes> rs = [];
    var results = json['results'] as List;
    // print("results -----");
    for (var item in results) {
      var p = new PlaceItemRes(
          item['name'] as String,
          item['formatted_address'] as String,
          item['geometry']['location']['lat'] as double,
          item['geometry']['location']['lng']as double);

      rs.add(p);
    }

    return rs;
  }
}

