import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/data/remote/khatma_history_repository.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';

import 'sync_models.dart';
import 'sync_operations.dart';

part 'sync_manager.g.dart';

@riverpod
class SyncManager extends _$SyncManager {
  late final LocalKhatmaRepository _localRepo;
  late final SyncOperations _operations;

  Timer? _autoSyncTimer;
  Timer? _backgroundSyncTimer;
  bool _isSyncing = false;
  DateTime? _lastPullFromRemote;
  DateTime? _lastSuccessfulSync;
  int _consecutiveFailures = 0;

  bool _hasDataChanged = false;
  StreamController<bool>? _syncStatusController;

  @override
  bool build() {
    _localRepo = ref.read(localKhatmaRepositoryProvider);
    final remoteRepo = ref.read(khatmasRepositoryProvider);
    final remoteHistoryRepo = ref.read(khatmaHistoryRepositoryProvider);

    _operations = SyncOperations(
      localRepo: _localRepo,
      remoteRepo: remoteRepo,
      remoteHistoryRepo: remoteHistoryRepo,
      getUserId: _getUserId,
      setDataChanged: (value) => _hasDataChanged = value,
    );

    _syncStatusController = StreamController<bool>.broadcast();
    return true;
  }

  /// Stream to listen for sync status changes instead of callbacks
  Stream<bool> get syncStatusStream =>
      _syncStatusController?.stream ?? const Stream.empty();

  void setupSynchronization({
    bool enableBackgroundSync = true,
    Duration? customInterval,
  }) {
    _autoSyncTimer?.cancel();
    _backgroundSyncTimer?.cancel();

    final interval = customInterval ?? SyncConfig.autoSyncInterval;

    _autoSyncTimer = Timer.periodic(interval, (timer) async {
      await performSmartSync();
    });

    if (enableBackgroundSync) {
      _backgroundSyncTimer =
          Timer.periodic(SyncConfig.backgroundSyncInterval, (timer) async {
        await performSync(syncType: SyncType.fullSync, silent: true);
      });
    }
  }

  void scheduleStartupSync({bool forceFullSync = false}) {
    Future.delayed(SyncConfig.startupSyncDelay, () async {
      await performSync(
        syncType: forceFullSync ? SyncType.fullSync : SyncType.smartSync,
      );
    });
  }

  void dispose() {
    _autoSyncTimer?.cancel();
    _backgroundSyncTimer?.cancel();
    _syncStatusController?.close();
  }

  /// Intelligent sync that adapts based on conditions
  Future<void> performSmartSync() async {
    if (_isSyncing || !_isUserAuthenticated()) return;

    final needsPull = _shouldPullFromRemote();
    final hasLocalChanges = await _hasLocalChangesToSync();

    if (!needsPull && !hasLocalChanges) {
      return;
    }

    final syncType = needsPull
        ? (hasLocalChanges ? SyncType.fullSync : SyncType.pullOnly)
        : SyncType.pushOnly;

    await performSync(syncType: syncType);
  }

  /// Main sync method with improved control
  Future<void> performSync({
    SyncType syncType = SyncType.smartSync,
    bool silent = false,
    bool forceRefresh = false,
  }) async {
    if (_isSyncing) return;
    if (!_isUserAuthenticated()) return;

    _isSyncing = true;
    _hasDataChanged = false;

    if (!silent) {
      _syncStatusController?.add(true);
    }

    try {
      switch (syncType) {
        case SyncType.pushOnly:
          await _performPushOnlySync();
          break;
        case SyncType.pullOnly:
          await _pullDataFromRemoteWithRetry();
          break;
        case SyncType.fullSync:
          await _performFullSync();
          break;
        case SyncType.smartSync:
          await _performSmartSyncInternal();
          break;
      }

      _lastSuccessfulSync = DateTime.now();
      _consecutiveFailures = 0;

      if ((_hasDataChanged || forceRefresh) && !silent) {
        _syncStatusController?.add(false);
      }
    } catch (e) {
      _consecutiveFailures++;
      _adjustSyncIntervalOnFailure();

      if (!silent) {
        _syncStatusController?.add(false);
      }
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _performSmartSyncInternal() async {
    final hasLocalChanges = await _hasLocalChangesToSync();
    final needsPull = _shouldPullFromRemote();

    if (hasLocalChanges) {
      await _performPushOnlySync();
    }

    if (needsPull) {
      await _pullDataFromRemoteWithRetry();
    }
  }

  Future<void> _performPushOnlySync() async {
    await _localRepo.performSync(
      onSyncKhatma: _operations.pushKhatmaToRemote,
      onSyncHistory: _operations.pushHistoryToRemote,
    );
  }

  Future<void> _performFullSync() async {
    await _pullDataFromRemoteWithRetry();
    await _performPushOnlySync();
  }

  /// Check if we should pull from remote based on time and conditions
  bool _shouldPullFromRemote() {
    if (_lastPullFromRemote == null) return true;

    final timeSinceLastPull = DateTime.now().difference(_lastPullFromRemote!);

    final pullInterval = _consecutiveFailures > 0
        ? SyncConfig.forcedPullInterval ~/ 2
        : SyncConfig.forcedPullInterval;

    return timeSinceLastPull > pullInterval;
  }

  /// Check if there are local changes that need syncing
  Future<bool> _hasLocalChangesToSync() async {
    final [khatmasToSync, historyToSync] = await Future.wait([
      _localRepo.getKhatmasNeedingSync(),
      _localRepo.getHistoryNeedingSync(),
    ]);

    return khatmasToSync.isNotEmpty || historyToSync.isNotEmpty;
  }

  /// Adjust sync interval based on consecutive failures (exponential backoff)
  void _adjustSyncIntervalOnFailure() {
    if (_consecutiveFailures <= 1) return;

    _autoSyncTimer?.cancel();

    final backoffMultiplier = (1 << (_consecutiveFailures - 1)).clamp(1, 16);
    final newInterval = SyncConfig.autoSyncInterval * backoffMultiplier;

    _autoSyncTimer = Timer.periodic(newInterval, (timer) async {
      await performSmartSync();
    });
  }

  Future<AppErrorCode?> _pullDataFromRemoteWithRetry() async {
    final result = await _operations.retryOperationWithReturn(() async {
      return await _operations.pullDataFromRemote();
    });

    if (result == null) {
      _lastPullFromRemote = DateTime.now();
    }

    return result;
  }

  String _getUserId() {
    return ref.read(authRepositoryProvider).currentUser!.uid;
  }

  bool _isUserAuthenticated() {
    var currentUser = ref.read(authRepositoryProvider).currentUser;
    return currentUser != null && !currentUser.isAnonymous;
  }

  // Public methods for manual control
  Future<void> forcePullFromRemote() async {
    await performSync(syncType: SyncType.pullOnly, forceRefresh: true);
  }

  Future<void> forcePushToRemote() async {
    await performSync(syncType: SyncType.pushOnly);
  }

  Future<void> forceFullSync() async {
    await performSync(syncType: SyncType.fullSync, forceRefresh: true);
  }

  // Getters for monitoring
  bool get isSyncing => _isSyncing;
  DateTime? get lastSuccessfulSync => _lastSuccessfulSync;
  DateTime? get lastPullFromRemote => _lastPullFromRemote;
  int get consecutiveFailures => _consecutiveFailures;
}
