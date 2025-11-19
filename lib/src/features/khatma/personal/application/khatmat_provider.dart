import 'dart:async';

import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/personal/application/khatma_state.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/core/result.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmat_provider.g.dart';

@Riverpod(keepAlive: true)
class KhatmaNotifier extends _$KhatmaNotifier {
  late final LocalKhatmaRepository _localRepo;
  // late final SyncManager _syncManager;
  // StreamSubscription? _syncSubscription;

  @override
  KhatmaState build() {
    _localRepo = ref.read(localKhatmaRepositoryProvider);
    // _syncManager = ref.read(syncManagerProvider.notifier);
   // _syncManager.setupSynchronization();
   // _syncManager.scheduleStartupSync();
   // _setupSyncListener();
    refreshFromLocal();
    return const KhatmaState();
  }

/*
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

  */

  Future<Result<Khatma, AppErrorCode>> saveKhatma(Khatma khatma) async {
    state = state.copyWith(status: AppStatus.saving);

    try {
      if (khatma.id == null && !canCreateNew()) {
        state = state.copyWith(
          status: AppStatus.error,
          error: AppErrorCode.limitKhatmaMaxReached,
        );
        return Result.failure(AppErrorCode.limitKhatmaMaxReached);
      }

      final khatmaToSave = khatma.copyWith(
        lastUpdated: DateTime.now(),
        needsSync: true,
      );

      final localKhatma = await _localRepo.save(khatmaToSave);
      //await _syncManager.forcePushToRemote();

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

  Future<Result<void, AppErrorCode>> deleteKhatma(String khatmaId) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }
    state = state.copyWith(status: AppStatus.deleting);

    try {
      if (khatma.lastSync == null) {
        await _localRepo.deleteById(khatmaId);
      } else {
        await _localRepo.deleteById(khatmaId);
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

  bool canCreateNew() {
    return state.khatmas.valueOrEmpty.length < 10;
  }

  Future<void> refreshFromLocal() async {
    try {
      final khatmas = await _localRepo.fetchAll();
      final history = await _localRepo.getHistory();
     // final syncStatus = await _localRepo.getSyncStatus();

      state = state.copyWith(
        khatmas: AsyncValue.data(khatmas),
        history: AsyncValue.data(history),
       // lastSyncStatus: syncStatus,
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

  Future completeParts(String s, List<int> selectedParts) async {}
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