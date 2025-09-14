import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

part 'khatma.freezed.dart';
part 'khatma.g.dart';

typedef KhatmaID = String;

// Validation result
@freezed
abstract class ValidationResult with _$ValidationResult {
  const factory ValidationResult({
    required bool isValid,
    @Default([]) List<AppErrorCode> errors,
  }) = _ValidationResult;
}

// Enhanced Khatma model with better validation and computed properties
@freezed
abstract class Khatma with _$Khatma {
  const Khatma._(); // Private constructor for custom methods

  const factory Khatma({
    @JsonKey(includeFromJson: true, includeToJson: true) KhatmaID? id,
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
    DateTime? lastUpdated,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default(KhatmaStatus.active) KhatmaStatus status,
  }) = _Khatma;

  factory Khatma.fromJson(Map<String, Object?> json) => _$KhatmaFromJson(json);

  // Computed properties with better logic
  double get completionPercent {
    if (readParts?.isEmpty ?? true) return 0.0;
    final completedCount = completedPartIds.length;
    return (completedCount / unit.count).clamp(0.0, 1.0);
  }

  Duration get duration {
    final baseDate = lastRead ?? createDate;
    return DateTime.now().difference(baseDate);
  }

  List<int> get readPartIds {
    return readParts?.map((part) => part.id).toSet().toList() ?? [];
  }

  List<int> get completedPartIds {
    return readParts
            ?.where((part) => part.isCompleted)
            .map((part) => part.id)
            .toSet()
            .toList() ??
        [];
  }

  List<int> get remainingPartIds {
    final allParts = List.generate(unit.count, (index) => index + 1);
    return allParts.where((part) => !completedPartIds.contains(part)).toList();
  }

  bool get isCompleted => completedPartIds.length >= unit.count;
  bool get isStarted => completedPartIds.isNotEmpty;
  bool get isNotStarted => completedPartIds.isEmpty;
  bool get isActive => status == KhatmaStatus.active;
  bool get isDeleted => status == KhatmaStatus.deleted;

  bool get isExpired {
    if (recurrence?.endDate == null) return false;
    return recurrence!.endDate!.isBefore(DateTime.now());
  }

  String get remainingDays {
    if (isExpired) return '0';
    if (recurrence?.endDate == null) return '∞';
    return recurrence!.endDate!.difference(DateTime.now()).inDays.toString();
  }

  KhatmaTheme get effectiveTheme {
    return theme ??
        const KhatmaTheme(
          color: "#00A862",
          icon: "kaaba.ico",
        );
  }

  // Validation method
  AppErrorCode validate() {
    if (name.trim().isEmpty) {
      return AppErrorCode.validationMissingFields;
    }

    if (name.length > 100) {
      return AppErrorCode.validationInvalidData;
    }

    if (description != null && description!.length > 500) {
      return AppErrorCode.validationInvalidData;
    }

    if (endDate != null && endDate!.isBefore(startDate)) {
      return AppErrorCode.validationInvalidData;
    }

    if (share?.maxPartToRead != null && share!.maxPartToRead! > unit.count) {
      return AppErrorCode.validationInvalidData;
    }

    return AppErrorCode.noError;
  }

  // Helper method for updating reading progress
  Khatma addCompletedParts(List<int> partIds) {
    final updatedParts = List<KhatmaPart>.from(readParts ?? []);
    final now = DateTime.now();

    for (final partId in partIds) {
      final existingIndex = updatedParts.indexWhere((p) => p.id == partId);

      if (existingIndex != -1) {
        // Update existing part
        updatedParts[existingIndex] = updatedParts[existingIndex].copyWith(
          endDate: now,
          finishedDate: now,
        );
      } else {
        // Add new completed part
        updatedParts.add(KhatmaPart(
          id: partId,
          endDate: now,
          finishedDate: now,
        ));
      }
    }

    final updated = copyWith(
      readParts: updatedParts,
      lastRead: now,
    );

    // Auto-complete if all parts are done
    if (updated.isCompleted && status == KhatmaStatus.active) {
      return updated.copyWith(
        endDate: now,
        status: KhatmaStatus.completed,
      );
    }

    return updated;
  }
}

// Enhanced KhatmaPart with validation
@freezed
abstract class KhatmaPart with _$KhatmaPart, EquatableMixin {
  const KhatmaPart._();

  const factory KhatmaPart({
    required int id,
    String? userId,
    String? userName,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? finishedDate,
    int? remindTimes,
    @Default(KhatmaPartStatus.notStarted) KhatmaPartStatus status,
  }) = _KhatmaPart;

  @override
  List<Object?> get props => [id];

  factory KhatmaPart.fromJson(Map<String, Object?> json) =>
      _$KhatmaPartFromJson(json);

  bool get isCompleted => endDate != null || finishedDate != null;
  bool get isReserved => userId != null && !isCompleted;
  bool get isAvailable => userId == null && !isCompleted;

  Duration? get readingDuration {
    if (startDate == null || endDate == null) return null;
    return endDate!.difference(startDate!);
  }

  int get daysSinceFinished {
    final finishDate = finishedDate ?? endDate;
    if (finishDate == null) return 0;
    return DateTime.now().difference(finishDate).inDays;
  }

  Color get statusColor {
    switch (status) {
      case KhatmaPartStatus.completed:
        return Colors.green;
      case KhatmaPartStatus.inProgress:
        return Colors.blue;
      case KhatmaPartStatus.reserved:
        return Colors.orange;
      case KhatmaPartStatus.overdue:
        return Colors.red;
      case KhatmaPartStatus.notStarted:
        return Colors.grey;
    }
  }
}

// Enhanced enums
enum KhatmaStatus { active, completed, deleted }

enum KhatmaPartStatus { notStarted, reserved, inProgress, completed, overdue }

// Enhanced theme model
@freezed
abstract class KhatmaTheme with _$KhatmaTheme {
  const factory KhatmaTheme({
    required String color,
    required String icon,
    @Default('light') String variant,
  }) = _KhatmaTheme;

  factory KhatmaTheme.fromJson(Map<String, Object?> json) =>
      _$KhatmaThemeFromJson(json);
}

// Enhanced recurrence model
@freezed
abstract class Recurrence with _$Recurrence {
  const factory Recurrence({
    @Default(RepeatInterval.auto) RepeatInterval unit,
    @Default(true) bool repeat,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? days,
    int? frequency,
    @Default(false) bool skipWeekends,
    @Default(false) bool pauseOnCompletion,
  }) = _Recurrence;

  factory Recurrence.fromJson(Map<String, Object?> json) =>
      _$RecurrenceFromJson(json);
}

// Enhanced share model
@freezed
abstract class KhatmaShare with _$KhatmaShare {
  const factory KhatmaShare({
    required ShareVisibility visibility,
    int? maxPartToRead,
    int? maxPartToReserve,
    @Default(false) bool allowGuestParticipation,
    @Default(true) bool showParticipantNames,
    String? inviteCode,
    DateTime? inviteExpiry,
  }) = _KhatmaShare;

  factory KhatmaShare.fromJson(Map<String, Object?> json) =>
      _$KhatmaShareFromJson(json);
}

// Existing enums (kept for compatibility)
enum ShareVisibility { private, group, public }

enum RepeatInterval { auto, daily, weekly, monthly }

enum TimePeriods { day, week, month, year }

enum SplitUnit {
  juzz(30),
  hizb(60);

  const SplitUnit(this.count);
  final int count;

  String get displayName {
    switch (this) {
      case SplitUnit.juzz:
        return 'Juzz';
      case SplitUnit.hizb:
        return 'Hizb';
    }
  }
}

// Validator class
class KhatmaValidator {
  static AppErrorCode validateKhatma(Khatma khatma) {
    return khatma.validate();
  }

  static AppErrorCode validateKhatmaPart(KhatmaPart part) {
    final errors = <String>[];

    if (part.id <= 0) {
      errors.add('Part ID must be positive');
    }

    if (part.startDate != null && part.endDate != null) {
      if (part.endDate!.isBefore(part.startDate!)) {
        errors.add('End date must be after start date');
      }
    }

    return AppErrorCode.validationInvalidData; // Return appropriate error key
    //return errors.isEmpty ? AppErrorKey.noError : AppErrorKey.validationInvalidData;
  }
}

// Extension for better integration with existing code
extension KhatmaExtension on Khatma {
  String get remainingParts => remainingPartIds.length.toString();

  List<int> get remainingPartsList => remainingPartIds;

  KhatmaTheme get style => effectiveTheme; // Backward compatibility
}

extension ColorExtension on KhatmaTheme {
  Color get hexColor => HexColor(color);
}

LinkedHashMap<String, Color> khatmaColorMap =
    LinkedHashMap<String, Color>.from({
  HexColor("#00A862").toHex(): HexColor("#00A862"),
  HexColor("#DD642E").toHex(): HexColor("#DD642E"),
  HexColor("#0F65E6").toHex(): HexColor("#0F65E6"),
  HexColor("#713CE7").toHex(): HexColor("#713CE7"),
  HexColor("#E01497").toHex(): HexColor("#E01497"),
  HexColor("#DD642E").toHex(): HexColor("#DD642E"),
});

List<String> khatmaColorHexList = khatmaColorMap.keys.toList();

@freezed
abstract class LimitInfo with _$LimitInfo {
  const factory LimitInfo({
    required int current,
    required int max,
    required int available,
    @Default(true) bool canCreate,
  }) = _LimitInfo;
}

@freezed
abstract class KhatmaStats with _$KhatmaStats {
  const factory KhatmaStats({
    required int active,
    required int available,
    required int totalCompletions,
    required int thisMonth,
    required int thisYear,
  }) = _KhatmaStats;
}

@freezed
abstract class DetailedStats with _$DetailedStats {
  const factory DetailedStats({
    required int active,
    required int available,
    required int totalCompletions,
    required String averageDays,
    required Map<String, int> monthlyCompletions,
    required int needsSync,
  }) = _DetailedStats;
}

@freezed
abstract class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required bool needsSync,
    required List<Khatma> khatmas,
    required List<CompletionHistory> history,
    required int totalCount,
    String? lastSyncTime,
    int? minutesSinceLastSync,
  }) = _SyncStatus;
}

@freezed
abstract class SyncResult with _$SyncResult {
  const factory SyncResult({
    @Default(true) bool success,
    int? syncedKhatmas,
    int? syncedHistory,
    List<String>? errors,
    String? syncTime,
    String? error,
    String? reason,
    String? lastSyncTime,
    @Default(0) int totalSynced,
  }) = _SyncResult;

  factory SyncResult.success({
    required int syncedKhatmas,
    required int syncedHistory,
    required List<String> errors,
    required String syncTime,
  }) {
    return SyncResult(
      success: true,
      syncedKhatmas: syncedKhatmas,
      syncedHistory: syncedHistory,
      errors: errors,
      syncTime: syncTime,
      totalSynced: syncedKhatmas + syncedHistory,
    );
  }

  factory SyncResult.failure({
    required String error,
    int syncedKhatmas = 0,
    int syncedHistory = 0,
    List<String> errors = const [],
  }) {
    return SyncResult(
      success: false,
      error: error,
      syncedKhatmas: syncedKhatmas,
      syncedHistory: syncedHistory,
      errors: errors,
    );
  }

  factory SyncResult.notNeeded({
    required String reason,
    String? lastSyncTime,
  }) {
    return SyncResult(
      success: true,
      reason: reason,
      lastSyncTime: lastSyncTime,
    );
  }
}
