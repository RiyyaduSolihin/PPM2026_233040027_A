class Catatan {
  final int? id;
  final String judul;
  final String isi;
  final String kategori;
  final String email;
  final DateTime dibuatPada;

  Catatan({
    this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'judul': judul,
      'isi': isi,
      'kategori': kategori,
      'email': email,
      'dibuat_pada': dibuatPada.millisecondsSinceEpoch,
    };
  }

  factory Catatan.fromMap(Map<String, Object?> map) {
    return Catatan(
      id: map['id'] as int?,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      kategori: map['kategori'] as String,
      email: map['email'] as String,
      dibuatPada: DateTime.fromMillisecondsSinceEpoch(
        map['dibuat_pada'] as int,
      ),
    );
  }

  Catatan copyWith({
    String? judul,
    String? isi,
    String? kategori,
    String? email,
  }) {
    return Catatan(
      id: id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      kategori: kategori ?? this.kategori,
      email: email ?? this.email,
      dibuatPada: dibuatPada,
    );
  }
}
