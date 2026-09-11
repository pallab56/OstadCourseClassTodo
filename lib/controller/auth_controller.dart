import 'dart:convert';

import 'package:classtodoapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userData;

  static Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', token);
    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));

    token = token;
    userData = model;
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    if (token != null) {
      token = token;
    }

    String? user = sharedPreferences.getString('user_data');
    if (user != null) {
      userData = UserModel.fromJson(jsonDecode(user));
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    return token != null;
  }
}
