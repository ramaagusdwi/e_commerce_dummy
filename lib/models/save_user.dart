class InfoUser {
  late String nama;
  late String password;
  late String email;
  late String telepon;
  late String tanggalLahir;

//<editor-fold desc="Data Methods">

  InfoUser({
    required this.nama,
    required this.password,
    required this.email,
    required this.telepon,
    required this.tanggalLahir,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama_user': this.nama,
      'password': this.password,
      'email': this.email,
      'nomer_telp': this.telepon,
      'tgl_lahir': this.tanggalLahir,
    };
  }

//</editor-fold>
}
