import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPrefenece;

  static init()async{
    sharedPrefenece =await SharedPreferences.getInstance();
  }


  static Future getDate({required String key})async{
    return sharedPrefenece!.get(key);
  }

static Future removeData({required String key})async{
    return sharedPrefenece!.remove(key);
  }

  static Future saveDate({required String key,required dynamic value})async{
    if(value is String) return await sharedPrefenece!.setString(key, value);
    if(value is int) return await sharedPrefenece!.setInt(key, value);
    if(value is bool) return await sharedPrefenece!.setBool(key, value);
    return await sharedPrefenece!.setDouble(key, value);
  }

}
