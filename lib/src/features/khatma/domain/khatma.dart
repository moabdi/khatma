import 'package:khatma_app/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma_app/src/features/khatma/utils/parts_helper.dart';

class Khatma {
  String? id;
  String name;
  String? description;
  DateTime? start;
  DateTime? end;
  String? creator;
  bool permanent = false;
  SplitUnit unit;
  KhatmaType type;
  Set<int> completedParts = {};

  Khatma({
    this.id,
    required this.name,
    this.description,
    this.start,
    this.end,
    this.creator,
    this.permanent = false,
    this.unit = SplitUnit.hizb,
    this.type = KhatmaType.custom,
  });

  double get completude {
    if (SplitUnit.sourat == unit) {
      return computeSouratCompletude(completedParts);
    }
    return completedParts.length / unit.value;
  }
}
