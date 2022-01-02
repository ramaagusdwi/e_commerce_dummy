class User {
  int idUser;
  late String nama;
  late String password;
  late String email;
  late String telepon;
  late String tanggalLahir;

//<editor-fold desc="Data Methods">

  User({
    this.idUser = 0,
    required String nama,
    required String password,
    required String email,
    required String telepon,
    required String tanggalLahir,
  })  : nama = nama,
        password = password,
        email = email,
        telepon = telepon,
        tanggalLahir = tanggalLahir;

  User copyWith({
    int? id,
    String? nama,
    String? password,
    String? email,
    String? telepon,
    String? tanggalLahir,
  }) {
    return User(
      nama: nama ?? this.nama,
      password: password ?? this.password,
      email: email ?? this.email,
      telepon: telepon ?? this.telepon,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_user': this.nama,
      'password': this.password,
      'email': this.email,
      'nomer_telp': this.telepon,
      'tgl_lahir': this.tanggalLahir,
    };
  }

  //masukan data tipe map ke user
  //json biasa bertipe map
  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      idUser: map['id_user'] as int,
      nama: map['nama_user'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      telepon: map['nomer_telp'] as String,
      tanggalLahir: map['tgl_lahir'] as String,
    );
  }

//</editor-fold>
}
