import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/models/brand.dart';

class BrandCtr {
  final Database dbClient;

  BrandCtr({required this.dbClient});

  String kolomIdBrand = 'id_brand';
  String kolomNamaBrand = 'nama_brand';
  String tabelBrand = 'brand';

  Future insertBanyakBrand(List<Brand> brandList) async {
    clearAllData(tabelBrand);
    for (int i = 0; i < brandList.length; i++) {
      insertBrand(brandList[i]);
    }
  }

  Future<int> insertBrand(Brand brand) async {
    int res = await dbClient.insert(
      tabelBrand,
      brand.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future getBrand() async {
    log("select data Brand");
    List<Map> labels = await dbClient.rawQuery('SELECT * FROM $tabelBrand');
    print("cek data length ${labels.length} from $tabelBrand");
    // Convert the List<Map<String, dynamic> into a List<Type>.
    return labels.isNotEmpty
        ? List<Brand>.generate(
            labels.length,
            (i) => Brand(
                  id: labels[i][kolomIdBrand],
                  name: labels[i][kolomNamaBrand],
                ))
        : <Brand>[];
  }

  clearAllData(String tableName) async {
    Database db = dbClient;
    await db.rawQuery("DELETE FROM $tableName");
  }
}
