class Favorite {
  int idFavorite;
  late int idProduk;
  late int idUser;

//<editor-fold desc="Data Methods">

  Favorite({
    this.idFavorite = 0,
    required this.idProduk,
    required this.idUser,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'idFavorite': this.idFavorite,
      'id_produk': this.idProduk,
      'id_user': this.idUser,
    };
  }


//</editor-fold>
}
