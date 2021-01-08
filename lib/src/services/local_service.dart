import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotel_ui_kit/src/models/BlogModel.dart';
import 'package:hotel_ui_kit/src/models/BookingHistory.dart';
import 'package:hotel_ui_kit/src/models/FaqModel.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/models/NotificationModel.dart';
import 'package:hotel_ui_kit/src/models/PlaceModel.dart';
import 'package:hotel_ui_kit/src/models/PromoModel.dart';

class LocalService {
  static Future<List<Hotel>> loadHotels(bool hold) async {
    if (hold) await Future.delayed(Duration(milliseconds: 4500));
    var result = await rootBundle.loadString('assets/json/data/hotels.json');
    var datas = (json.decode(result) as List)
        .map<Hotel>((json) => Hotel.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<Place>> loadPlaces() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var result = await rootBundle.loadString('assets/json/data/places.json');
    var datas = (json.decode(result) as List)
        .map<Place>((json) => Place.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<Blog>> loadBlogs() async {
    await Future.delayed(Duration(milliseconds: 7000));
    var result = await rootBundle.loadString('assets/json/data/blogs.json');
    var datas = (json.decode(result) as List)
        .map<Blog>((json) => Blog.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<FaqModel>> loadFaqs() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var result = await rootBundle.loadString('assets/json/data/faqs.json');
    var datas = (json.decode(result) as List)
        .map<FaqModel>((json) => FaqModel.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<PromoModel>> loadDeals() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var result = await rootBundle.loadString('assets/json/data/deals.json');
    var datas = (json.decode(result) as List)
        .map<PromoModel>((json) => PromoModel.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<NotificationModel>> loadNotifications() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var result =
        await rootBundle.loadString('assets/json/data/notifications.json');
    var datas = (json.decode(result) as List)
        .map<NotificationModel>((json) => NotificationModel.fromJson(json))
        .toList();
    return datas;
  }

  static Future<List<BookingHistory>> loadBookingHistory() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var result = await rootBundle.loadString('assets/json/data/history.json');
    var datas = (json.decode(result) as List)
        .map<BookingHistory>((json) => BookingHistory.fromJson(json))
        .toList();
    return datas;
  }
}
