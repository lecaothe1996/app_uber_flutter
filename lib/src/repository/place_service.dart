import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/place_item_res.dart';


class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            'AIzaSyDNWdUqfRyD5Cb4xDQOfivlB-yp_Q1zxbE' +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);

    // print("search >>: " + url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // print("searchPlace  >> res.body : " + res.body);
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return [];
    }
  }
}