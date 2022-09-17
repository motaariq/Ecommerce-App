import 'package:dio/dio.dart';
import 'package:ecommerce/shared/endPoints/endPoints.dart';

class dioHelper {
  static Dio? dio;
  static init() async {
    dio = await Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    print(url);
    return await dio!.get(url);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return dio!.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    return dio!.put(url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Authorization': token ?? ''
        }));
  }
}
