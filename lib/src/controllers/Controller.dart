import 'dart:convert';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hotel_ui_kit/src/env/routes.dart';
import 'package:http/http.dart' as http;

class Controller extends ControllerMVC{

  static final String mediaType = 'application/json; charset=UTF-8';

  Future<http.Response> makeRequest(String route, List data) async{
    print('route: ' +Routes().buildRoute(route));
    return await http.post(
      Routes().buildRoute(route),
      headers: <String, String>{
        'Content-Type': mediaType,
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> fetchRequest(String route) async {
    return await http.get(Routes().buildRoute(route));
  }

}