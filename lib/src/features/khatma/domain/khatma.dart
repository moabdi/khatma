import 'package:flutter/material.dart';
import 'package:khatma_ui/enums/day_of_week.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'khatma.freezed.dart';
part 'khatma.g.dart';

typedef KhatmaID = String;

@freezed
abstract class Khatma with _$Khatma {
  const factory Khatma({
    KhatmaID? id,
    required String code,
    required String name,
    required SplitUnit unit,
    required DateTime createDate,
    required DateTime startDate,
    String? description,
    @Default(false) bool repeat,
    int? repeats,
    Recurrence? recurrence,
    KhatmaShare? share,
    KhatmaTheme? theme,
    DateTime? endDate,
    DateTime? lastRead,
    List<KhatmaPart>? readParts,
  }) = _Khatma;

  factory Khatma.fromJson(Map<String, Object?> json) => _$KhatmaFromJson(json);
}

@freezed
abstract class KhatmaTheme with _$KhatmaTheme {
  const factory KhatmaTheme({
    required String color,
    required String icon,
  }) = _KhatmaTheme;

  factory KhatmaTheme.fromJson(Map<String, Object?> json) =>
      _$KhatmaThemeFromJson(json);
}

@freezed
abstract class Recurrence with _$Recurrence {
  const factory Recurrence({
    @Default(RepeatInterval.auto) RepeatInterval unit,
    @Default(true) bool repeat,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? days,
    int? frequency,
  }) = _Recurrence;

  factory Recurrence.fromJson(Map<String, Object?> json) =>
      _$RecurrenceFromJson(json);
}

@freezed
abstract class KhatmaPart with _$KhatmaPart {
  const factory KhatmaPart({
    required int id,
    String? userId,
    String? userName,
    DateTime? startDate,
    DateTime? endDate,
    int? remindTimes,
  }) = _KhatmaPart;

  factory KhatmaPart.fromJson(Map<String, Object?> json) =>
      _$KhatmaPartFromJson(json);
}

@freezed
abstract class KhatmaShare with _$KhatmaShare {
  const factory KhatmaShare({
    required ShareVisibility visibility,
    int? maxPartToRead,
    int? maxPartToReserve,
  }) = _KhatmaShare;

  factory KhatmaShare.fromJson(Map<String, Object?> json) =>
      _$KhatmaShareFromJson(json);
}

enum ShareVisibility { private, group, public }

enum RepeatInterval { auto, daily, weekly, monthly }

enum TimePeriods { day, week, month, year }

enum SplitUnit {
  //sourat(114),
  juzz(30),
  hizb(60);
  //half(120),
  //rubue(240),
  //thumun(480);

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
    if (endDate == null) return 0;
    return endDate!.difference(startDate!).inSeconds;
  }

  int get daysSinceFinished {
    if (endDate == null) return 0;
    return endDate!.difference(DateTime.now()).inDays;
  }

  bool get isCompleted {
    return endDate != null;
  }

  Color get color {
    if (isCompleted) return Colors.green;
    if (daysSinceFinished > 0) return Colors.red;
    return Colors.grey;
  }
}
