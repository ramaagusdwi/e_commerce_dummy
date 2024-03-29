import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/favorite.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';

import '../database_helper.dart';

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
    // log("createTabelFavorite");
    await dbClient.execute('''
        CREATE TABLE IF NOT EXISTS $tabelFavorite ($kolomIdFavorite INTEGER PRIMARY KEY AUTOINCREMENT,
        $kolomIdProduk INTEGER, $kolomIdUser INTEGER,
        FOREIGN KEY ($kolomIdProduk) REFERENCES $tabelProduk($kolomIdProduk) ON DELETE CASCADE,
        FOREIGN KEY ($kolomIdUser) REFERENCES $tabelUser($kolomIdUser) ON DELETE CASCADE
        )
       ''');
  }

  Future<int> insertFavorite(Favorite favorite) async {
    // log("cek insertFavorite ${favorite.idProduk} ${favorite.idUser}");
    int res = await dbClient.insert(tabelFavorite, favorite.toMap());
    // log("insertFavorite data : $res");

    return res;
  }

  Future deleteFavorite(Favorite favorite) async {
    // Delete a record
    int count = await dbClient.rawDelete(
        'DELETE FROM $tabelFavorite WHERE $kolomIdProduk = ? AND $kolomIdUser = ?',
        [favorite.idProduk, favorite.idUser]);
    assert(count == 1);
    log("cek deleteFavorite $count");
    return count;
  }

  Future<List<Produk>> getProductFavoriteByUser(int idUser) async {
    var dbClient = await DatabaseHelper().database;
    List<Map> labels = await dbClient.rawQuery('''
      SELECT
          produk.id_produk AS id_produk,
          produk.nama AS nama_produk,
          produk.harga AS harga_produk, 
          produk.warna AS warna_produk, 
          produk.id_brand AS brand_produk, 
          produk.path_terakhir AS nama_asset_produk,
          produk.favorite AS favorite_produk
      FROM produk
      INNER JOIN favorite
      ON produk.id_produk = favorite.id_produk
      WHERE favorite.id_user=$idUser;  
      ''');
    log("produkFavorite size!: ${labels.length}");
    labels.forEach((row) => log("favoritedProduct! " + row.toString()));

    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Produk>.generate(
            labels.length,
            (i) => Produk(
                idProduk: labels[i]['id_produk'],
                nama: labels[i]['nama_produk'],
                harga: labels[i]['harga_produk'],
                idBrand: labels[i]['brand_produk'],
                pathImage: labels[i]['nama_asset_produk'],
                warnaHex: labels[i]['warna_produk'],
                favorite: labels[i]['favorite_produk']),
          )
        : <Produk>[];
  }

  clearAllData(String tableName) async {
    Database db = dbClient;
    await db.rawQuery("DELETE FROM $tableName");
  }

  //mengembalikan ID resto
  Future<Produk?> getOneFavoriteProduk(String idProduk,
      {required String idUser}) async {
    List<Map> result = await dbClient.rawQuery('''
      SELECT
          produk.id_produk AS id_produk,
          produk.nama AS nama,
          produk.harga AS harga, 
          produk.warna AS warna, 
          produk.id_brand AS id_brand, 
          produk.path_terakhir AS path_terakhir,
          produk.favorite AS favorite
      FROM produk
      INNER JOIN favorite
      ON produk.id_produk = favorite.id_produk
      WHERE favorite.id_user=$idUser AND favorite.id_produk=$idProduk;  
      ''');
    log("getOneFavoriteProduk, result QUERY $result");
    result.forEach((row) => print(row));
    if (result.length > 0) {
      return Produk.fromMapQuery(result.first);
    }
    return null;
  }
}
