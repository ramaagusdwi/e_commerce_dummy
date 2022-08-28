import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/data/controller_query/favorite_controller_query.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_controller_query.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/data/shared_pref/v_pref.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';

enum ResultProductDetailState { Loading, Success, hasError, NoData }

class ProductDetailProvider extends ChangeNotifier {
  late Database database;
  late FavoriteCtr favoriteCtr;
  final String id;
  late Color _color;

  late ResultProductDetailState _resultState;

  ResultProductDetailState get state => _resultState;

  Color get color => _color;

  ProductDetailProvider({required this.id}) {
    init();
  }

  Future<void> init() async {
    _resultState = ResultProductDetailState.Loading;
    notifyListeners();

    database = await DatabaseHelper().database;
    favoriteCtr = FavoriteCtr(dbClient: database);
    setColorIconFavorite();

    _resultState = ResultProductDetailState.Success;
    notifyListeners();
  }

  Future<Produk?> cekFavoriteProdukExistLocalDB(String idFavorite) async {
    var user = await VPref.getDataUser();
    var resto = await favoriteCtr.getOneFavoriteProduk(idFavorite,
        idUser: user.idUser.toString());
    return resto;
  }

  void setColorIconFavorite() {
    cekFavoriteProdukExistLocalDB(id).then((value) {
      if (value == null) {
        print("data resto tidak ada");
        _color = Colors.grey;
        notifyListeners();
      } else {
        print("data resto ada");
        _color = Colors.pink;
        notifyListeners();
      }
    });
  }

  //konsepe kayak switch/toggle
  void switchColor() {
    cekFavoriteProdukExistLocalDB(id).then((value) {
      if (value == null) {
        print("data resto tidak ada");
        _color = Colors.pink;
        notifyListeners();
      } else {
        print("data resto ada");
        _color = Colors.grey;
        notifyListeners();
      }
    });
  }
}
