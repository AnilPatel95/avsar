import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../logic/services/connectivity.dart';

const String BASE_URL = "https://avsar.azurewebsites.net/api";
const Map<String, dynamic> DEFAULT_HEADERS = {
  "Content-Type": "application/json"
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  Future<Response> postData(String apiEndPoint, {required String data}) async{
    try{
      final isConnected = await isInternetConnected();
      if(!isConnected){
        throw 'No internet connection';
      }
      final response = await _dio.post(apiEndPoint,data: data);
      return response;
    } on DioException catch(ex) {
        if(ex.response != null && (ex.response!.statusCode ==401 || ex.response!.statusCode == 500)  ){
          throw 'oops!! something wrong';
        }
      rethrow;
    }
  }

  Future<Response> getData(String apiEndPoint) async{
    try{
      final isConnected = await isInternetConnected();
      if(!isConnected){
        throw 'No internet connection';
      }
      final response = await _dio.get(apiEndPoint);
      return response;
    }catch(ex) {
      throw 'oops!! something wrong';
    }
  }

}

class ApiResponse {
  String? success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
        success: data["responseStatus"],
        data: data["data"],
        message: data["responseMessage"] ?? "Unexpected error");
  }
}
