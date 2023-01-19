import 'dart:convert';

import 'package:khatma_app/src/features/khatma/domain/item.dart';


class Sourat extends Item {
  String type;
  int verses;
  int pages;
  int page;

  Sourat({
    required int id,
    required String name,
    required String transliteration,
    required String translation,
    required this.type,
    required this.verses,
    required this.pages,
    required this.page,
  }) : super(
          id: id,
          name: name,
          translation: translation,
          transliteration: transliteration,
        );

  factory Sourat.fromMap(Map<String, dynamic> map) {
    return Sourat(
      id: map['id'],
      name: map['name'],
      transliteration: map['transliteration'] ?? '',
      translation: map['translation'] ?? '',
      type: map['type'],
      verses: map['verses'],
      pages: map['pages'],
      page: map['page'],
    );
  }

  factory Sourat.fromJson(String source) => Sourat.fromMap(
        json.decode(source),
      );
}
