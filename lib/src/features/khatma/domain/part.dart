import 'dart:convert';

class Part {
  int id;
  String name;
  String transliteration;
  String translation;
  PartMarker? start;
  PartMarker? end;
  String type;
  int? verses;
  int? pages;
  int? page;

  Part({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    this.start,
    this.end,
    this.verses,
    this.pages,
    this.page,
  });

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      id: map['id'],
      name: map['name'],
      transliteration: map['transliteration'] ?? '',
      translation: map['translation'] ?? '',
      start: PartMarker.fromMap(map['start']),
      end: PartMarker.fromMap(map['start']),
      type: map['type'],
      verses: map['verses'],
      pages: map['pages'],
      page: map['page'],
    );
  }

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));
}

class PartMarker {
  int souratId;
  int verse;

  PartMarker({required this.souratId, required this.verse});

  factory PartMarker.fromMap(Map<String, dynamic> map) {
    return PartMarker(
      souratId: map['sourat'],
      verse: map['verse'],
    );
  }

  factory PartMarker.fromJson(String source) =>
      PartMarker.fromMap(json.decode(source));
}
