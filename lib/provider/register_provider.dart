import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:test_mobile_apps_dev/data/controller_query/register_controller_query.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/models/save_user.dart';

enum ResultState { Loading, Success, Failed, None }

class RegisterProvider extends ChangeNotifier {
  BuildContext context;

  late ResultState _resultState;

  ResultState get state => _resultState;

  String _message = "";

  String get message => _message;

  RegisterProvider(this.context) {
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
      InfoUser user = InfoUser(
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
