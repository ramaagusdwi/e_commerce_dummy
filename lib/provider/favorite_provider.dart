import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:test_mobile_apps_dev/data/controller_query/favorite_controller_query.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_controller_query.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/data/shared_pref/v_pref.dart';
import 'package:test_mobile_apps_dev/models/brand.dart';
import 'package:test_mobile_apps_dev/models/favorite.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';

enum ResultStateFavorite { Loading, Success, Failed, None }

class FavoriteProvider extends ChangeNotifier {
  BuildContext context;
  late ResultStateFavorite _resultState;

  ResultStateFavorite get state => _resultState;

  String _message = "";

  String get message => _message;

  late var database;

  List<Produk> favoriteProductList = [];

  FavoriteProvider(this.context) {
    init();
  }

  Future<void> init() async {
    _resultState = ResultStateFavorite.Loading;
    notifyListeners();

    database = await DatabaseHelper().database;

    log(database,name: 'cekDatabase');

    //load product favorited by user
    showFavoriteProduk();

    _resultState = ResultStateFavorite.Success;
    notifyListeners();
  }

  Future<void> saveFavorite(Produk produk) async {
    print("setFavorite!");
    _resultState = ResultStateFavorite.Loading;
    notifyListeners();

    try {
      var db = await DatabaseHelper().database;
      var con = FavoriteCtr(dbClient: db);
      var user = await VPref.getDataUser();
      print("cek produk id  ${produk.idProduk}");
      var favorite = Favorite(idProduk: produk.idProduk!, idUser: user.idUser);
      int insert = await con.insertFavorite(favorite);
      if (insert > 0) {
        log("success insert");
        // var produkCon = ProdukCtr(dbClient: db);
        // List<Produk> listProduk = await produkCon
        //     .getProduk(); //show produk berdasarkan favorite dari user
        _resultState = ResultStateFavorite.Success;
      } else {
        log("failed insert");
        // emit(FailedState('Failed favorites'));
        _resultState = ResultStateFavorite.Failed;
      }
    } catch (err) {
      print("catch setFavorite $err");
      // emit(FailedState('An unknown error occured'));
    }
  }

  Future<void> showFavoriteProduk() async {
    _resultState = ResultStateFavorite.Loading;
    notifyListeners();

    try {
      var db = await DatabaseHelper().database;
      var con = FavoriteCtr(dbClient: db);
      var user = await VPref.getDataUser();

      // log("cekIDUser ${user.idUser}");

      favoriteProductList.clear();
      favoriteProductList = await con.getProductFavoriteByUser(user.idUser);

      for (final i in favoriteProductList) {
        // log('cekFavoriteProduct: $i}');
      }

      _resultState = ResultStateFavorite.Success;
      notifyListeners();
    } catch (err) {
      // print("catch showFavoriteProduk $err");
      _resultState = ResultStateFavorite.Failed;
      _message = err.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Produk produk) async {
    print("removeFavorite!");
    _resultState = ResultStateFavorite.Loading;
    notifyListeners();

    try {
      var db = await DatabaseHelper().database;
      var con = FavoriteCtr(dbClient: db);

      var user = await VPref.getDataUser();

      var favorite = Favorite(idProduk: produk.idProduk!, idUser: user.idUser);

      int insert = await con.deleteFavorite(favorite);
      if (insert > 0) {
        log("success remove");
        _resultState = ResultStateFavorite.Success;
      } else {
        log("failed remove");
        _resultState = ResultStateFavorite.Failed;
      }
      notifyListeners();

    } catch (err) {
      print("catch removeFavorite $err");
      _resultState = ResultStateFavorite.Failed;
      _message = err.toString();
      notifyListeners();
    }
  }
}
