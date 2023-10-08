import 'package:avsar/core/constants.dart';
import 'package:avsar/logic/services/preferences.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:avsar/logic/services/preferences.dart';
import '../logic/services/connectivity.dart';

const String BASE_URL = "https://avsar.azurewebsites.net/api";
const Map<String, dynamic> DEFAULT_HEADERS = {
  "Content-Type": "application/json",
  "Authorization" :'Bearer'
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
        throw Constants.NO_INTERNET;
      }
      final response = await _dio.post(apiEndPoint,data: data);
      return response;
    } on DioException catch(ex) {
        if(ex.response != null && (ex.response!.statusCode ==401 || ex.response!.statusCode == 500)  ){
          throw Constants.API_ERROR_MESSAGE;
        }
      rethrow;
    }
  }

  Future<Response> getData(String apiEndPoint) async{
    try{
      final isConnected = await isInternetConnected();
      if(!isConnected){
        throw Constants.NO_INTERNET;
      }
      final response = await _dio.get(apiEndPoint);
      return response;
    }catch(ex) {
      throw Constants.API_ERROR_MESSAGE;
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
        success: data[SUCCESS],
        data: data[DATA],
        message: data[MESSAGE] ?? "Unexpected error");
  }
  static const String SUCCESS = "responseStatus";
  static const String DATA = "data";
  static const String MESSAGE = "responseMessage";
}
