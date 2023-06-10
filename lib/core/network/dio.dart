import 'package:dio/dio.dart';
import 'package:merostore/core/network/apis.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: AppApis.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json'}),);
  }


  static Future<Response> postData({required String url, required Map<String, dynamic> data, Map<String, dynamic>? query,}) async
  {
    var token  =  await CacheHelper.getDate(key: 'token');
    var lang  =  await CacheHelper.getDate(key: 'lang');
    dio.options.headers = {"lang": lang, 'Authorization': token};
    return dio.post(url, data: data, queryParameters: query);
  }


  static Future<Response> putData({required String url, required Map<String, dynamic> data, Map<String, dynamic>? query,}) async
  {
    var token  =  await CacheHelper.getDate(key: 'token');
    var lang  =  await CacheHelper.getDate(key: 'lang');
    dio.options.headers = {"lang": lang, 'Authorization': token};
    return dio.put(url, data: data, queryParameters: query);
  }



  static Future<Response> getData({required String url, Map<String, dynamic>? query,}) async
  {
    var token  =  await CacheHelper.getDate(key: 'token');
    var lang  =  await CacheHelper.getDate(key: 'lang');
    dio.options.headers = {"lang": lang, 'Authorization': token};
    return dio.get(url, queryParameters: query);
  }


}
