import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/local/have_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/local/localstorage_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'local_khatma_repository.g.dart';

abstract class LocalKhatmaRepository {
  Future<Khatma> save(Khatma khatma);
  Future<Khatma?> getById(String id);
  Future<void> deleteById(String id);
  Future<List<Khatma>> fetchAll();

  Future<void> saveHistory(CompletionHistory history);
  Future<List<CompletionHistory>> getHistory();
  Future<List<CompletionHistory>> getHistoryByKhatma(String khatmaId);
  Future<void> deleteHistoryById(String id);

  Future<List<Khatma>> getNeedingAttention({int days = 3});

  Future<KhatmaStats> getStats();
  Future<DetailedStats> getDetailedStats();

  Future<List<Khatma>> getKhatmasNeedingSync();
  Future<List<CompletionHistory>> getHistoryNeedingSync();
  Future<SyncStatus> getSyncStatus();
  Future<SyncResult> performSync({
    required Future<void> Function(Khatma khatma) onSyncKhatma,
    required Future<void> Function(CompletionHistory history) onSyncHistory,
  });

  Future<void> clearAll();
}

@Riverpod(keepAlive: true)
LocalKhatmaRepository localKhatmaRepository(Ref ref) {
  if (kIsWeb) {
    return LocalStorageKhatmaRepository();
  }
  return HiveKhatmaRepository();
}
