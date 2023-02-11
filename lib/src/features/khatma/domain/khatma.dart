import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma/src/features/khatma/utils/parts_helper.dart';
import 'package:khatma/src/utils/number_utils.dart';

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

  // should be out
  DateTime? lastRead;
  List<int>? completedParts;
  List<Part>? parts;

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
    this.lastRead,
    this.completedParts,
  });

  double get completude {
    if (completedParts == null) return 0;
    if (SplitUnit.sourat == unit) {
      return computeSouratCompletude(completedParts!.toSet());
    }
    return completedParts!.length / unit.value;
  }

  int get nextPartToRead {
    if (completedParts == null || completedParts!.isEmpty) return 1;
    return findSmallestMissingPositive(List.from(completedParts!)) + 1;
  }
}
