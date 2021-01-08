import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';

class HotelService {
  Future<List<Hotel>> loadHotels() async {
    // await Future.delayed(Duration(milliseconds: 4500));
    var result = await rootBundle.loadString('assets/json/hotels_en.json');
    var datas = (json.decode(result) as List)
        .map<Hotel>((json) => Hotel.fromJson(json))
        .toList();
    return datas;
  }
}
