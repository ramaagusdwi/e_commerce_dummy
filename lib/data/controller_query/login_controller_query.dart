import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/user.dart';

class LoginCtr {
  final Database dbClient;

  LoginCtr({required this.dbClient});

  Future<Map<dynamic, dynamic>?> getLogin(String user, String password) async {
    List<Map> result = await dbClient.rawQuery(
        'SELECT * FROM user WHERE nama_user=? and password=?',
        ['$user', '$password']);

    // log("cek UserFound $result");
    //print each user
    result.forEach((row) => print(row));

    //save user to sharef preferences

    if (result.length > 0) {
      print("user ada");
      log("cekuser ${result.first}");

      // VPref.saveUser(result.first);
      // return new User.fromMap(result.first);
      return result.first;
    }
    print("user tidak ada");
    return null;
  }

  //get all user inside table
  Future<List<User>?> getAllUser() async {
    var res = await dbClient.query("user");
    List<User>? list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}
