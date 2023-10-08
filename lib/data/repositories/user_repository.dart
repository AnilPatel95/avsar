import 'dart:convert';
import 'package:avsar/core/api.dart';
import 'package:avsar/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

import '../models/user/register_model.dart';

class UserRepository {
  final _api = Api();

  Future<RegisterModel> createAccount({
    required String id,
    required String userEmail,
    required String userFriendlyName,
    required String userPin
  }) async {
    try {
      Response response = await _api.postData(
        "/UserMaster/Register",
        data: jsonEncode({
          "id": id,
          "userEmail": userEmail,
          "userFriendlyName": userFriendlyName,
          "userPin": userPin,
          "pinSalt": "",
          "lastLoginDateTime": "2023-09-18T23:02:27.016Z",
          "createdDateTime": "2023-09-18T23:02:27.016Z",
        })
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(apiResponse.success!="Success") {
        throw apiResponse.message.toString();
      }

      return RegisterModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
     // throw 'oops!! something wrong';
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String pin
  }) async {
    try {
      Response response = await _api.postData(
        "/UserMaster/Login",
        data: jsonEncode({
          "userEmail": email,
          "userPin": pin
        })
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(apiResponse.success!="Success") {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      //throw 'oops!! something wrong';
      rethrow;
    }
  }

}