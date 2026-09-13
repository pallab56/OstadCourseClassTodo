import 'dart:convert';

import 'package:classtodoapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userData;

  static Future saveUserData(UserModel model, String tokenValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', tokenValue);
    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));

    token = tokenValue;
    userData = model;
  }

  static Future updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));
    userData = model;
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? savedToken = sharedPreferences.getString('token');
    if (savedToken != null) {
      token = savedToken;
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

  static Future<void> logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
  }
}
