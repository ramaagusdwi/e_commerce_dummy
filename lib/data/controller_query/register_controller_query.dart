import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/save_user.dart';

class RegisterCtr {
  final Database dbClient;

  RegisterCtr({required this.dbClient});

  Future<int> saveUser(InfoUser user) async {
    int res = await dbClient.insert('user', user.toMap());
    return res;
  }
}
