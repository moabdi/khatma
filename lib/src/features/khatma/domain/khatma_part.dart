import 'dart:convert';

class Part {
  int id;
  String name;
  String subname;
  String title;
  String subtitle;
  StartSV start;
  String? transliteration;
  String? translation;
  String? type;

  Part({
    required this.id,
    required this.name,
    required this.subname,
    required this.title,
    required this.subtitle,
    required this.start,
    this.translation,
    this.transliteration,
    this.type,
  });

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      id: map['id'],
      name: map['name'],
      subname: map['subname'],
      title: map['title'],
      subtitle: map['subtitle'],
      start: StartSV.fromMap(map['start']),
      transliteration: map['transliteration'] ?? '',
      translation: map['translation'] ?? '',
      type: map['type'],
    );
  }

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));
}

class StartSV {
  int sourat;
  int verse;

  StartSV({
    required this.sourat,
    required this.verse,
  });

  factory StartSV.fromMap(Map<String, dynamic> map) {
    return StartSV(
      sourat: map['sourat'],
      verse: map['verse'],
    );
  }
}
