import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_apps_dev/data/controller_query/favorite_ctr.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_ctr.dart';
import 'package:test_mobile_apps_dev/models/brand.dart';

import 'controller_query/keranjang_belanja_ctr.dart';
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

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  // only have a single app-wide reference to the database
  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
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
    addTabelBrand(db);

    var produk = ProdukCtr(dbClient: db);
    produk.addTabelProduk();

    var keranjangBelanja = KeranjangBelanjaCtr(dbClient: db);
    keranjangBelanja.addTabelKeranjangBelanja();

    var favorite = FavoriteCtr(dbClient: db);
    favorite.addTabelFavorite();
  }

  Future<void> addUserTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tabelUser ($kolomIdUser INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$kolomNamaUser TEXT, $kolomPassword TEXT, $kolomEmail TEXT, $kolomNomerTelp TEXT, $kolomTanggalLahir TEXT)');
  }

  Future<void> addTabelBrand(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tabelBrand ($kolomIdBrand INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$kolomNamaBrand TEXT)');
  }
}
