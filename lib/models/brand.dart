class Brand {
  late int id;
  late String name;

//<editor-fold desc="Data Methods">

  Brand({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Brand &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Brand{' + ' id: $id,' + ' name: $name,' + '}';
  }

  Brand copyWith({
    int? id,
    String? name,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_brand': this.id,
      'nama_brand': this.name,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
