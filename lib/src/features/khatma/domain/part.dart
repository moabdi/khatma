import 'dart:convert';

class Part {
  int id;
  String name;
  String transliteration;
  String translation;
  String? type;

  Part({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    this.type,
  });

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      id: map['id'],
      name: map['name'],
      transliteration: map['transliteration'] ?? '',
      translation: map['translation'] ?? '',
      type: map['type'],
    );
  }

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));
}