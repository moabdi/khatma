import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma/src/features/khatma/utils/parts_helper.dart';

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
  List<int>? completedParts;

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
    this.completedParts,
  });

  double get completude {
    if (completedParts == null) return 0;
    if (SplitUnit.sourat == unit) {
      return computeSouratCompletude(completedParts!.toSet());
    }
    return completedParts!.length / unit.value;
  }
}
