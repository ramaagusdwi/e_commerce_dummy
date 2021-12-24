import 'package:sqflite/sqflite.dart';

class KeranjangBelanjaCtr {
  final Database dbClient;

  KeranjangBelanjaCtr({required this.dbClient});

  String tabelKeranjang = 'cart';
  String kolomIdKeranjang = 'id_cart';
  String kolomHarga = 'harga';
  String kolomKuantitas = 'kuantitas';
  String kolomSubTotal = 'sub_total';
  String kolomUkuran = 'ukuran';
  String kolomWarna = 'warna';
  String kolomDipilih = 'dipilih';

  String tabelProduk = 'produk';
  String kolomIdProduk = 'id_produk';

  String tabelUser = 'user';
  String kolomIdUser = 'id_brand';

  Future<void> addTabelKeranjangBelanja() async {
    await dbClient.execute(
        'CREATE TABLE IF NOT EXISTS $tabelKeranjang ($kolomIdKeranjang INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$kolomKuantitas INTEGER, $kolomHarga INTEGER,'
        '$kolomIdProduk INTEGER, $kolomIdUser INTEGER,'
        'FOREIGN KEY ($kolomIdProduk) REFERENCES $tabelProduk($kolomIdProduk) ON DELETE CASCADE,'
        'FOREIGN KEY ($kolomIdUser) REFERENCES $tabelUser($kolomIdUser) ON DELETE CASCADE)');
  }
}
