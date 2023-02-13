import 'dart:convert';

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Genre.fromJson(String source) => Genre.fromMap(json.decode(source));
}
