import 'package:khatma_app/src/features/khatma/enums/khatma_enums.dart';

class Khatma {
  String? id;
  String name;
  String description;
  DateTime? start;
  DateTime? end;
  String? creator;
  bool permanent = false;
  KhatmaUnit unit;

  Khatma({
    this.id,
    required this.name,
    required this.description,
    this.start,
    this.end,
    this.creator,
    this.permanent = false,
    this.unit = KhatmaUnit.hizb,
  });
}
