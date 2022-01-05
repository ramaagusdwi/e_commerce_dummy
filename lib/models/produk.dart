class Produk {
  int? idProduk;
  late String nama;
  late int harga;
  late int idBrand;
  late String warnaHex;
  late String pathImage;
  String namaBrand = "brand";
  int favorite = 0;

//<editor-fold desc="Data Methods">

  Produk({
    this.idProduk,
    required this.nama,
    required this.harga,
    required this.warnaHex,
    required this.idBrand,
    required this.pathImage,
    this.namaBrand = "brand",
    this.favorite = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produk &&
          runtimeType == other.runtimeType &&
          nama == other.nama &&
          harga == other.harga &&
          idBrand == other.idBrand &&
          pathImage == other.pathImage);

  @override
  int get hashCode =>
      nama.hashCode ^ harga.hashCode ^ idBrand.hashCode ^ pathImage.hashCode;

  @override
  String toString() {
    return 'Produk{' +
        ' nama: $nama,' +
        ' harga: $harga,' +
        ' idBrand: $idBrand,' +
        ' pathImage: $pathImage,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': this.nama,
      'harga': this.harga,
      'id_brand': this.idBrand,
      'path_terakhir': this.pathImage,
      'warna': this.warnaHex,
      'favorite': this.favorite,
      // 'nama_brand': this.namaBrand,
    };
  }

  Produk.fromMapQuery(Map<dynamic, dynamic> json) {
    idProduk = json['id_produk'];
    nama = json['nama'];
    harga = json['harga'];
    idBrand = json['id_brand'];
    pathImage = json['path_terakhir'];
    warnaHex = json['warna'];
    favorite = json['favorite'];
    // namaBrand = json['nama_brand'];
  }
//</editor-fold>
}
