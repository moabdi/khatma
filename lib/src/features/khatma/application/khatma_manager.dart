import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/application/khatma_state.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_manager.g.dart';

@Riverpod(keepAlive: true)
class KhatmaManager extends _$KhatmaManager {
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
    final notifier = ref.read(khatmaManagerProvider.notifier);
    final syncStatus = await _localRepo.getSyncStatus();
    notifier.state = notifier.state.copyWith(
      lastSyncStatus: syncStatus,
      pendingSyncCount: syncStatus.totalCount,
    );
  }

  */

  Future<Result<Khatma, AppErrorCode>> save(Khatma khatma) async {
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

  Future<Result<void, AppErrorCode>> delete(Khatma khatma) async {
    final khatmaId = khatma.id;
    if (khatmaId == null) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    final existingKhatma = getKhatmaById(khatmaId);
    if (existingKhatma == null) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }
    state = state.copyWith(status: AppStatus.deleting);

    try {
      if (existingKhatma.lastSync == null) {
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

  // ============================================================================
  // SHARED KHATMA METHODS
  // ============================================================================

  /// Reserve a unit for the current user in a shared khatma
  Future<Result<KhatmaShared, AppErrorCode>> reserveUnit({
    required String khatmaId,
    required int unitNumber,
    required String userId,
    required String userName,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      final updatedKhatma = khatma.reserveUnit(unitNumber, userId, userName);
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  /// Complete a unit in a shared khatma
  Future<Result<KhatmaShared, AppErrorCode>> completeUnit({
    required String khatmaId,
    required int unitNumber,
    required String userId,
    required String userName,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      final updatedKhatma = khatma.completeUnit(unitNumber, userId, userName);
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  /// Release a reserved unit in a shared khatma
  Future<Result<KhatmaShared, AppErrorCode>> releaseUnit({
    required String khatmaId,
    required int unitNumber,
    required String userId,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      final updatedKhatma = khatma.releaseUnit(unitNumber, userId);
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  /// Get all shared khatmas
  List<KhatmaShared> getSharedKhatmas() {
    return state.khatmas.valueOrEmpty.whereType<KhatmaShared>().toList();
  }

  /// Get all personal khatmas
  List<KhatmaPersonal> getPersonalKhatmas() {
    return state.khatmas.valueOrEmpty.whereType<KhatmaPersonal>().toList();
  }

  /// Join a shared khatma by reserving units and adding user as participant
  Future<Result<KhatmaShared, AppErrorCode>> joinKhatma({
    required String khatmaId,
    required List<int> reservedUnits,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    final userId = "userId";
    final userName = "userName";
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      // Update units with reservations
      final updatedUnits = [...khatma.units];

      // Reserve selected units
      for (final unitNumber in reservedUnits) {
        final existingUnitIndex = updatedUnits.indexWhere((u) => u.number == unitNumber);

        if (existingUnitIndex != -1) {
          // Update existing unit
          updatedUnits[existingUnitIndex] = updatedUnits[existingUnitIndex].copyWith(
            status: UnitStatus.reserved,
            reservedBy: userId,
            reservedByName: userName,
            reservedDate: DateTime.now(),
          );
        } else {
          // Add new unit
          updatedUnits.add(Unit(
            number: unitNumber,
            status: UnitStatus.reserved,
            reservedBy: userId,
            reservedByName: userName,
            reservedDate: DateTime.now(),
          ));
        }
      }

      // Add current user to participants if not already present
      final updatedParticipants = [...khatma.participants];
      if (!updatedParticipants.any((p) => p.userId == userId)) {
        updatedParticipants.add(Participant(
          userId: userId,
          userName: userName,
          joinedDate: DateTime.now(),
        ));
      }

      // Create updated khatma
      final updatedKhatma = khatma.copyWith(
        units: updatedUnits,
        participants: updatedParticipants,
        lastUpdated: DateTime.now(),
      );

      // Save the updated khatma
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }
}

@riverpod
Khatma? selectedKhatma(Ref ref) {
  return ref.watch(khatmaManagerProvider).selectedKhatma;
}

@riverpod
AsyncValue<List<Khatma>> allKhatmas(Ref ref) {
  final state = ref.watch(khatmaManagerProvider);
  return state.khatmas;
}

@riverpod
List<KhatmaShared> sharedKhatmas(Ref ref) {
  final state = ref.watch(khatmaManagerProvider);
  return state.khatmas.valueOrEmpty.whereType<KhatmaShared>().toList();
}

@riverpod
List<KhatmaPersonal> personalKhatmas(Ref ref) {
  final state = ref.watch(khatmaManagerProvider);
  return state.khatmas.valueOrEmpty.whereType<KhatmaPersonal>().toList();
}
