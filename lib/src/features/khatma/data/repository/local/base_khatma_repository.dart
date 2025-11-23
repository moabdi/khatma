import 'dart:async';
import 'dart:convert';

import 'package:khatma/src/features/khatma/data/mappers/khatma_history_mappers.dart';
import 'package:khatma/src/features/khatma/data/mappers/khatma_mappers.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_history_dto.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/sync/sync_models.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:uuid/uuid.dart';

abstract class BaseKhatmaRepository extends LocalKhatmaRepository {
  String khatmaBox = "KHATMAT_BOX";
  String historyBox = "HISTORY_BOX";
  Future<StorageBox> openKhatmaBox();
  Future<StorageBox> openHistoryBox();

  Future<Khatma> save(Khatma khatma) async {
    var box = await openKhatmaBox();

    if (khatma.id == null) {
      khatma = khatma.copyWith(id: const Uuid().v4());
    }

    String jsonString = jsonEncode(khatma.toDto().toJson());
    print('Saving Khatma: $jsonString');
    await box.put(khatma.id!, jsonString);
    return khatma;
  }

  Future<Khatma?> getById(String id) async {
    var box = await openKhatmaBox();
    String? jsonString = box.get(id);

    if (jsonString != null) {
      final khatmaData = jsonDecode(jsonString);
      final khatma = KhatmaDto.fromJson(khatmaData).toDomain();
      return !khatma.isDeleted ? khatma : null;
    }
    return null;
  }

  Future<void> deleteById(String id) async {
    var box = await openKhatmaBox();
    await box.delete(id);
    return;
  }

  Future<List<Khatma>> fetchAll() async {
    var box = await openKhatmaBox();

    var list = getBoxValues(box)
        .map((jsonString) {
          final khatmaData = jsonDecode(jsonString);
          final khatma = KhatmaDto.fromJson(khatmaData).toDomain();
          return !khatma.isDeleted ? khatma : null;
        })
        .where((khatma) => khatma != null)
        .cast<Khatma>()
        .toList();

    list.sort((k1, k2) => k1.createDate.compareTo(k2.createDate));
    return list;
  }

  Future<void> saveHistory(KhatmaHistory history) async {
    var box = await openHistoryBox();

    final id = history.id ?? const Uuid().v4();
    final historyWithId = history.copyWith(id: id);

    String jsonString = jsonEncode(historyWithId.toDto().toJson());
    await box.put(id, jsonString);
  }

  Future<List<KhatmaHistory>> getHistory() async {
    var box = await openHistoryBox();

    return getBoxValues(box)
        .map((jsonString) => KhatmaHistoryDto.fromJson(jsonDecode(jsonString)).toDomain())
        .toList();
  }

  Future<void> deleteHistoryById(String id) async {
    var box = await openHistoryBox();
    await box.delete(id);
    return;
  }

  Future<List<Khatma>> getKhatmasNeedingSync() async {
    var box = await openKhatmaBox();

    return getBoxValues(box)
        .map((jsonString) {
          final khatmaData = jsonDecode(jsonString);
          final khatma = KhatmaDto.fromJson(khatmaData).toDomain();

          if (khatma.needsSync) return khatma;

          return null;
        })
        .where((khatma) => khatma != null)
        .cast<Khatma>()
        .toList();
  }

  Future<List<KhatmaHistory>> getHistoryNeedingSync() async {
    var box = await openHistoryBox();

    return getBoxValues(box)
        .map((jsonString) {
          final historyData = jsonDecode(jsonString);
         // final completion = KhatmaHistoryDto.fromJson(historyData).toDomain();
        //  if (completion.needsSync) return completion;

          return null;
        })
        .where((history) => history != null)
        .cast<KhatmaHistory>()
        .toList();
  }

  // Méthodes communes partagées
  Future<List<Khatma>> search(String query) async {
    final allKhatmas = await fetchAll();
    final lowerQuery = query.toLowerCase();

    return allKhatmas.where((khatma) {
      return khatma.name.toLowerCase().contains(lowerQuery) ||
          (khatma.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  Future<List<Khatma>> getNeedingAttention({int days = 3}) async {
    final allKhatmas = await fetchAll();
    final now = DateTime.now();

    return allKhatmas.where((khatma) {
      // Get lastRead only for personal and hifz khatmas
      DateTime? lastReadDate;
      if (khatma is KhatmaPersonal) {
        lastReadDate = khatma.lastRead;
      } else if (khatma is KhatmaHifz) {
        lastReadDate = khatma.lastRead;
      }

      final referenceDate = lastReadDate ?? khatma.startDate;
      final daysSinceLastRead = now.difference(referenceDate).inDays;
      return daysSinceLastRead >= days;
    }).toList();
  }

  // Stats methods removed - should be implemented at the application layer
  // using the data from fetchAll() and getHistory()

  Future<List<KhatmaHistory>> getHistoryByKhatma(String khatmaId) async {
    final allHistory = await getHistory();
    return allHistory.where((h) => h.khatmaId == khatmaId).toList();
  }

  Future<SyncStatus> getSyncStatus() async {
    final khatmasNeedingSync = await getKhatmasNeedingSync();
    final historyNeedingSync = await getHistoryNeedingSync();
    final totalNeedingSync =
        khatmasNeedingSync.length + historyNeedingSync.length;

    DateTime? lastSyncTime;
    var khatmaBox = await openKhatmaBox();
    var historyBox = await openHistoryBox();

    // Recherche du dernier sync dans les khatmas
    for (String jsonString in getBoxValues(khatmaBox)) {
      final data = jsonDecode(jsonString);
      if (data['lastSync'] != null) {
        final syncTime = DateTime.parse(data['lastSync']);
        if (lastSyncTime == null || syncTime.isAfter(lastSyncTime)) {
          lastSyncTime = syncTime;
        }
      }
    }

    // Recherche du dernier sync dans l'historique
    for (String jsonString in getBoxValues(historyBox)) {
      final data = jsonDecode(jsonString);
      if (data['lastSync'] != null) {
        final syncTime = DateTime.parse(data['lastSync']);
        if (lastSyncTime == null || syncTime.isAfter(lastSyncTime)) {
          lastSyncTime = syncTime;
        }
      }
    }

    // Convert domain models to DTOs for SyncStatus
    final khatmaDtos = khatmasNeedingSync.map((k) => k.toDto()).toList();
    final historyDtos = historyNeedingSync.map((h) => h.toDto()).toList();

    return SyncStatus(
      needsSync: totalNeedingSync > 0,
      khatmas: khatmaDtos,
      history: historyDtos,
      totalCount: totalNeedingSync,
      lastSyncTime: lastSyncTime?.toIso8601String(),
      minutesSinceLastSync: lastSyncTime != null
          ? DateTime.now().difference(lastSyncTime).inMinutes
          : null,
    );
  }

  Future<SyncResult> performSync({
    required Future<void> Function(Khatma khatma) onSyncKhatma,
    required Future<void> Function(KhatmaHistory history) onSyncHistory,
  }) async {
    int syncedKhatmas = 0;
    int syncedHistory = 0;
    List<String> errors = [];

    try {
      final khatmasToSync = await getKhatmasNeedingSync();
      final historyToSync = await getHistoryNeedingSync();

      for (var khatma in khatmasToSync) {
        try {
          await onSyncKhatma(khatma);
          syncedKhatmas++;
        } catch (e) {
          errors.add('Khatma ${khatma.name}: $e');
        }
      }

      for (var history in historyToSync) {
        try {
          await onSyncHistory(history);
          syncedHistory++;
        } catch (e) {
          errors.add('History ${history.id}: $e');
        }
      }

      return SyncResult.success(
        syncedKhatmas: syncedKhatmas,
        syncedHistory: syncedHistory,
        errors: errors,
        syncTime: DateTime.now().toIso8601String(),
      );
    } catch (e) {
      return SyncResult.failure(
        error: e.toString(),
        syncedKhatmas: syncedKhatmas,
        syncedHistory: syncedHistory,
        errors: errors,
      );
    }
  }

  Future<SyncResult> syncIfNeeded({
    required Future<void> Function(Khatma khatma) onSyncKhatma,
    required Future<void> Function(KhatmaHistory history) onSyncHistory,
    required bool Function() shouldSync,
    Duration? timeSinceLastSync,
  }) async {
    if (!shouldSync()) {
      return SyncResult.notNeeded(
        reason: 'Sync conditions not met (offline or not authenticated)',
      );
    }

    final syncStatus = await getSyncStatus();

    if (timeSinceLastSync != null && syncStatus.lastSyncTime != null) {
      final lastSync = DateTime.parse(syncStatus.lastSyncTime!);
      final timeSince = DateTime.now().difference(lastSync);

      if (timeSince < timeSinceLastSync && !syncStatus.needsSync) {
        return SyncResult.notNeeded(
          reason: 'No sync needed - recent sync and no pending changes',
          lastSyncTime: syncStatus.lastSyncTime,
        );
      }
    }

    if (!syncStatus.needsSync) {
      return SyncResult.notNeeded(
        reason: 'No items need sync',
        lastSyncTime: syncStatus.lastSyncTime,
      );
    }

    return await performSync(
      onSyncKhatma: onSyncKhatma,
      onSyncHistory: onSyncHistory,
    );
  }

  Future<void> clearAll() async {
    var khatmaBox = await openKhatmaBox();
    var historyBox = await openHistoryBox();

    await clearBox(khatmaBox);
    await clearBox(historyBox);
  }

  // Méthodes utilitaires abstraites pour gérer les différences entre Hive et LocalStorage
  Iterable<String> getBoxValues(StorageBox box);
  Future<void> clearBox(StorageBox box);
}

// Interface commune pour les boxes
abstract class StorageBox {
  Iterable<String> get values;
  Future<void> clear();
  String? get(String key);
  Future<void> put(String key, String value);
  Future<void> delete(String key);
}
