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
  String kolomNama = 'nama';
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
        $kolomNama TEXT, $kolomHarga INTEGER, $kolomIdBrand INTEGER, $kolomPathTerakhir TEXT,
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

  //insert ke databse, harus bertipe map
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
                  nama: labels[i][kolomNama],
                  harga: labels[i][kolomHarga],
                  idBrand: labels[i][kolomIdBrand],
                  pathImage: labels[i][kolomPathTerakhir],
                  warnaHex: labels[i][kolomWarna],
                  favorite: labels[i][kolomFavorite],
                ))
        : <Produk>[];
  }

  // Future getProdukAndBrand() async {
  //   // log("select data Produk");
  //   List<Map> labels = await dbClient.rawQuery('SELECT * FROM $tabelProduk');
  //   // print("cek data length ${labels.length} from $tabelProduk");
  //   // Convert the List<Map<String, dynamic> into a List<Type>.
  //   return labels.isNotEmpty
  //       ? List<Produk>.generate(
  //       labels.length,
  //           (i) => Produk(
  //         idProduk: labels[i][kolomIdProduk],
  //         nama: labels[i][kolomNamaProduk],
  //         harga: labels[i][kolomHarga],
  //         idBrand: labels[i][kolomIdBrand],
  //         pathImage: labels[i][kolomPathTerakhir],
  //         warnaHex: labels[i][kolomWarna],
  //         favorite: labels[i][kolomFavorite],
  //       ))
  //       : <Produk>[];
  // }

  Future<List<Produk>> getProductBrand() async {
    var dbClient = await DatabaseHelper().database;
    List<Map> labels = await dbClient.rawQuery('''
      SELECT
          produk.id_produk AS id_produk,
          produk.nama AS nama,
          produk.harga AS harga_produk, 
          produk.warna AS warna_produk, 
          produk.id_brand AS brand_produk, 
          produk.path_terakhir AS nama_asset_produk,
          produk.favorite AS favorite_produk,
          brand.nama_brand AS nama_brand
      FROM produk
      INNER JOIN brand
      ON produk.id_produk = brand.id_produk
      ''');
    print("produkBrand size!: ${labels.length}");
    labels.forEach((row) => print("produkBrand! " + row.toString()));

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
              favorite: labels[i]['favorite_produk'],
              namaBrand: labels[i]['nama_brand'],
            ),
          )
        : <Produk>[];
  }

  Future getProdukBerdasarkanBrand(int idBrand) async {
    // String query = '''SELECT * FROM $tabelProduk
    //     WHERE $kolomIdBrand=$idBrand
    //     ''';
    String query = '''
      SELECT
          produk.id_produk AS id_produk,
          produk.nama AS nama,
          produk.harga AS harga,
          produk.warna AS warna,
          produk.id_brand AS id_produk_brand,
          produk.path_terakhir AS path_terakhir,
          produk.favorite AS favorite,
          brand.nama_brand AS nama_brand
      FROM produk
      INNER JOIN brand
      ON id_produk_brand = brand.id_brand
      WHERE id_produk_brand=$idBrand
      ''';

    List<Map> labels = await dbClient.rawQuery(query);

    log("cekSize ${labels.length}");
    //cek label query
    labels.forEach((row) => print("produkBrandFromLocalDb! " + row.toString()));

    //cek cekNamaBrand
    // labels.forEach((row) => print("cekNamaBrand! " + row['nama_brand']));

    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Produk>.generate(
            labels.length,
            (i) => Produk(
                idProduk: labels[i][kolomIdProduk],
                nama: labels[i][kolomNama],
                harga: labels[i][kolomHarga],
                idBrand: labels[i]['id_produk_brand'],
                pathImage: labels[i][kolomPathTerakhir],
                warnaHex: labels[i][kolomWarna],
                favorite: labels[i][kolomFavorite],
                namaBrand: labels[i]['nama_brand']),
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
