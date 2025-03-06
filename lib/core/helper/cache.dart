
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setToken(String token) async {
    await sharedPreferences.setString("token", token);
  }

  static String? getToken() {
    return sharedPreferences.getString("token");
  }

  static Future removeToken() {
    return sharedPreferences.remove("token");
  }

  static String? getID() {
    return sharedPreferences.getString("ID");
  }
}