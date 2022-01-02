import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/favorite.dart';

class FavoriteCtr {
  final Database dbClient;

  FavoriteCtr({required this.dbClient});

  String tabelFavorite = 'favorite';
  String kolomIdFavorite = 'id_favorite';

  String tabelProduk = 'produk';
  String kolomIdProduk = 'id_produk';

  String kolomIdUser = 'id_user';
  String tabelUser = 'user';

  Future<void> addTabelFavorite() async {
    log("createTabelFavorite");
    await dbClient.execute('''
        CREATE TABLE IF NOT EXISTS $tabelFavorite ($kolomIdFavorite INTEGER PRIMARY KEY AUTOINCREMENT,
        $kolomIdProduk INTEGER, $kolomIdUser INTEGER,
        FOREIGN KEY ($kolomIdProduk) REFERENCES $tabelProduk($kolomIdProduk) ON DELETE CASCADE,
        FOREIGN KEY ($kolomIdUser) REFERENCES $tabelUser($kolomIdUser) ON DELETE CASCADE
        )
       ''');
  }

  Future<int> insertFavorite(Favorite favorite) async {
    log("cek insertFavorite ${favorite.idProduk} ${favorite.idUser}");
    int res = await dbClient.insert(tabelFavorite, favorite.toMap());
    log("insertFavorite data : $res");

    return res;
  }

  Future deleteFavorite(Favorite favorite) async {
    // Delete a record
    int count = await dbClient.rawDelete(
        'DELETE FROM $tabelFavorite WHERE name = ?', [favorite.idProduk]);
    assert(count == 1);
    return count;
  }

  clearAllData(String tableName) async {
    Database db = dbClient;
    await db.rawQuery("DELETE FROM $tableName");
  }
}
