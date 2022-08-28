import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/data/controller_query/favorite_controller_query.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_controller_query.dart';
import 'package:test_mobile_apps_dev/models/brand.dart';

import 'controller_query/keranjang_controller_query.dart';
// import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "e_commerce.db";
  static final _databaseVersion = 1;

  String tabelUser = 'user';
  String kolomIdUser = 'id_user';
  String kolomPassword = 'password';
  String kolomNamaUser = 'nama_user';
  String kolomEmail = 'email';
  String kolomNomerTelp = 'nomer_telp';
  String kolomTanggalLahir = 'tgl_lahir';

  String tabelBrand = 'brand';
  String kolomIdBrand = 'id_brand';
  String kolomNamaBrand = 'nama_brand';

  static DatabaseHelper? _databaseHelper;

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  //this is factory constuctors
  factory DatabaseHelper() =>
      _databaseHelper ??
      DatabaseHelper
          ._internal(); // membuat satu instance kelas (single ton pattern)

  // only have a single app-wide reference to the database
  static late Database _database;

  Future<Database> get database async {
    //method
    print("call get DB");
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    print("call initDatabase");

    /// Get the default databases location.
    var path = await getDatabasesPath();

    var db = openDatabase(
      join(path, _databaseName),
      onCreate: _onCreate,
      version: _databaseVersion,
    );

    return db;
  }

  Future _onCreate(Database db, int version) async {
    log("onCreateDB");
    addUserTable(db);
    addBrandTable(db);

    var produk = ProdukCtr(dbClient: db);
    produk.addTabelProduk();

    var keranjangBelanja = KeranjangBelanjaCtr(dbClient: db);
    keranjangBelanja.addTabelKeranjangBelanja();

    var favorite = FavoriteCtr(dbClient: db);
    favorite.addTabelFavorite();
  }

  Future<void> addUserTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tabelUser]);
    print("tabelPeopleCek $result");

    if (result.isEmpty) {
      print("TABLE USER KOSONG");
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $tabelUser ($kolomIdUser INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$kolomNamaUser TEXT, $kolomPassword TEXT, $kolomEmail TEXT, $kolomNomerTelp TEXT, $kolomTanggalLahir TEXT)');
    } else {
      print("TABLE USER TIDAK KOSONG");
    }
  }

  Future<void> addBrandTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tabelBrand ($kolomIdBrand INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$kolomNamaBrand TEXT)');
  }
}
