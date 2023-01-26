import 'package:khatma_app/src/features/khatma/enums/khatma_enums.dart';

class Khatma {
  String? id;
  String name;
  String? description;
  DateTime? start;
  DateTime? end;
  String? creator;
  bool permanent = false;
  SplitUnit unit;
  KhatmaType? type;

  Khatma({
    this.id,
    required this.name,
    this.description,
    this.start,
    this.end,
    this.creator,
    this.permanent = false,
    this.unit = SplitUnit.hizb,
    this.type,
  });
}
