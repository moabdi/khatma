import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/data/repository/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/application/khatma_state.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_manager.g.dart';

@Riverpod(keepAlive: true)
class KhatmaManager extends _$KhatmaManager {
  late final LocalKhatmaRepository _localRepo;

  @override
  KhatmaState build() {
    _localRepo = ref.read(localKhatmaRepositoryProvider);
    refreshFromLocal();
    return const KhatmaState();
  }

  Future<Result<Khatma, AppErrorCode>> save(Khatma khatma) async {
    state = state.copyWith(status: AppStatus.saving);
    final _currentUser = ref.read(userProvider);

    try {
      if (khatma.id == null && !canCreateNew()) {
        state = state.copyWith(
          status: AppStatus.error,
          error: AppErrorCode.limitKhatmaMaxReached,
        );
        return Result.failure(AppErrorCode.limitKhatmaMaxReached);
      }

      final userId = _currentUser?.id;
      final userName = _currentUser?.displayName ?? "anonymous";

      final khatmaToSave = khatma.copyWith(
        lastUpdated: DateTime.now(),
        needsSync: true,
        creatorId: userId,
        creatorName: userName,
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

      // Preserve selectedKhatma and update it if it exists in the refreshed list
      Khatma? updatedSelectedKhatma = state.selectedKhatma;
      if (updatedSelectedKhatma != null) {
        updatedSelectedKhatma = khatmas.firstWhere(
          (k) => k.id == updatedSelectedKhatma!.id,
          orElse: () => updatedSelectedKhatma!,
        );
      }

      state = state.copyWith(
        khatmas: AsyncValue.data(khatmas),
        history: AsyncValue.data(history),
       // lastSyncStatus: syncStatus,
        selectedKhatma: updatedSelectedKhatma,
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

  /// Reserve multiple units at once for a user who is already a participant
  Future<Result<KhatmaShared, AppErrorCode>> reserveUnits({
    required String khatmaId,
    required List<int> unitNumbers,
    required String userId,
    required String userName,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      var updatedKhatma = khatma;
      for (final unitNumber in unitNumbers) {
        updatedKhatma = updatedKhatma.reserveUnit(unitNumber, userId, userName);
      }
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      print('Error saving khatma: $e');
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  /// Release multiple reserved units at once
  Future<Result<KhatmaShared, AppErrorCode>> releaseUnits({
    required String khatmaId,
    required List<int> unitNumbers,
    required String userId,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      var updatedKhatma = khatma;
      for (final unitNumber in unitNumbers) {
        updatedKhatma = updatedKhatma.releaseUnit(unitNumber, userId);
      }
      await save(updatedKhatma);
      return Result.success(updatedKhatma);
    } catch (e) {
      return Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  /// Complete multiple reserved units at once
  Future<Result<KhatmaShared, AppErrorCode>> completeUnits({
    required String khatmaId,
    required List<int> unitNumbers,
    required String userId,
  }) async {
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    final currentUser = ref.read(userProvider);
    final userName = currentUser?.displayName ?? currentUser?.email ?? 'User';

    try {
      var updatedKhatma = khatma;
      for (final unitNumber in unitNumbers) {
        updatedKhatma = updatedKhatma.completeUnit(unitNumber, userId, userName);
      }
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
    final _currentUser = ref.read(userProvider);
    final userId = _currentUser?.id;
    if (userId == null) {
      return Result.failure(AppErrorCode.authUserNotLoggedIn);
    }
    final userName = _currentUser?.displayName ?? "anonymous";
    final khatma = getKhatmaById(khatmaId);
    if (khatma == null || khatma is! KhatmaShared) {
      return Result.failure(AppErrorCode.khatmaNotFound);
    }

    try {
      // Add current user to participants if not already present
      // This respects the invitation approval flow (pending status if invitation-only)
      KhatmaShared updatedKhatma = khatma;
      if (!khatma.participants.any((p) => p.userId == userId)) {
        updatedKhatma = khatma.addParticipant(
          userId: userId,
          userName: userName,
          userPhotoUrl: null, // AppUser doesn't have photoURL field yet
        );
      }

      // Only reserve units if user is approved (or no invitation required)
      // Pending users cannot reserve units
      final userParticipant = updatedKhatma.participants.firstWhere((p) => p.userId == userId);
      if (userParticipant.isApproved && reservedUnits.isNotEmpty) {
        // Reserve selected units using domain method
        for (final unitNumber in reservedUnits) {
          updatedKhatma = updatedKhatma.reserveUnit(unitNumber, userId, userName);
        }
      }

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
