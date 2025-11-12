import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/personal/data/remote/khatma_history_repository.dart';
import 'package:khatma/src/features/khatma/personal/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/personal/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma_domain.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';

part 'khatma_sync_manager.g.dart';

/// Configuration for sync manager
class SyncConfig {
  // More reasonable intervals to reduce costs and battery usage
  static const Duration autoSyncInterval =
      Duration(minutes: 15); // Increased from 1 minute
  static const Duration startupSyncDelay = Duration(seconds: 1);
  static const Duration backgroundSyncInterval =
      Duration(hours: 1); // For background sync
  static const Duration forcedPullInterval =
      Duration(hours: 6); // Only pull from remote every 6 hours

  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration exponentialBackoffBase = Duration(seconds: 1);
}

enum SyncType {
  pushOnly, // Only push local changes
  pullOnly, // Only pull remote changes
  fullSync, // Both push and pull
  smartSync, // Intelligent sync based on conditions
}

@Riverpod(keepAlive: true)
class SyncManager extends _$SyncManager {
  late final LocalKhatmaRepository _localRepo;
  late final KhatmasRepository _remoteRepo;
  late final KhatmaHistoryRepository _remoteHistoryRepo;

  Timer? _autoSyncTimer;
  Timer? _backgroundSyncTimer;
  bool _isSyncing = false;
  DateTime? _lastPullFromRemote;
  DateTime? _lastSuccessfulSync;
  int _consecutiveFailures = 0;

  // Track actual changes to avoid unnecessary UI refreshes
  bool _hasDataChanged = false;
  StreamController<bool>? _syncStatusController;

  @override
  bool build() {
    _localRepo = ref.read(localKhatmaRepositoryProvider);
    _remoteRepo = ref.read(khatmasRepositoryProvider);
    _remoteHistoryRepo = ref.read(khatmaHistoryRepositoryProvider);
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

    // Main sync timer - only pushes local changes most of the time
    _autoSyncTimer = Timer.periodic(interval, (timer) async {
      await performSmartSync();
    });

    // Background sync timer - less frequent, full sync
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
      // No sync needed, don't refresh UI
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
    bool silent = false, // Don't notify UI for background syncs
    bool forceRefresh = false,
  }) async {
    if (_isSyncing) return;
    if (!_isUserAuthenticated()) return;

    _isSyncing = true;
    _hasDataChanged = false;

    if (!silent) {
      _syncStatusController?.add(true); // Sync started
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

      // Only notify UI if data actually changed or force refresh is requested
      if ((_hasDataChanged || forceRefresh) && !silent) {
        _syncStatusController?.add(false); // Sync completed with changes
      }
    } catch (e) {
      _consecutiveFailures++;
      // Implement exponential backoff for failed syncs
      _adjustSyncIntervalOnFailure();

      if (!silent) {
        _syncStatusController?.add(false); // Sync completed with error
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
      onSyncKhatma: _pushKhatmaToRemote,
      onSyncHistory: _pushHistoryToRemote,
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

    // Pull more frequently if we had recent failures
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

    // Exponential backoff: 15min, 30min, 1hr, 2hr, max 4hr
    final backoffMultiplier = (1 << (_consecutiveFailures - 1)).clamp(1, 16);
    final newInterval = SyncConfig.autoSyncInterval * backoffMultiplier;

    _autoSyncTimer = Timer.periodic(newInterval, (timer) async {
      await performSmartSync();
    });
  }

  Future<void> _pushKhatmaToRemote(Khatma khatma) async {
    final userUid = _getUserId();
    await _retryOperation(() async {
      if (khatma.status == KhatmaStatus.deleted) {
        await _remoteRepo.deleteById(userUid, khatma.id!);
        await _localRepo.deleteById(khatma.id!);
        _hasDataChanged = true;
      } else {
        final updatedKhatma =
            khatma.copyWith(lastSync: DateTime.now(), needsSync: false);
        if (khatma.id == null) {
          await _remoteRepo.create(userUid, khatma);
          _hasDataChanged = true;
        } else {
          await _remoteRepo.update(userUid, updatedKhatma);
          _hasDataChanged = true;
        }
        await _localRepo.save(updatedKhatma);
      }
    });
  }

  Future<void> _pushHistoryToRemote(CompletionHistory history) async {
    final userUid = _getUserId();

    await _retryOperation(() async {
      if (history.isDeleted) {
        await _remoteHistoryRepo.deleteById(userUid, history.id!);
        await _localRepo.deleteById(history.id!);
        _hasDataChanged = true;
      } else {
        final updatedHistory =
            history.copyWith(lastSync: DateTime.now(), needsSync: false);
        await _remoteHistoryRepo.create(userUid, updatedHistory);
        await _localRepo.saveHistory(updatedHistory);
        _hasDataChanged = true;
      }
    });
  }

  Future<void> _retryOperation(Future<void> Function() operation) async {
    for (int attempt = 0; attempt < SyncConfig.maxRetryAttempts; attempt++) {
      try {
        await operation();
        return; // Success
      } catch (e) {
        if (attempt == SyncConfig.maxRetryAttempts - 1) {
          throw e; // Final attempt failed
        }

        // Exponential backoff for retries
        final backoffDelay =
            SyncConfig.exponentialBackoffBase * (1 << attempt); // 1s, 2s, 4s...
        await Future.delayed(backoffDelay);
      }
    }
  }

  Future<AppErrorCode?> _pullDataFromRemoteWithRetry() async {
    for (int attempt = 0; attempt < SyncConfig.maxRetryAttempts; attempt++) {
      try {
        final result = await pullDataFromRemote();
        if (result == null) {
          _lastPullFromRemote = DateTime.now();
        }
        return result;
      } catch (e) {
        if (attempt == SyncConfig.maxRetryAttempts - 1) {
          return AppErrorCode.syncGeneralFailure;
        }

        final backoffDelay = SyncConfig.exponentialBackoffBase * (1 << attempt);
        await Future.delayed(backoffDelay);
      }
    }
    return AppErrorCode.syncGeneralFailure;
  }

  Future<AppErrorCode?> pullDataFromRemote() async {
    if (!_isUserAuthenticated()) return null;

    try {
      final userUid = _getUserId();
      var lastSyncDate = DateTime.now();

      final hadChanges = await Future.wait([
        _refreshKhatmaFromRemote(userUid, lastSyncDate),
        _refreshHistoryFromRemote(userUid, lastSyncDate),
      ]);

      // Check if any refresh operation resulted in changes
      _hasDataChanged = hadChanges.any((changed) => changed);

      return null; // No error
    } catch (e) {
      return AppErrorCode.syncGeneralFailure;
    }
  }

  Future<bool> _refreshKhatmaFromRemote(
      String userUid, DateTime lastSyncDate) async {
    // Fetch all data upfront
    final syncData = await _fetchSyncData(userUid);

    // Early return if no changes detected
    if (!_hasRemoteChanges(syncData)) {
      return false;
    }

    // Create lookup maps
    final maps = _createLookupMaps(syncData);

    // Process sync operations
    final operations = <Future<void>>[];

    // Process existing local khatmas
    operations.addAll(
      _processLocalKhatmas(
        syncData.localKhatmas,
        maps,
        userUid,
        lastSyncDate,
      ),
    );

    // Process new remote khatmas
    operations.addAll(
      _processNewRemoteKhatmas(
        syncData.remoteKhatmas,
        maps.localKhatmasById,
        lastSyncDate,
      ),
    );

    // Execute all operations concurrently
    await Future.wait(operations);
    return true; // Changes were made
  }

  bool _hasRemoteChanges(_SyncData data) {
    // Si il y a des éléments à synchroniser localement
    if (data.khatmasToSync.isNotEmpty) return true;

    // Si les nombres diffèrent
    if (data.localKhatmas.length != data.remoteKhatmas.length) return true;

    // Créer des maps pour comparaison efficace
    final localById = {for (final k in data.localKhatmas) k.id!: k};

    // Vérifier chaque khatma remote
    for (final remote in data.remoteKhatmas) {
      final local = localById[remote.id];

      // Khatma existe seulement en remote
      if (local == null) return true;

      // Comparaison simple avec hashCode ou equals
      if (local.hashCode != remote.hashCode) return true;
      // Alternative: if (local != remote) return true;
    }

    // Vérifier s'il y a des khatmas qui existent seulement en local
    for (final local in data.localKhatmas) {
      if (!data.remoteKhatmas.any((r) => r.id == local.id)) return true;
    }

    return false;
  }

  Future<_SyncData> _fetchSyncData(String userUid) async {
    final [remoteKhatmas, localKhatmas, khatmasToSync] = await Future.wait([
      _remoteRepo.fetchKhatmasList(userUid),
      _localRepo.fetchAll(),
      _localRepo.getKhatmasNeedingSync(),
    ]);

    final khatmasLocal = [
      ...{...localKhatmas, ...khatmasToSync}
    ];

    return _SyncData(
      remoteKhatmas: remoteKhatmas,
      localKhatmas: khatmasLocal,
      khatmasToSync: khatmasToSync,
    );
  }

  _LookupMaps _createLookupMaps(_SyncData data) {
    return _LookupMaps(
      synchronizedKhatmaIds: {
        for (final khatma in data.khatmasToSync) khatma.id!: khatma
      },
      remoteKhatmasById: {
        for (final khatma in data.remoteKhatmas) khatma.id!: khatma
      },
      localKhatmasById: {
        for (final khatma in data.localKhatmas) khatma.id!: khatma
      },
    );
  }

  List<Future<void>> _processLocalKhatmas(
    List<Khatma> localKhatmas,
    _LookupMaps maps,
    String userUid,
    DateTime lastSyncDate,
  ) {
    final operations = <Future<void>>[];

    for (final local in localKhatmas) {
      final localId = local.id!;
      final remote = maps.remoteKhatmasById[localId];
      final isInSync = maps.synchronizedKhatmaIds.keys.contains(localId);

      // Handle deleted khatma
      if (local.isDeleted) {
        operations.add(_handleDeletedKhatma(localId, userUid));
        continue;
      }

      if (remote == null) {
        // Local exists, remote doesn't
        if (!isInSync || local.lastSync != null) {
          operations.add(_localRepo.deleteById(localId));
        }
      } else if (isInSync) {
        // Both exist with local changes
        final mergeOp = _handleMergeCase(local, remote, lastSyncDate, userUid);
        operations.addAll(mergeOp);
      } else {
        // Both exist, no local changes
        final updatedKhatma = remote.copyWith(lastSync: lastSyncDate);
        operations.add(_localRepo.save(updatedKhatma));
      }
    }

    return operations;
  }

  Future<void> _handleDeletedKhatma(KhatmaID localId, String userUid) async {
    await Future.wait([
      _localRepo.deleteById(localId),
      _remoteRepo.deleteById(userUid, localId),
    ]);
  }

  List<Future<Khatma>> _handleMergeCase(
    Khatma local,
    Khatma remote,
    DateTime lastSyncDate,
    String userUid,
  ) {
    final updatedKhatma;
    if (local.lastSync == remote.lastSync) {
      updatedKhatma = local.copyWith(
        lastSync: lastSyncDate,
      );
    } else {
      final mergedParts = _mergeKhatmaParts(
        local.readParts ?? [],
        remote.readParts ?? [],
      );

      updatedKhatma = remote.copyWith(
        readParts: mergedParts,
        lastSync: lastSyncDate,
      );
    }

    return [
      _localRepo.save(updatedKhatma),
      _remoteRepo.update(userUid, updatedKhatma),
    ];
  }

  List<Future<void>> _processNewRemoteKhatmas(
    List<Khatma> remoteKhatmas,
    Map<KhatmaID, Khatma> localKhatmasById,
    DateTime lastSyncDate,
  ) {
    return remoteKhatmas
        .where((remote) => !localKhatmasById.containsKey(remote.id))
        .map((remote) {
      final newKhatma = remote.copyWith(lastSync: lastSyncDate);
      return _localRepo.save(newKhatma);
    }).toList();
  }

  /// Merges read parts from local and remote, avoiding duplicates
  List<KhatmaPart> _mergeKhatmaParts(
      List<KhatmaPart> localParts, List<KhatmaPart> remoteParts) {
    final partsById = <int, KhatmaPart>{};

    // Add remote parts first (as base)
    for (final part in remoteParts) {
      partsById[part.id] = part;
    }

    // Add/override with local parts (local takes precedence for conflicts)
    for (final part in localParts) {
      partsById[part.id] = part;
    }

    return partsById.values.toList();
  }

  Future<bool> _refreshHistoryFromRemote(
      String userUid, DateTime lastSyncDate) async {
    final historyData = await _fetchHistoryData(userUid);

    // Check if there are any changes to process
    if (!_hasHistoryChanges(historyData)) {
      return false;
    }

    await _deleteOldHistory(historyData);
    await _saveNewHistory(historyData, lastSyncDate);
    return true;
  }

  bool _hasHistoryChanges(_HistoryData data) {
    final localCount = data.localHistory.length;
    final remoteCount = data.remoteHistory.length;
    final syncCount = data.syncedHistory.length;

    return (localCount != remoteCount) || syncCount > 0;
  }

  Future<_HistoryData> _fetchHistoryData(String userUid) async {
    final [remoteHistory, localHistory, syncedHistory] = await Future.wait([
      _remoteHistoryRepo.fetchKhatmasList(userUid),
      _localRepo.getHistory(),
      _localRepo.getHistoryNeedingSync(),
    ]);

    return _HistoryData(
      remoteHistory: remoteHistory,
      localHistory: localHistory,
      syncedHistory: syncedHistory,
    );
  }

  Future<void> _deleteOldHistory(_HistoryData data) async {
    final syncedHistoryIds = data.syncedHistory.map((k) => k.id!).toSet();
    final remoteHistoryById = {
      for (final history in data.remoteHistory) history.id!: history
    };

    final deletions = data.localHistory
        .where((local) =>
            !remoteHistoryById.containsKey(local.id) &&
            !syncedHistoryIds.contains(local.id))
        .map((history) => _localRepo.deleteHistoryById(history.id!));

    if (deletions.isNotEmpty) {
      await Future.wait(deletions);
    }
  }

  Future<void> _saveNewHistory(
    _HistoryData data,
    DateTime lastSyncDate,
  ) async {
    final localHistoryIds = data.localHistory.map((k) => k.id!).toSet();

    final saves = data.remoteHistory
        .where((remote) => !localHistoryIds.contains(remote.id))
        .map((history) async {
      if (history.isDeleted) {
        await _localRepo.deleteHistoryById(history.id!);
      } else {
        await _localRepo.saveHistory(
          history.copyWith(lastSync: lastSyncDate),
        );
      }
    });

    if (saves.isNotEmpty) {
      await Future.wait(saves);
    }
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

// Helper classes for organizing sync data
class _SyncData {
  final List<Khatma> remoteKhatmas;
  final List<Khatma> localKhatmas;
  final List<Khatma> khatmasToSync;

  _SyncData({
    required this.remoteKhatmas,
    required this.localKhatmas,
    required this.khatmasToSync,
  });
}

class _LookupMaps {
  final Map<KhatmaID, Khatma> synchronizedKhatmaIds;
  final Map<KhatmaID, Khatma> remoteKhatmasById;
  final Map<KhatmaID, Khatma> localKhatmasById;

  _LookupMaps({
    required this.synchronizedKhatmaIds,
    required this.remoteKhatmasById,
    required this.localKhatmasById,
  });
}

class _HistoryData {
  final List<CompletionHistory> remoteHistory;
  final List<CompletionHistory> localHistory;
  final List<CompletionHistory> syncedHistory;

  _HistoryData({
    required this.remoteHistory,
    required this.localHistory,
    required this.syncedHistory,
  });
}
