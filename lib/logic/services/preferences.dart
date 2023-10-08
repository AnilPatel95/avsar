import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
    log("Details saved!");
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {
      "email": email,
      "password": password
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }

  static Future<void> saveToken(String token,String refreshToken) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("token", token);
    await instance.setString("refreshToken", refreshToken);
    log("Details saved!");
  }
  static Future<Map<String, dynamic>> fetchToken() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? token = instance.getString("token");
    String? refreshToken = instance.getString("refreshToken");
    return {
      "token": token,
      "refreshToken": refreshToken
    };
  }
}