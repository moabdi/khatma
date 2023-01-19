import 'dart:convert';

class Item {
  int id;
  String name;
  String transliteration;
  String translation;

  Item({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      transliteration: map['transliteration'],
      translation: map['translation'],
    );
  }

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}

enum ItemType { hizb, juzz, sourat }
