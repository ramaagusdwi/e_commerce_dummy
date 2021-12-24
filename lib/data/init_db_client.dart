import 'package:sqflite/sqlite_api.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';

class InitDatabase {
  late var _dbClient;

  InitDatabase() {
    setupDbClient();
  }

  void setupDbClient() async {
    DatabaseHelper con = new DatabaseHelper();
    _dbClient = await con.database;
  }

  Database get db {
    return _dbClient;
  }
}
