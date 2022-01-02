import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:test_mobile_apps_dev/data/controller_query/login_ctr.dart';
import 'package:test_mobile_apps_dev/data/controller_query/register_ctr.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/data/shared_pref/v_pref.dart';
import 'package:test_mobile_apps_dev/models/user.dart';
import 'package:test_mobile_apps_dev/ui/page/home/home_page.dart';
import 'package:test_mobile_apps_dev/ui/page/login_page.dart';

enum ResultState { Loading, Success, Failed, None }

class LoginModel extends ChangeNotifier {
  BuildContext context;

  late ResultState _resultState;

  ResultState get state => _resultState;

  String _message = "";

  String get message => _message;

  LoginModel(this.context) {
    _resultState = ResultState.None;
    notifyListeners();
  }

  Future<String> onLogin(String username, String password) async {
    late var database;
    try {
      database = await DatabaseHelper().database;
    } catch (err) {
      log("cek catch db $err");
    }
    try {
      _resultState = ResultState.Loading;
      notifyListeners();
      var loginController = LoginCtr(dbClient: database);
      User? user = await loginController.getLogin(username, password);
      if (user != null) {
        print("cek user ditemukan");
        print("cek iduser ${user.idUser}");
        Map<String, dynamic> userMap = user.toMap();
        VPref.saveUser(userMap);
        VPref.saveIdUser(user.idUser);
        _resultState = ResultState.Success;
        notifyListeners();
        return _message = "Cannot find the account!";
        //show dialog welcome alert
      } else {
        print("cek user tidak ditemukan");
        _resultState = ResultState.Failed;
        notifyListeners();
        return _message = "Cannot find the account!";
      }
    } catch (err) {
      log("cek catch $err");
      _resultState = ResultState.Failed;
      notifyListeners();
      return _message = "Error tidak diketahui!";
    }
  }
}
