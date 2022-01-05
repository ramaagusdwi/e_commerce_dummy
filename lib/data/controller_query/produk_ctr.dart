import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/models/user.dart';

import '../database_helper.dart';

class ProdukCtr {
  final Database dbClient;

  ProdukCtr({required this.dbClient});

  String tabelProduk = 'produk';
  String kolomIdProduk = 'id_produk';
  String kolomHarga = 'harga';
  String kolomNamaProduk = 'nama_produk';
  String kolomPathTerakhir = 'path_terakhir';
  String kolomWarna = 'warna';
  String kolomFavorite = 'favorite';

  String kolomIdBrand = 'id_brand';
  String tabelBrand = 'brand';

  String kolomIdUser = 'id_user';
  String tabelUser = 'user';

  Future<void> addTabelProduk() async {
    await dbClient.execute('''
        CREATE TABLE IF NOT EXISTS $tabelProduk ($kolomIdProduk INTEGER PRIMARY KEY AUTOINCREMENT,
        $kolomNamaProduk TEXT, $kolomHarga INTEGER, $kolomIdBrand INTEGER, $kolomPathTerakhir TEXT,
        $kolomWarna TEXT, $kolomFavorite INTEGER,
        FOREIGN KEY ($kolomIdBrand) REFERENCES $tabelBrand($kolomIdBrand) ON DELETE CASCADE
        )
       ''');
  }

  Future insertBanyakProduk(List<Produk> produkList) async {
    clearAllData(tabelProduk);
    for (int i = 0; i < produkList.length; i++) {
      insertProduk(produkList[i]);
    }
  }

  Future<int> insertProduk(Produk produk) async {
    int res = await dbClient.insert(
      tabelProduk,
      produk.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future getProduk() async {
    // log("select data Produk");
    List<Map> labels = await dbClient.rawQuery('SELECT * FROM $tabelProduk');
    // print("cek data length ${labels.length} from $tabelProduk");
    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Produk>.generate(
            labels.length,
            (i) => Produk(
                  idProduk: labels[i][kolomIdProduk],
                  nama: labels[i][kolomNamaProduk],
                  harga: labels[i][kolomHarga],
                  idBrand: labels[i][kolomIdBrand],
                  pathImage: labels[i][kolomPathTerakhir],
                  warnaHex: labels[i][kolomWarna],
                  favorite: labels[i][kolomFavorite],
                ))
        : <Produk>[];
  }

  Future showProdukBerdasarkanBrand(int idBrand) async {
    String query = '''SELECT * FROM $tabelProduk
        WHERE $kolomIdBrand=$idBrand 
        ''';
    List<Map> labels = await dbClient.rawQuery(query);
    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Produk>.generate(
            labels.length,
            (i) => Produk(
              idProduk: labels[i][kolomIdProduk],
              nama: labels[i][kolomNamaProduk],
              harga: labels[i][kolomHarga],
              idBrand: labels[i][kolomIdBrand],
              pathImage: labels[i][kolomPathTerakhir],
              warnaHex: labels[i][kolomWarna],
              favorite: labels[i][kolomFavorite],
            ),
          )
        : <Produk>[];
  }

  Future showProdukBerdasarkanBrandDanKeyword(int idBrand, ) async {
    String query = '''SELECT * FROM $tabelProduk
        WHERE $kolomIdBrand=$idBrand 
        ''';
    List<Map> labels = await dbClient.rawQuery(query);
    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Produk>.generate(
      labels.length,
          (i) => Produk(
        idProduk: labels[i][kolomIdProduk],
        nama: labels[i][kolomNamaProduk],
        harga: labels[i][kolomHarga],
        idBrand: labels[i][kolomIdBrand],
        pathImage: labels[i][kolomPathTerakhir],
        warnaHex: labels[i][kolomWarna],
        favorite: labels[i][kolomFavorite],
      ),
    )
        : <Produk>[];
  }


  clearAllData(String tableName) async {
    Database db = dbClient;
    await db.rawQuery("DELETE FROM $tableName");
  }

  Future updateProductFavorite(int idProduk, {int favorite = 1}) async {
    // print("cek idProduk $idProduk");
    Map<String, dynamic> row = {
      kolomFavorite: favorite,
    };
    int count = await dbClient.update(tabelProduk, row,
        where: '$kolomIdProduk = ?', whereArgs: [idProduk]);

    print('SQLITE-updatedFavorite: $count');

    // show the results: print all rows in the db
    print(await dbClient.query(tabelProduk));
    return count;
  }
}
