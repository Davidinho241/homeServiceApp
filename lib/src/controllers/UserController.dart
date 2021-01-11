import 'dart:convert';
import 'Controller.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_ui_kit/src/models/User.dart';

class UserController extends Controller{

  Future<User> register(String route, List data) async {
    print('data send : $data');
    final http.Response response = await Controller().makeRequest(route, data);

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('data receive : '+response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load user');
    }
  }

  Future<User> login(){

  }

  Future<User> logout(){

  }

  Future<User> me(){

  }

  Future<User> forgotPassword(){

  }

  Future<User> ResetPassword(){

  }

  Future<User> verifyOTP(){

  }

}