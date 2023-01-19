import 'dart:convert';

import 'package:khatma_app/src/features/khatma/domain/item.dart';
import 'package:khatma_app/src/features/khatma/domain/sourat.dart';


class Part extends Item {
  PartMarker? start;
  PartMarker? end;
  Sourat? souratStart;
  Sourat? souratEnd;

  Part({
    required int id,
    required String name,
    required String transliteration,
    required String translation,
    this.start,
    this.end,
  }) : super(
            id: id,
            name: name,
            translation: translation,
            transliteration: transliteration);

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      id: map['id'],
      name: map['name'],
      transliteration: map['transliteration'] ?? '',
      translation: map['translation'] ?? '',
      start: PartMarker.fromMap(map['start']),
      end: PartMarker.fromMap(map['start']),
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
