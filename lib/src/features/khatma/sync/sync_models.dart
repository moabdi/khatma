import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';

/// Configuration for sync manager
class SyncConfig {
  static const Duration autoSyncInterval = Duration(minutes: 15);
  static const Duration startupSyncDelay = Duration(seconds: 2);
  static const Duration backgroundSyncInterval = Duration(hours: 1);
  static const Duration forcedPullInterval = Duration(hours: 6);

  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration exponentialBackoffBase = Duration(seconds: 1);
}

enum SyncType {
  pushOnly,
  pullOnly,
  fullSync,
  smartSync,
}

/// Helper classes for organizing sync data
class SyncData {
  final List<Khatma> remoteKhatmas;
  final List<Khatma> localKhatmas;
  final List<Khatma> khatmasToSync;

  SyncData({
    required this.remoteKhatmas,
    required this.localKhatmas,
    required this.khatmasToSync,
  });
}

class LookupMaps {
  final Map<KhatmaID, Khatma> synchronizedKhatmaIds;
  final Map<KhatmaID, Khatma> remoteKhatmasById;
  final Map<KhatmaID, Khatma> localKhatmasById;

  LookupMaps({
    required this.synchronizedKhatmaIds,
    required this.remoteKhatmasById,
    required this.localKhatmasById,
  });
}

class HistoryData {
  final List<CompletionHistory> remoteHistory;
  final List<CompletionHistory> localHistory;
  final List<CompletionHistory> syncedHistory;

  HistoryData({
    required this.remoteHistory,
    required this.localHistory,
    required this.syncedHistory,
  });
}
