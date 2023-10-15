import 'package:khatma/src/features/khatma/utils/parts_helper.dart';
import 'package:khatma/src/common/utils/number_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'khatma.freezed.dart';

@freezed
abstract class Khatma with _$Khatma {
  const factory Khatma({
    String? id,
    String? description,
    DateTime? endDate,
    String? creator,
    KhatmaStyle? style,
    DateTime? lastRead,
    List<int>? completedParts,
    required String name,
    required DateTime createDate,
    required Recurrence recurrence,
    required SplitUnit unit,
    ShareType? share,
  }) = _Khatma;
}

@freezed
abstract class KhatmaStyle with _$KhatmaStyle {
  const factory KhatmaStyle({
    String? color,
    String? icon,
  }) = _KhatmaStyle;
}

@freezed
abstract class Recurrence with _$Recurrence {
  const factory Recurrence({
    required KhatmaScheduler scheduler,
    required DateTime startDate,
    required DateTime endDate,
    RecurrenceUnit? unit,
    int? occurrence,
  }) = _Recurrence;
}

enum KhatmaScheduler { never, autoRepeat, custom }

enum ShareType { individual, public, custom }

enum RecurrenceUnit { once, daily, weekly, monthly, hijriMonthly, yearly }

enum SplitUnit {
  sourat(114),
  juzz(30),
  hizb(60),
  rubue(240),
  thumun(480);

  final int count;

  const SplitUnit(this.count);
}

extension KhatmaExtension on Khatma {
  double get completude {
    if (completedParts == null) return 0;
    if (SplitUnit.sourat == unit) {
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
