import 'dart:async';

import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/application/khatma_state.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/features/khatma/application/khatma_sync_manager.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';

part 'khatmat_provider.g.dart';

@Riverpod(keepAlive: true)
class KhatmaNotifier extends _$KhatmaNotifier {
  late final LocalKhatmaRepository _localRepo;
  late final SyncManager _syncManager;
  StreamSubscription? _syncSubscription;

  @override
  KhatmaState build() {
    _localRepo = ref.read(localKhatmaRepositoryProvider);
    _syncManager = ref.read(syncManagerProvider.notifier);
    _syncManager.setupSynchronization();
    _syncManager.scheduleStartupSync();
    _setupSyncListener();
    refreshFromLocal();
    return const KhatmaState();
  }

  void _setupSyncListener() {
    _syncSubscription?.cancel();
    _syncSubscription = ref
        .read(syncManagerProvider.notifier)
        .syncStatusStream
        .listen((isSyncing) {
      if (isSyncing) {
        refreshFromLocal();
      }
    });
  }

  void dispose() {
    final syncManager = ref.read(syncManagerProvider.notifier);
    syncManager.dispose();
  }

  Future<void> performSync() async {
    if (!_isUserAuthenticated()) return;

    state = state.copyWith(status: AppStatus.syncing);

    try {
      final syncManager = ref.read(syncManagerProvider.notifier);
      await syncManager.forceFullSync();
      await refreshFromLocal();
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.syncGeneralFailure,
      );
    }
  }

  Future<void> updateSyncStatus() async {
    final notifier = ref.read(khatmaNotifierProvider.notifier);
    final syncStatus = await _localRepo.getSyncStatus();
    notifier.state = notifier.state.copyWith(
      lastSyncStatus: syncStatus,
      pendingSyncCount: syncStatus.totalCount,
    );
  }

  Future<Result<Khatma, AppErrorCode>> saveKhatma(Khatma khatma) async {
    state = state.copyWith(status: AppStatus.saving);

    try {
      final validation = khatma.validate();
      if (validation != AppErrorCode.noError) {
        state = state.copyWith(
          status: AppStatus.error,
          error: validation,
        );
        return Result.failure(validation);
      }

      if (khatma.id == null && !canCreateNew()) {
        state = state.copyWith(
          status: AppStatus.error,
          error: AppErrorCode.limitKhatmaMaxReached,
        );
        return Result.failure(AppErrorCode.limitKhatmaMaxReached);
      }

      final localKhatma = await _localRepo.save(khatma.copyWith(
        lastUpdated: DateTime.now(),
        needsSync: true, // Reset needsSync on save
      ));

      await refreshFromLocal();
      state = state.copyWith(
        selectedKhatma: localKhatma,
        status: AppStatus.idle,
        error: null,
      );

      return Result.success(localKhatma);
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.storageSaveFailed,
      );
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  Future<Result<Khatma, AppErrorCode>> completeParts(
      String khatmaId, List<int> partIds) async {
    try {
      final currentKhatma = getKhatmaById(khatmaId);
      if (currentKhatma == null) {
        return Result.failure(AppErrorCode.khatmaNotFound);
      }

      final updatedKhatma = currentKhatma.addCompletedParts(partIds);
      await _localRepo.save(updatedKhatma.copyWith(
        lastUpdated: DateTime.now(),
        needsSync: true, // Reset needsSync on save
      ));

      if (updatedKhatma.isCompleted) {
        await _handleKhatmaCompletion(updatedKhatma);
      }

      await refreshFromLocal();

      state = state.copyWith(selectedKhatma: updatedKhatma);

      return Result.success(updatedKhatma);
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.storageSaveFailed,
      );
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  Future<Result<void, AppErrorCode>> deleteKhatma(String khatmaId) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }
    state = state.copyWith(status: AppStatus.deleting);

    try {
      if (khatma.lastSync == null) {
        // If khatma was never synced, we can delete it directly
        await _localRepo.deleteById(khatmaId);
      } else {
        await _localRepo.save(khatma.copyWith(
          lastUpdated: DateTime.now(),
          needsSync: true,
          status: KhatmaStatus.deleted,
        ));
      }
      await refreshFromLocal();

      state = state.copyWith(
        status: AppStatus.idle,
        selectedKhatma:
            state.selectedKhatma?.id == khatmaId ? null : state.selectedKhatma,
      );

      return const Result.success(null);
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.storageDeleteFailed,
      );
      return Result.failure(AppErrorCode.storageDeleteFailed);
    }
  }

  Khatma? getKhatmaById(String id) {
    return state.khatmas.valueOrNull?.firstWhere(
      (khatma) => khatma.id == id,
    );
  }

  void selectKhatma(Khatma? khatma) {
    state = state.copyWith(selectedKhatma: khatma);
  }

  Future<List<Khatma>> getKhatmasNeedingAttention({int days = 3}) async {
    return await _localRepo.getNeedingAttention(days: days);
  }

  Future<KhatmaStats> getLocalStats() async {
    return await _localRepo.getStats();
  }

  Future<DetailedStats> getDetailedStats() async {
    return await _localRepo.getDetailedStats();
  }

  bool canCreateNew() {
    return state.khatmas.valueOrEmpty.length < 10;
  }

  Future<LimitInfo> getLimitInfo() async {
    final khatmas = state.khatmas.valueOrEmpty;
    const maxKhatmas = 10;

    return LimitInfo(
      current: khatmas.length,
      max: maxKhatmas,
      available: maxKhatmas - khatmas.length,
      canCreate: khatmas.length < maxKhatmas,
    );
  }

  Future<void> refreshFromLocal() async {
    try {
      final khatmas = await _localRepo.fetchAll();
      final history = await _localRepo.getHistory();
      final syncStatus = await _localRepo.getSyncStatus();

      state = state.copyWith(
        khatmas: AsyncValue.data(khatmas),
        history: AsyncValue.data(history),
        lastSyncStatus: syncStatus,
        status: AppStatus.idle,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        khatmas: AsyncValue.error(e, StackTrace.current),
        status: AppStatus.error,
        error: AppErrorCode.storageLoadFailed,
      );
    }
  }

  Future<void> _handleKhatmaCompletion(Khatma completedKhatma) async {
    try {
      final history = CompletionHistory(
        khatmaId: completedKhatma.id,
        startDate: completedKhatma.startDate,
        endDate: completedKhatma.endDate ?? DateTime.now(),
        completionMode: 1,
        needsSync: true,
      );

      await _localRepo.saveHistory(history);

      if (completedKhatma.repeat) {
        final newKhatma = completedKhatma.copyWith(
          id: completedKhatma.id,
          startDate: DateTime.now(),
          endDate: null,
          lastRead: null,
          readParts: [],
          status: KhatmaStatus.active,
          repeats: (completedKhatma.repeats ?? 0) + 1,
          lastUpdated: DateTime.now(),
          needsSync: true,
        );

        await saveKhatma(newKhatma);
      } else {
        await deleteKhatma(completedKhatma.id!);
      }

      await refreshFromLocal();
      await updateSyncStatus();
    } catch (e) {
      rethrow;
    }
  }

  bool _isUserAuthenticated() {
    var currentUser = ref.read(authRepositoryProvider).currentUser;
    return currentUser != null && !currentUser.isAnonymous;
  }
}

@riverpod
Khatma? selectedKhatma(Ref ref) {
  return ref.watch(khatmaNotifierProvider).selectedKhatma;
}

@riverpod
AsyncValue<List<Khatma>> allKhatmas(Ref ref) {
  final state = ref.watch(khatmaNotifierProvider);
  return state.khatmas;
}
