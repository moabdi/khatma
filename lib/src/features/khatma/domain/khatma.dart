import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma/src/features/khatma/utils/parts_helper.dart';
import 'package:khatma/src/common/utils/number_utils.dart';

class Khatma {
  String? id;
  String name;
  String? description;
  DateTime createDate;
  DateTime? endDate;
  String? creator;
  bool permanent = false;

  SplitUnit unit;
  KhatmaType type;
  KhatmaStyle? style;

  // should be out
  DateTime? lastRead;
  List<int>? completedParts;

  Khatma({
    this.id,
    required this.name,
    this.description,
    required this.createDate,
    this.endDate,
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
    if (completedParts?.isEmpty ?? true) return 1;
    return findSmallestMissingPositive(List.from(completedParts!)) + 1;
  }

  Duration get duration {
    if (lastRead == null) return DateTime.now().difference(createDate);
    return DateTime.now().difference(lastRead!);
  }
}

class KhatmaStyle {
  String? color;
  String? icon;

  KhatmaStyle({this.color, this.icon});
}
