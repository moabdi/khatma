import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart';
import 'package:khatma/src/features/khatma/data/model/completion_history_dto.dart';

part 'sync_models.freezed.dart';
part 'sync_models.g.dart';

/// Metadata for tracking sync state of entities
class SyncMetadata {
  final DateTime? lastSync;
  final DateTime? lastUpdated;
  final bool needsSync;

  const SyncMetadata({
    this.lastSync,
    this.lastUpdated,
    this.needsSync = false,
  });

  SyncMetadata copyWith({
    DateTime? lastSync,
    DateTime? lastUpdated,
    bool? needsSync,
  }) {
    return SyncMetadata(
      lastSync: lastSync ?? this.lastSync,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      needsSync: needsSync ?? this.needsSync,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastSync': lastSync?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'needsSync': needsSync,
    };
  }

  factory SyncMetadata.fromJson(Map<String, dynamic> json) {
    return SyncMetadata(
      lastSync: json['lastSync'] != null ? DateTime.parse(json['lastSync'] as String) : null,
      lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated'] as String) : null,
      needsSync: json['needsSync'] as bool? ?? false,
    );
  }
}

/// Status of sync operation
@freezed
abstract class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required bool needsSync,
    required List<KhatmaDto> khatmas,
    required List<CompletionHistoryDto> history,
    required int totalCount,
    String? lastSyncTime,
    int? minutesSinceLastSync,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, Object?> json) =>
      _$SyncStatusFromJson(json);
}

/// Result of sync operation
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

  factory SyncResult.fromJson(Map<String, Object?> json) =>
      _$SyncResultFromJson(json);

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
