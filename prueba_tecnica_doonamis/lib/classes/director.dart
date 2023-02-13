import 'dart:convert';

class Director {
  int id;
  String name;

  Director({
    required this.id,
    required this.name,
  });

  factory Director.fromMap(Map<String, dynamic> map) {
    return Director(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Director.fromJson(String source) =>
      Director.fromMap(json.decode(source));
}
