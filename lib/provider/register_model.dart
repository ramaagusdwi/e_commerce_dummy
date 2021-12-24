import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:test_mobile_apps_dev/data/controller_query/register_ctr.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/models/user.dart';
import 'package:test_mobile_apps_dev/ui/page/home/home_page.dart';
import 'package:test_mobile_apps_dev/ui/page/login_page.dart';
import 'package:test_mobile_apps_dev/utils/utils.dart';

enum ResultState { Loading, Success, Failed, None }

class RegisterModel extends ChangeNotifier {
  BuildContext context;

  late ResultState _resultState;

  ResultState get state => _resultState;

  String _message = "";

  String get message => _message;

  RegisterModel(this.context) {
    _resultState = ResultState.None;
    notifyListeners();
  }

  Future<String> onRegister(String nama, String password, String email,
      String noTelp, String tglLahir) async {
    var database = await DatabaseHelper().database;

    try {
      _resultState = ResultState.Loading;
      notifyListeners();
      var registerController = RegisterCtr(dbClient: database);
      User user = User(
          nama: nama,
          password: password,
          email: email,
          telepon: noTelp,
          tanggalLahir: tglLahir);
      int? saveUser = await registerController.saveUser(user);
      if (saveUser != 0) {
        _resultState =
            ResultState.Success; //jika state sukses , indikator loading hilang
        notifyListeners();
        log("Sukses mendaftarkan user!");
        // Navigator.pushReplacementNamed(context, LoginPage.route);
        return _message = "Sukses mendaftarkan user!";
      } else {
        _resultState = ResultState.Failed;
        notifyListeners();
        log("Gagal mendaftarkan user!");
        return _message = "Gagal mendaftarkan user!";
      }
    } catch (err) {
      log("Masuk catch $err");
      _resultState = ResultState.Failed;
      notifyListeners();
      return _message = "Error tidak diketahui!";
    }
  }
}
