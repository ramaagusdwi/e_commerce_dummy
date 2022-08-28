import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/save_user.dart';
import 'package:test_mobile_apps_dev/models/user.dart';

import '../database_helper.dart';

class RegisterCtr {
  final Database dbClient;

  RegisterCtr({required this.dbClient});

//insertion
//   Future<int> saveUser(User user) async {
//     int res = await dbClient.insert('user', user.toMap());
//     return res;
//   }
  Future<int> saveUser(InfoUser user) async {
    int res = await dbClient.insert('user', user.toMap());
    return res;
  }
}
