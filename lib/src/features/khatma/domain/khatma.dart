import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/collection_utils.dart';
import 'package:khatma/src/common/utils/day_of_week.dart';
import 'package:khatma/src/features/khatma/utils/parts_helper.dart';
import 'package:khatma/src/common/utils/number_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'khatma.freezed.dart';

@freezed
abstract class Khatma with _$Khatma {
  const factory Khatma({
    String? id,
    required String name,
    String? description,
    required DateTime createDate,
    DateTime? endDate,
    String? creator,
    required KhatmaStyle style,
    DateTime? lastRead,
    List<int>? completedParts,
    List<KhatmaPart>? parts,
    Recurrence? recurrence,
    required SplitUnit unit,
    required ShareVisibility share,
  }) = _Khatma;
}

@freezed
abstract class KhatmaStyle with _$KhatmaStyle {
  const factory KhatmaStyle({
    required String color,
    required String icon,
  }) = _KhatmaStyle;
}

@freezed
abstract class Recurrence with _$Recurrence {
  const factory Recurrence({
    @Default(false) bool repeat,
    required DateTime startDate,
    required DateTime endDate,
    @Default(RepeatInterval.auto) RepeatInterval unit,
    List<int>? days,
    int? frequency,
  }) = _Recurrence;
}

@freezed
abstract class KhatmaPart with _$KhatmaPart {
  const factory KhatmaPart({
    required int id,
    String? userId,
    String? userName,
    DateTime? addedDate,
    DateTime? finishedDate,
    int? remindTimes,
  }) = _KhatmaPart;
}

enum ShareVisibility { private, group, public }

enum RepeatInterval { auto, daily, weekly, monthly }

enum TimePeriods { day, week, month, year }

enum SplitUnit {
  sourat(114),
  juzz(30),
  hizb(60),
  half(120),
  rubue(240),
  thumun(480);

  final int count;

  const SplitUnit(this.count);
}

extension RecurrenceExtention on Recurrence {
  List<int> get daysOfWeek {
    return days ?? [];
  }

  List<bool> get daysOfWeekSelected {
    return List.generate(
        7, (index) => daysOfWeek.contains(DayOfWeek.values[index].value));
  }
}

extension KhatmaPartExtension on KhatmaPart {
  int get duration {
    if (finishedDate == null) return 0;
    return finishedDate!.difference(addedDate!).inSeconds;
  }

  int get daysSinceFinished {
    if (finishedDate == null) return 0;
    return finishedDate!.difference(DateTime.now()).inDays;
  }

  bool get isCompleted {
    return finishedDate != null;
  }

  Color get color {
    if (isCompleted) return Colors.green;
    if (daysSinceFinished > 0) return Colors.red;
    return Colors.grey;
  }
}

extension KhatmaExtension on Khatma {
  double get completude {
    if (isEmpty(parts)) return 0;

    if (SplitUnit.sourat == unit) {
      return computeSouratCompletude(completedPartIds);
    }
    return completedPartIds.length / unit.count;
  }

  int get nextPartToRead {
    if (completedParts?.isEmpty ?? true) return 1;
    return findSmallestMissingPositive(List.from(completedParts!)) + 1;
  }

  Duration get duration {
    if (lastRead == null) return DateTime.now().difference(createDate);
    return DateTime.now().difference(lastRead!);
  }

  List<int> get readParts {
    return completedParts ?? [];
  }

  bool get isExpired {
    return recurrence != null && recurrence!.endDate.isBefore(DateTime.now());
  }

  String get remainingDays {
    if (recurrence == null || isExpired) return '0';
    return recurrence!.endDate.difference(DateTime.now()).inDays.toString();
  }

  String get remainingParts {
    return (unit.count - readParts.length).toString();
  }

  List<int> get remainingPartsList {
    return List.generate(unit.count, (index) => index + 1)
        .where((part) => !readParts.contains(part))
        .toList();
  }

  List<int> get completedPartIds {
    return parts
            ?.where((part) => part.finishedDate != null)
            .map((part) => part.id)
            .toSet()
            .toList() ??
        [];
  }

  bool get isCompleted {
    return completedPartIds.length == unit.count;
  }

  bool get isStarted {
    return lastRead != null;
  }

  bool get repeats {
    return recurrence != null && recurrence!.repeat;
  }
}
