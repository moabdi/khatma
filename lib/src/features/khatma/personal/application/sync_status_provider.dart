// lib/src/features/sync/application/sync_status_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/khatma/personal/application/khatma_sync_manager.dart';

part 'sync_status_provider.g.dart';

/// Sync status data model
class SyncStatus {
  final bool isSyncing;
  final DateTime? lastSuccessfulSync;
  final DateTime? lastPullFromRemote;
  final int consecutiveFailures;
  final String? currentOperation;
  final bool hasError;

  const SyncStatus({
    required this.isSyncing,
    this.lastSuccessfulSync,
    this.lastPullFromRemote,
    required this.consecutiveFailures,
    this.currentOperation,
    required this.hasError,
  });

  bool get isHealthy => !hasError && consecutiveFailures == 0;
  bool get hasWarning => consecutiveFailures > 0 && consecutiveFailures < 3;
  bool get hasCriticalError => consecutiveFailures >= 3;

  SyncStatus copyWith({
    bool? isSyncing,
    DateTime? lastSuccessfulSync,
    DateTime? lastPullFromRemote,
    int? consecutiveFailures,
    String? currentOperation,
    bool? hasError,
  }) {
    return SyncStatus(
      isSyncing: isSyncing ?? this.isSyncing,
      lastSuccessfulSync: lastSuccessfulSync ?? this.lastSuccessfulSync,
      lastPullFromRemote: lastPullFromRemote ?? this.lastPullFromRemote,
      consecutiveFailures: consecutiveFailures ?? this.consecutiveFailures,
      currentOperation: currentOperation ?? this.currentOperation,
      hasError: hasError ?? this.hasError,
    );
  }
}

@riverpod
class SyncStatusNotifier extends _$SyncStatusNotifier {
  @override
  SyncStatus build() {
    final syncManager = ref.watch(syncManagerProvider.notifier);

    // Listen to sync status changes
    ref.listen(syncManagerProvider, (previous, next) {
      _updateFromSyncManager();
    });

    return SyncStatus(
      isSyncing: syncManager.isSyncing,
      lastSuccessfulSync: syncManager.lastSuccessfulSync,
      lastPullFromRemote: syncManager.lastPullFromRemote,
      consecutiveFailures: syncManager.consecutiveFailures,
      hasError: syncManager.consecutiveFailures > 0,
    );
  }

  void _updateFromSyncManager() {
    final syncManager = ref.read(syncManagerProvider.notifier);

    state = state.copyWith(
      isSyncing: syncManager.isSyncing,
      lastSuccessfulSync: syncManager.lastSuccessfulSync,
      lastPullFromRemote: syncManager.lastPullFromRemote,
      consecutiveFailures: syncManager.consecutiveFailures,
      hasError: syncManager.consecutiveFailures > 0,
    );
  }

  void setCurrentOperation(String? operation) {
    state = state.copyWith(currentOperation: operation);
  }

  void clearCurrentOperation() {
    state = state.copyWith(currentOperation: null);
  }
}
