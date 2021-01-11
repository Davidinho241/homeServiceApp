import 'package:flutter/material.dart';

class Routes {
  static final String BASE_URL = 'http://localhost:8000/api/';
  static final String REGISTER = 'user/register';

  String buildRoute(String route){
    return BASE_URL+route;
  }
}