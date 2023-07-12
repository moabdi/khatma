import 'package:khatma/src/features/khatma/utils/parts_helper.dart';
import 'package:khatma/src/common/utils/number_utils.dart';

class Khatma {
  String? id;
  String name;
  String? description;
  DateTime createDate;
  DateTime? endDate;

  Recurrence recurrence = Recurrence(
      scheduler: KhatmaScheduler.NEVER,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)));

  SplitUnit unit;
  String? creator;
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
    required this.recurrence,
    this.unit = SplitUnit.HIZB,
    this.lastRead,
    this.completedParts,
  });

  double get completude {
    if (completedParts == null) return 0;
    if (SplitUnit.SOURAT == unit) {
      return computeSouratCompletude(completedParts!.toSet());
    }
    return completedParts!.length / unit.count;
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

class Recurrence {
  KhatmaScheduler scheduler;
  DateTime startDate;
  DateTime endDate;
  RecurrenceUnit? unit;
  int? occurrence;

  Recurrence({
    required this.scheduler,
    required this.startDate,
    required this.endDate,
    this.unit = RecurrenceUnit.DAILY,
    this.occurrence,
  });
}

enum KhatmaScheduler { NEVER, AUTO_REPEAT, CUSTOM }

enum RecurrenceUnit { DAILY, WEEKLY, MONTHLY, MONTHLY_HIJRI, YEARLY }

enum SplitUnit {
  SOURAT(114),
  JUZZ(30),
  HIZB(60),
  RUBUE(240),
  THUMUN(480);

  final int count;

  const SplitUnit(this.count);
}
