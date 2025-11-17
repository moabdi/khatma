import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/repository/local/have_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_storage_box.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'local_khatma_repository.g.dart';

abstract class LocalKhatmaRepository {
  Future<Khatma> save(Khatma khatma);
  Future<Khatma?> getById(String id);
  Future<void> deleteById(String id);
  Future<List<Khatma>> fetchAll();

  Future<void> saveHistory(KhatmaHistory history);
  Future<List<KhatmaHistory>> getHistory();
  Future<List<KhatmaHistory>> getHistoryByKhatma(String khatmaId);
  Future<void> deleteHistoryById(String id);

  Future<List<Khatma>> getNeedingAttention({int days = 3});

  //Future<KhatmaStats> getStats();
  //Future<DetailedStats> getDetailedStats();

  Future<List<Khatma>> getKhatmasNeedingSync();
  Future<List<KhatmaHistory>> getHistoryNeedingSync();
  //Future<SyncStatus> getSyncStatus();
  /*Future<SyncResult> performSync({
    required Future<void> Function(Khatma khatma) onSyncKhatma,
    required Future<void> Function(CompletionHistory history) onSyncHistory,
  });
  */

  Future<void> clearAll();
}

@Riverpod(keepAlive: true)
LocalKhatmaRepository localKhatmaRepository(Ref ref) {
  if (kIsWeb) {
    return LocalStorageKhatmaRepository();
  }
  return HiveKhatmaRepository();
}
