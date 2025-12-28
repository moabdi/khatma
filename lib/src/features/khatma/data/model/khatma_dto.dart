import 'package:freezed_annotation/freezed_annotation.dart';

part 'khatma_dto.freezed.dart';
part 'khatma_dto.g.dart';

typedef KhatmaID = String;

/// Base DTO for all Khatma types - used for data transfer with Freezed
@Freezed(unionKey: 'type')
sealed class KhatmaDto with _$KhatmaDto {
  const KhatmaDto._();

  const factory KhatmaDto.personal({
    @JsonKey(includeFromJson: true, includeToJson: true) KhatmaID? id,
    @Default('personal') String type,
    required String name,
    required String unit, // 'juzz' or 'hizb'
    required DateTime createDate,
    required DateTime startDate,
    String? description,
    @Default(false) bool repeat,
    @Default(0) int repeats,
    String? themeColor,
    String? themeIcon,
    @Default('light') String themeVariant,
    DateTime? endDate,
    DateTime? lastRead,
    // Map of part number (as string) to completion date (as ISO8601 string)
    Map<String, String>? completedParts,
    DateTime? lastUpdated,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default('active') String status, // 'active', 'completed', 'deleted'
  }) = PersonalKhatmaDto;

  const factory KhatmaDto.shared({
    @JsonKey(includeFromJson: true, includeToJson: true) KhatmaID? id,
    @Default('shared') String type,
    required String name,
    required String description,
    required String unit, // 'juzz' or 'hizb'
    required DateTime createDate,
    DateTime? startDate,
    DateTime? endDate,
    required String creatorId,
    String? creatorName,
    SharedConfigDto? sharedConfig,
    @Default([]) List<ParticipantDto> participants,
    @Default([]) List<UnitDto> units,
    DateTime? lastUpdated,
    @Default('active') String status, // 'active', 'completed', 'archived', 'deleted'
  }) = SharedKhatmaDto;

  const factory KhatmaDto.hifz({
    @JsonKey(includeFromJson: true, includeToJson: true) KhatmaID? id,
    @Default('hifz') String type,
    required String name,
    required String unit, // 'juzz' or 'hizb'
    required DateTime createDate,
    required DateTime startDate,
    String? description,
    String? themeColor,
    String? themeIcon,
    @Default('light') String themeVariant,
    DateTime? endDate,
    DateTime? lastRead,
    List<HifzSectionDto>? sections,
    @Default('memorization') String mode, // 'memorization', 'review', 'both'
    DateTime? lastUpdated,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default('active') String status,
  }) = HifzKhatmaDto;

  factory KhatmaDto.fromJson(Map<String, Object?> json) =>
      _$KhatmaDtoFromJson(json);
}



/// SharedKhatmaParticipant DTO
@freezed
abstract class ParticipantDto with _$ParticipantDto {
  const factory ParticipantDto({
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required DateTime joinedDate,
    @Default(0) int completedUnits,
    @Default('member') String role, // 'member', 'moderator', 'admin'
    @Default('pending') String status, // 'pending', 'approved', 'rejected'
  }) = _ParticipantDto;

  factory ParticipantDto.fromJson(Map<String, Object?> json) =>
      _$ParticipantDtoFromJson(json);
}

/// SharedKhatmaUnit DTO
@freezed
abstract class UnitDto with _$UnitDto {
  const factory UnitDto({
    required int number,
    @Default('free') String status, // 'free', 'reserved', 'selected', 'reservedByCurrentUser', 'completed'
    String? reservedBy,
    String? reservedByName,
    DateTime? reservedDate,
    DateTime? completedDate,
    String? completedBy,
    String? completedByName,
    DateTime? lastReminderSent,
    @Default(0) int reminderCount,
  }) = _UnitDto;

  factory UnitDto.fromJson(Map<String, Object?> json) =>
      _$UnitDtoFromJson(json);
}

/// HifzSection DTO for memorization tracking
@freezed
abstract class HifzSectionDto with _$HifzSectionDto {
  const factory HifzSectionDto({
    required int id,
    required int startVerse,
    required int endVerse,
    required int surah,
    @Default('notStarted') String status, // 'notStarted', 'memorizing', 'reviewing', 'mastered'
    DateTime? startDate,
    DateTime? masteredDate,
    DateTime? lastReviewDate,
    @Default(0) int reviewCount,
    @Default(0) int mistakeCount,
  }) = _HifzSectionDto;

  factory HifzSectionDto.fromJson(Map<String, Object?> json) =>
      _$HifzSectionDtoFromJson(json);
}

/// Additional DTOs for supporting models
@freezed
abstract class ValidationResultDto with _$ValidationResultDto {
  const factory ValidationResultDto({
    required bool isValid,
    @Default([]) List<String> errors,
  }) = _ValidationResultDto;

  factory ValidationResultDto.fromJson(Map<String, Object?> json) =>
      _$ValidationResultDtoFromJson(json);
}

@freezed
abstract class LimitInfoDto with _$LimitInfoDto {
  const factory LimitInfoDto({
    required int current,
    required int max,
    required int available,
    @Default(true) bool canCreate,
  }) = _LimitInfoDto;

  factory LimitInfoDto.fromJson(Map<String, Object?> json) =>
      _$LimitInfoDtoFromJson(json);
}

@freezed
abstract class KhatmaStatsDto with _$KhatmaStatsDto {
  const factory KhatmaStatsDto({
    required int active,
    required int available,
    required int totalCompletions,
    required int thisMonth,
    required int thisYear,
  }) = _KhatmaStatsDto;

  factory KhatmaStatsDto.fromJson(Map<String, Object?> json) =>
      _$KhatmaStatsDtoFromJson(json);
}

@freezed
abstract class DetailedStatsDto with _$DetailedStatsDto {
  const factory DetailedStatsDto({
    required int active,
    required int available,
    required int totalCompletions,
    required String averageDays,
    required Map<String, int> monthlyCompletions,
    required int needsSync,
  }) = _DetailedStatsDto;

  factory DetailedStatsDto.fromJson(Map<String, Object?> json) =>
      _$DetailedStatsDtoFromJson(json);
}

@freezed
abstract class SharedConfigDto with _$SharedConfigDto {
  const factory SharedConfigDto({
    String? inviteCode,
    @Default(3) int maxReservationsPerUser,
    @Default(10) int maxUnitsToRead,
    @Default(7) int reservationWarningDays,
    int? reservationExpirationDays,
    @Default(true) bool autoReleaseExpiredReservations,
    @Default('code') String joinMethod, // 'code', 'invitation', 'both'
    @Default(false) bool allowMultipleGroups,
    @Default([]) List<String> tags,
  }) = _SharedConfigDto;

  factory SharedConfigDto.fromJson(Map<String, Object?> json) =>
      _$SharedConfigDtoFromJson(json);
}
