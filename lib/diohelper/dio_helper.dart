import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required url,
      Map<String, dynamic>? query,
      String? token,
      String lang = 'en'}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String Lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String Lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
