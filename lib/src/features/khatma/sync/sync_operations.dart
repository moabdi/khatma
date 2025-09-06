import 'dart:async';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/data/remote/khatma_history_repository.dart';
import 'package:khatma/src/features/khatma/data/remote/khatmas_repository.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'sync_models.dart';

class SyncOperations {
  final LocalKhatmaRepository localRepo;
  final KhatmasRepository remoteRepo;
  final KhatmaHistoryRepository remoteHistoryRepo;
  final String Function() getUserId;
  final void Function(bool) setDataChanged;

  SyncOperations({
    required this.localRepo,
    required this.remoteRepo,
    required this.remoteHistoryRepo,
    required this.getUserId,
    required this.setDataChanged,
  });

  /// Push operations
  Future<void> pushKhatmaToRemote(Khatma khatma) async {
    final userUid = getUserId();
    await _retryOperation(() async {
      if (khatma.status == KhatmaStatus.deleted) {
        await remoteRepo.deleteById(userUid, khatma.id!);
        await localRepo.deleteById(khatma.id!);
        setDataChanged(true);
      } else {
        final updatedKhatma =
            khatma.copyWith(lastSync: DateTime.now(), needsSync: false);
        if (khatma.id == null) {
          await remoteRepo.create(userUid, khatma);
          setDataChanged(true);
        } else {
          await remoteRepo.update(userUid, updatedKhatma);
          setDataChanged(true);
        }
        await localRepo.save(updatedKhatma);
      }
    });
  }

  Future<void> pushHistoryToRemote(CompletionHistory history) async {
    final userUid = getUserId();
    await _retryOperation(() async {
      if (history.isDeleted) {
        await remoteHistoryRepo.deleteById(userUid, history.id!);
        await localRepo.deleteById(history.id!);
        setDataChanged(true);
      } else {
        final updatedHistory =
            history.copyWith(lastSync: DateTime.now(), needsSync: false);
        await remoteHistoryRepo.create(userUid, updatedHistory);
        await localRepo.saveHistory(updatedHistory);
        setDataChanged(true);
      }
    });
  }

  /// Pull operations
  Future<AppErrorCode?> pullDataFromRemote() async {
    try {
      final userUid = getUserId();
      var lastSyncDate = DateTime.now();

      final hadChanges = await Future.wait([
        refreshKhatmaFromRemote(userUid, lastSyncDate),
        refreshHistoryFromRemote(userUid, lastSyncDate),
      ]);

      final hasChanges = hadChanges.any((changed) => changed);
      if (hasChanges) setDataChanged(true);

      return null;
    } catch (e) {
      return AppErrorCode.syncGeneralFailure;
    }
  }

  Future<bool> refreshKhatmaFromRemote(
      String userUid, DateTime lastSyncDate) async {
    final syncData = await _fetchSyncData(userUid);

    if (!_hasRemoteChanges(syncData)) {
      return false;
    }

    final maps = _createLookupMaps(syncData);
    final operations = <Future<void>>[];

    operations.addAll(
      _processLocalKhatmas(
        syncData.localKhatmas,
        maps,
        userUid,
        lastSyncDate,
      ),
    );

    operations.addAll(
      _processNewRemoteKhatmas(
        syncData.remoteKhatmas,
        maps.localKhatmasById,
        lastSyncDate,
      ),
    );

    await Future.wait(operations);
    return true;
  }

  Future<bool> refreshHistoryFromRemote(
      String userUid, DateTime lastSyncDate) async {
    final historyData = await _fetchHistoryData(userUid);

    if (!_hasHistoryChanges(historyData)) {
      return false;
    }

    await _deleteOldHistory(historyData);
    await _saveNewHistory(historyData, lastSyncDate);
    return true;
  }

  /// Data fetching
  Future<SyncData> _fetchSyncData(String userUid) async {
    final [remoteKhatmas, localKhatmas, khatmasToSync] = await Future.wait([
      remoteRepo.fetchKhatmasList(userUid),
      localRepo.fetchAll(),
      localRepo.getKhatmasNeedingSync(),
    ]);

    return SyncData(
      remoteKhatmas: remoteKhatmas,
      localKhatmas: localKhatmas,
      khatmasToSync: khatmasToSync,
    );
  }

  Future<HistoryData> _fetchHistoryData(String userUid) async {
    final [remoteHistory, localHistory, syncedHistory] = await Future.wait([
      remoteHistoryRepo.fetchKhatmasList(userUid),
      localRepo.getHistory(),
      localRepo.getHistoryNeedingSync(),
    ]);

    return HistoryData(
      remoteHistory: remoteHistory,
      localHistory: localHistory,
      syncedHistory: syncedHistory,
    );
  }

  /// Helper methods
  LookupMaps _createLookupMaps(SyncData data) {
    return LookupMaps(
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

  bool _hasRemoteChanges(SyncData data) {
    final localCount = data.localKhatmas.length;
    final remoteCount = data.remoteKhatmas.length;
    final syncCount = data.khatmasToSync.length;

    return (localCount != remoteCount) || syncCount > 0;
  }

  bool _hasHistoryChanges(HistoryData data) {
    final localCount = data.localHistory.length;
    final remoteCount = data.remoteHistory.length;
    final syncCount = data.syncedHistory.length;

    return (localCount != remoteCount) || syncCount > 0;
  }

  List<Future<void>> _processLocalKhatmas(
    List<Khatma> localKhatmas,
    LookupMaps maps,
    String userUid,
    DateTime lastSyncDate,
  ) {
    final operations = <Future<void>>[];

    for (final local in localKhatmas) {
      final localId = local.id!;
      final remote = maps.remoteKhatmasById[localId];
      final isInSync = maps.synchronizedKhatmaIds.containsKey(localId);
      final syncedKhatma = maps.synchronizedKhatmaIds[localId];

      if (syncedKhatma?.status == KhatmaStatus.deleted) {
        operations.add(_handleDeletedKhatma(localId, userUid));
        continue;
      }

      if (remote == null) {
        if (!isInSync || local.lastSync != null) {
          operations.add(localRepo.deleteById(localId));
        }
      } else if (isInSync) {
        final mergeOp = _handleMergeCase(local, remote, lastSyncDate);
        if (mergeOp != null) operations.add(mergeOp);
      } else {
        final updatedKhatma = remote.copyWith(lastSync: lastSyncDate);
        operations.add(localRepo.save(updatedKhatma));
      }
    }

    return operations;
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
      return localRepo.save(newKhatma);
    }).toList();
  }

  Future<void> _handleDeletedKhatma(KhatmaID localId, String userUid) async {
    await Future.wait([
      localRepo.deleteById(localId),
      remoteRepo.deleteById(userUid, localId),
    ]);
  }

  Future<void>? _handleMergeCase(
    Khatma local,
    Khatma remote,
    DateTime lastSyncDate,
  ) {
    if (local.lastUpdated != null &&
        remote.lastUpdated != null &&
        local.lastUpdated!.isBefore(remote.lastUpdated!)) {
      final mergedParts = _mergeKhatmaParts(
        local.readParts ?? [],
        remote.readParts ?? [],
      );

      final updatedKhatma = remote.copyWith(
        readParts: mergedParts,
        lastSync: null,
      );
      return localRepo.save(updatedKhatma);
    }
    return null;
  }

  List<KhatmaPart> _mergeKhatmaParts(
      List<KhatmaPart> localParts, List<KhatmaPart> remoteParts) {
    final partsById = <int, KhatmaPart>{};

    for (final part in remoteParts) {
      partsById[part.id] = part;
    }

    for (final part in localParts) {
      partsById[part.id] = part;
    }

    return partsById.values.toList();
  }

  Future<void> _deleteOldHistory(HistoryData data) async {
    final syncedHistoryIds = data.syncedHistory.map((k) => k.id!).toSet();
    final remoteHistoryById = {
      for (final history in data.remoteHistory) history.id!: history
    };

    final deletions = data.localHistory
        .where((local) =>
            !remoteHistoryById.containsKey(local.id) &&
            !syncedHistoryIds.contains(local.id))
        .map((history) => localRepo.deleteHistoryById(history.id!));

    if (deletions.isNotEmpty) {
      await Future.wait(deletions);
    }
  }

  Future<void> _saveNewHistory(
    HistoryData data,
    DateTime lastSyncDate,
  ) async {
    final localHistoryIds = data.localHistory.map((k) => k.id!).toSet();

    final saves = data.remoteHistory
        .where((remote) => !localHistoryIds.contains(remote.id))
        .map((history) async {
      if (history.isDeleted) {
        await localRepo.deleteHistoryById(history.id!);
      } else {
        await localRepo.saveHistory(
          history.copyWith(lastSync: lastSyncDate),
        );
      }
    });

    if (saves.isNotEmpty) {
      await Future.wait(saves);
    }
  }

  /// Retry mechanism
  Future<void> _retryOperation(Future<void> Function() operation) async {
    for (int attempt = 0; attempt < SyncConfig.maxRetryAttempts; attempt++) {
      try {
        await operation();
        return;
      } catch (e) {
        if (attempt == SyncConfig.maxRetryAttempts - 1) {
          throw e;
        }

        final backoffDelay = SyncConfig.exponentialBackoffBase * (1 << attempt);
        await Future.delayed(backoffDelay);
      }
    }
  }

  /// Utility for retry with return value
  Future<AppErrorCode?> retryOperationWithReturn(
      Future<AppErrorCode?> Function() operation) async {
    for (int attempt = 0; attempt < SyncConfig.maxRetryAttempts; attempt++) {
      try {
        return await operation();
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
}
