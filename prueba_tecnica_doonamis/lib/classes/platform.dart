import 'dart:convert';

class Platform {
  int id;
  String name;

  Platform({
    required this.id,
    required this.name,
  });

  factory Platform.fromMap(Map<String, dynamic> map) {
    return Platform(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Platform.fromJson(String source) =>
      Platform.fromMap(json.decode(source));
}
