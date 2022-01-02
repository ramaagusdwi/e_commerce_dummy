import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_apps_dev/models/user.dart';

class VPref {
  static String PREFERENCE_USER = "user";
  static String PREFERENCE_ID_USER = "id_user";

  static setLogin(String flag) async {
    var ref = await SharedPreferences.getInstance();
    ref.setString("isLogin", "1");
  }

  static Future<String?> isLogin() async {
    var ref = await SharedPreferences.getInstance();
    return ref.getString("isLogin");
  }

  static saveUser(Map<dynamic, dynamic> userData) async {
    var ref = await SharedPreferences.getInstance();
    ref.setString(PREFERENCE_USER, jsonEncode(userData));
  }

  static Future<User> getDataUser() async {
    var ref = await SharedPreferences.getInstance();
    return User.fromMap(jsonDecode(ref.getString(PREFERENCE_USER)!));
  }

  static saveIdUser(int id) async {
    var ref = await SharedPreferences.getInstance();
    ref.setInt(PREFERENCE_ID_USER, id);
  }

  static Future<int?> getIdUser() async {
    var ref = await SharedPreferences.getInstance();
    return ref.getInt(PREFERENCE_ID_USER);
  }

  static Future<bool> clearLoginPreference() async {
    _deleteCacheDir();
    _deleteAppDir();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  static Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
