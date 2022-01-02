import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:test_mobile_apps_dev/data/controller_query/brand_ctr.dart';
import 'package:test_mobile_apps_dev/data/controller_query/favorite_ctr.dart';
import 'package:test_mobile_apps_dev/data/controller_query/produk_ctr.dart';
import 'package:test_mobile_apps_dev/data/database_helper.dart';
import 'package:test_mobile_apps_dev/data/shared_pref/v_pref.dart';
import 'package:test_mobile_apps_dev/models/brand.dart';
import 'package:test_mobile_apps_dev/models/favorite.dart';
import 'package:test_mobile_apps_dev/models/produk.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';

enum ResultState { Loading, Success, Failed, None }

class ProdukModel extends ChangeNotifier {
  BuildContext context;
  late ResultState _resultState;

  ResultState get state => _resultState;

  String _message = "";

  String get message => _message;

  List<Produk> listProduk = [];
  List<Brand> listBrand = [];

  List<Produk> aerostreetProductsLocal = [];
  List<Produk> ardilesProductsLocal = [];
  List<Produk> relicaProductsLocal = [];
  List<Produk> rougheProductLocal = [];
  List<Produk> vincencioProductsLocal = [];

  late var database;

  ProdukModel(this.context) {
    init();
  }

  Future<void> init() async {
    log("cek INIT PRODUK MODEL");
    _resultState = ResultState.Loading;
    notifyListeners();

    listProduk.clear();
    listProduk.clear();

    listBrand.add(Brand(id: 1, name: "Aerostreet"));
    listBrand.add(Brand(id: 2, name: "Ardiles Culture"));
    listBrand.add(Brand(id: 3, name: "Relica"));
    listBrand.add(Brand(id: 4, name: "Roughe"));
    listBrand.add(Brand(id: 5, name: "Vincencio"));

    //Aerostreetbrand
    generateAerostreet();

    //ardiles culture brand
    generateArdilesCulture();

    //BRAND RELICA
    generateRelica();

    //BRAND ROUGHE
    generateRougheBrand();

    //BRAND VINCENCIO
    generateVincencioBrand();

    try {
      database = await DatabaseHelper().database;

      var brandController = BrandCtr(dbClient: database);
      brandController.insertBanyakBrand(listBrand);

      //cek list brand
      // List<Brand> localListBrand = await brandController.getBrand();
      // log("cek data Brand Lokal: $localListBrand");

      var produkController = ProdukCtr(dbClient: database);

      //insert produk to db
      for (int i = 0; i <= listProduk.length - 1; i++) {
        produkController.insertBanyakProduk(listProduk);

        //cek list produk
        // List<Produk> localListProduk = await produkController.getProduk();
        // log("cek data Produk Local : $localListProduk");
      }

      aerostreetProductsLocal.clear();
      aerostreetProductsLocal =
          await produkController.showProdukBerdasarkanBrand(1);

      ardilesProductsLocal.clear();
      ardilesProductsLocal =
          await produkController.showProdukBerdasarkanBrand(2);

      relicaProductsLocal.clear();
      relicaProductsLocal =
          await produkController.showProdukBerdasarkanBrand(3);

      rougheProductLocal.clear();
      rougheProductLocal = await produkController.showProdukBerdasarkanBrand(4);

      vincencioProductsLocal.clear();
      vincencioProductsLocal =
          await produkController.showProdukBerdasarkanBrand(5);

      for (final i in aerostreetProductsLocal) {
        log('aerostreet: $i}');
      }

      for (final i in ardilesProductsLocal) {
        log('ardile: $i}');
      }

      for (final i in relicaProductsLocal) {
        log('relica: $i}');
      }

      for (final i in rougheProductLocal) {
        log('roughe: $i}');
      }

      for (final i in vincencioProductsLocal) {
        log('vincencio: $i}');
      }
    } catch (err) {
      log("brand catch $err");
    }

    _resultState = ResultState.Success;
    notifyListeners();
  }

  void generateAerostreet() {
    listProduk.add(Produk(
        idBrand: 1,
        nama: "Aerostreet Boots Adventure 191",
        harga: 99900,
        pathImage: 'aerostreet/AC_STONEBROKEMID.BLACK.1.jpeg',
        warnaHex: '#000000'));

    listProduk.add(Produk(
        idBrand: 1,
        nama: "Aerostreet Boots Adventure 192",
        harga: 99900,
        pathImage: 'aerostreet/AERO_192.NAVY.1.jpeg',
        warnaHex: '#800000'));

    listProduk.add(Produk(
        idBrand: 1,
        nama: "Aerostreet Boots Adventure 193",
        harga: 99900,
        pathImage: 'aerostreet/AERO_193.BROWN.1.jpeg',
        warnaHex: '#000000'));

    listProduk.add(Produk(
        idBrand: 1,
        nama: "Aerostreet Boots Adventure 194",
        harga: 99900,
        pathImage: 'aerostreet/AERO_194.BROWN.1.jpeg',
        warnaHex: '#000000'));
  }

  void generateArdilesCulture() {
    listProduk.add(Produk(
        idBrand: 2,
        nama: "Ardiles Culture X VLCNZD Sneakers Elemental Black",
        harga: 268000,
        pathImage: 'ardiles_culture/AC_ELEMENTAL-BLACK.BLACK.1.jpeg',
        warnaHex: '#000000'));

    listProduk.add(Produk(
        idBrand: 2,
        nama: "Ardiles Culture Sneakers Stone Broke MID Black",
        harga: 268000,
        pathImage: 'ardiles_culture/AC_ELEMENTAL-BW.BLACK.1.jpeg',
        warnaHex: '#000000'));

    listProduk.add(Produk(
        idBrand: 2,
        nama: "Ardiles Culture X VLCNZD Sneakers Elemental Black Orange",
        harga: 268000,
        pathImage: 'ardiles_culture/AC_ELEMENTAL-ORANGE.BLACK.1.jpeg',
        warnaHex: '#FFA500'));

    listProduk.add(Produk(
        idBrand: 2,
        nama: "Ardiles Culture Sneakers Stone Broke MID Black",
        harga: 443000,
        pathImage: 'ardiles_culture/AC_STONEBROKEMID.BLACK.1.jpeg',
        warnaHex: '#000000'));
  }

  void generateRelica() {
    listProduk.add(Produk(
        idBrand: 3,
        nama: "Relica Sneakers Arvie RLC 08 Brown",
        harga: 155000,
        pathImage: 'relica/RLC08.BROWN.1.jpeg',
        warnaHex: ColorSource.brownHex));

    listProduk.add(Produk(
        idBrand: 3,
        nama: "Relica Sneakers Avery RLC 09 Maroon",
        harga: 155000,
        pathImage: 'relica/RLC09.MAROON.1.jpeg',
        warnaHex: ColorSource.maroonHex));

    listProduk.add(Produk(
        idBrand: 3,
        nama: "Relica Sneakers Ambler RLC 10 Navy",
        harga: 155000,
        pathImage: 'relica/RLC10.NAVY.1.jpeg',
        warnaHex: ColorSource.navyHex));

    listProduk.add(Produk(
        idBrand: 3,
        nama: "Relica Sneakers Anakin RLC 11 Maroon",
        harga: 155000,
        pathImage: 'relica/RLC11.MAROON.1.jpeg',
        warnaHex: ColorSource.maroonHex));
  }

  void generateRougheBrand() {
    listProduk.add(Produk(
        idBrand: 4,
        nama: "Roughee Sports Sailendra Navy",
        harga: 129000,
        pathImage: 'roughe/RGS_03NVY.BLUE.1.jpeg',
        warnaHex: '#010151'));

    listProduk.add(Produk(
        idBrand: 4,
        nama: "Roughee Sports Sailendra Red velvet",
        harga: 268000,
        pathImage: 'roughe/RGS_04RDV.RED.1.jpeg',
        warnaHex: '#800000'));

    listProduk.add(Produk(
        idBrand: 4,
        nama: "Roughee Sports Sailendra Grey",
        harga: 268000,
        pathImage: 'roughe/RGS_05GRY.GREY.1.jpeg',
        warnaHex: '#909497'));

    listProduk.add(Produk(
        idBrand: 4,
        nama: "Roughee Sports Sailendra Brown Sugar",
        harga: 268000,
        pathImage: 'roughe/RGS_06BRSG.BROWN.1.jpeg',
        warnaHex: '#964B00'));
  }

  void generateVincencioBrand() {
    listProduk.add(Produk(
        idBrand: 5,
        nama: "Vincencio Sandals Moku Triple Black",
        harga: 499000,
        pathImage: 'vincencio/MOKU-TRIPLEBLACK.BLACK.1.jpeg',
        warnaHex: '#000000'));

    listProduk.add(Produk(
        idBrand: 5,
        nama: "Vincencio Sandals Sumitto All Black",
        harga: 499000,
        pathImage: 'vincencio/SUMITTO-BLACK.BLACK.1.jpeg',
        warnaHex: '#800000'));

    listProduk.add(Produk(
        idBrand: 5,
        nama: "Vincencio Sandals Sumitto Milo",
        harga: 499000,
        pathImage: 'vincencio/SUMITTO-MILO.MILO.1.jpeg',
        warnaHex: ColorSource.miloHex));

    listProduk.add(Produk(
        idBrand: 5,
        nama: "Vincencio Sandals Sumitto Orange",
        harga: 499000,
        pathImage: 'vincencio/SUMITTO-ORANGE.ORANGE.1.jpeg',
        warnaHex: ColorSource.orangeHex));
  }
}
