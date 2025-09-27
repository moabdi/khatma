// lib/src/features/khatma/shared/application/shared_khatma_provider.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/shared/application/shared_khatma_state.dart';
import 'package:khatma/src/features/khatma/shared/data/firebase/firebase_shared_khatma_repository.dart';
import 'package:khatma/src/features/khatma/shared/data/shared_khatma_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_khatma_provider.g.dart';

@Riverpod(keepAlive: true)
class SharedKhatmaNotifier extends _$SharedKhatmaNotifier {
  late final SharedKhatmaRepository _repository;
  late final AppUser? _appUser;
  final Map<String, StreamSubscription<Result<Khatma, AppErrorCode>>>
      _khatmaStreams = {};

  @override
  SharedKhatmaState build() {
    _repository = ref.read(sharedKhatmaRepositoryProvider);
    _appUser = ref.watch(userProvider);

    // Load user's shared khatmas on initialization
    _loadUserSharedKhatmas();

    return const SharedKhatmaState();
  }

  void dispose() {
    // Cancel all active streams
    for (final subscription in _khatmaStreams.values) {
      subscription.cancel();
    }
    _khatmaStreams.clear();
  }

  // ==================== PUBLIC METHODS ====================

  /// Save a new shared khatma
  Future<Result<Khatma, AppErrorCode>> saveKhatma(Khatma khatma) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result = await _repository.saveKhatma(khatma);

      if (result.isSuccess) {
        final savedKhatma = result.valueOrNull!;

        // Start watching the new khatma
        _watchKhatma(savedKhatma.id!);

        // Refresh the user's shared khatmas list
        await _loadUserSharedKhatmas();

        state = state.copyWith(
          status: AppStatus.idle,
          selectedKhatma: AsyncValue.data(savedKhatma),
        );
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Search for a khatma by code
  Future<Result<Khatma?, AppErrorCode>> searchKhatmaByCode(String code) async {
    if (code.trim().isEmpty) {
      return const Result.failure(AppErrorCode.validationMissingFields);
    }

    state = state.copyWith(
      status: AppStatus.loading,
      error: null,
      searchCode: code.trim().toUpperCase(),
      foundKhatma: null,
    );

    try {
      final result = await _repository.searchByCode(code.trim().toUpperCase());

      state = state.copyWith(
        status: AppStatus.idle,
        foundKhatma: result.valueOrNull,
        error: result.isFailure ? result.errorOrNull : null,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
        foundKhatma: null,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Join an existing shared khatma
  Future<Result<Khatma, AppErrorCode>> joinKhatma(String code) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    // First search for the khatma
    final searchResult = await searchKhatmaByCode(code);
    if (searchResult.isFailure || searchResult.valueOrNull == null) {
      return Result.failure(
          searchResult.errorOrNull ?? AppErrorCode.khatmaNotFound);
    }

    final khatma = searchResult.valueOrNull!;
    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result = await _repository.joinKhatma(khatma.id!, _appUser!);

      if (result.isSuccess) {
        // Start watching the joined khatma
        _watchKhatma(khatma.id!);

        // Refresh the user's shared khatmas list
        await _loadUserSharedKhatmas();

        state = state.copyWith(
          status: AppStatus.idle,
          selectedKhatma: AsyncValue.data(result.valueOrNull!),
        );
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Leave a shared khatma
  Future<Result<void, AppErrorCode>> leaveKhatma(String khatmaId) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result = await _repository.leaveKhatma(khatmaId, _appUser!.id);

      if (result.isSuccess) {
        // Stop watching the khatma
        _stopWatchingKhatma(khatmaId);

        // Refresh the user's shared khatmas list
        await _loadUserSharedKhatmas();

        // Clear selected khatma if it was the one we left
        if (state.selectedKhatma?.valueOrNull?.id == khatmaId) {
          state = state.copyWith(selectedKhatma: null);
        }

        state = state.copyWith(status: AppStatus.idle);
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Reserve/pick a part for reading
  Future<Result<KhatmaPart, AppErrorCode>> reservePart(
      String khatmaId, int partId) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result = await _repository.reservePart(
        khatmaId,
        partId,
        _appUser!.id,
        _appUser!.displayName ?? _appUser!.email ?? 'Unknown',
      );

      if (result.isSuccess) {
        state = state.copyWith(status: AppStatus.idle);

        // The real-time listener will update the khatma automatically
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Release a previously picked part
  Future<Result<void, AppErrorCode>> liberatePart(
      String khatmaId, int partId) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result =
          await _repository.liberatePart(khatmaId, partId, _appUser!.id);

      if (result.isSuccess) {
        state = state.copyWith(status: AppStatus.idle);

        // The real-time listener will update the khatma automatically
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Mark a part as completed
  Future<Result<KhatmaPart, AppErrorCode>> completePart(
      String khatmaId, int partId) async {
    if (_appUser == null) {
      return const Result.failure(AppErrorCode.authUserNotFound);
    }

    state = state.copyWith(status: AppStatus.saving, error: null);

    try {
      final result =
          await _repository.completePart(khatmaId, partId, _appUser!.id);

      if (result.isSuccess) {
        state = state.copyWith(status: AppStatus.idle);

        // Refresh participants to update completion stats
        await _loadParticipants(khatmaId);

        // The real-time listener will update the khatma automatically
      } else {
        state = state.copyWith(
          status: AppStatus.error,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Select a khatma and start watching it
  Future<void> selectKhatma(String khatmaId) async {
    state = state.copyWith(status: AppStatus.loading, error: null);

    try {
      // Start watching the khatma for real-time updates
      _watchKhatma(khatmaId);

      // Load participants
      await _loadParticipants(khatmaId);

      // If we already have the khatma cached, use it immediately
      final cachedKhatma = state.getLatestKhatma(khatmaId);
      if (cachedKhatma != null) {
        state = state.copyWith(
          selectedKhatma: AsyncValue.data(cachedKhatma),
          status: AppStatus.idle,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AppStatus.error,
        error: AppErrorCode.generalUnknown,
      );
    }
  }

  /// Clear selected khatma
  void clearSelection() {
    state = state.copyWith(selectedKhatma: null);
  }

  /// Refresh user's shared khatmas
  Future<void> refreshSharedKhatmas() async {
    await _loadUserSharedKhatmas();
  }

  // ==================== PRIVATE METHODS ====================

  Future<void> _loadUserSharedKhatmas() async {
    if (_appUser == null) {
      state = state.copyWith(
        sharedKhatmas: const AsyncValue.error(
          AppErrorCode.authUserNotFound,
          StackTrace.empty,
        ),
      );
      return;
    }

    try {
      final result = await _repository.getUserSharedKhatmas(_appUser!.id);

      if (result.isSuccess) {
        final khatmas = result.valueOrNull!;
        state = state.copyWith(
          sharedKhatmas: AsyncValue.data(khatmas),
        );

        // Start watching all user's shared khatmas
        for (final khatma in khatmas) {
          if (khatma.id != null) {
            _watchKhatma(khatma.id!);
          }
        }
      } else {
        state = state.copyWith(
          sharedKhatmas: AsyncValue.error(
            result.errorOrNull ?? AppErrorCode.generalUnknown,
            StackTrace.current,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        sharedKhatmas: AsyncValue.error(e, StackTrace.current),
      );
    }
  }

  Future<void> _loadParticipants(String khatmaId) async {
    try {
      final result = await _repository.getParticipants(khatmaId);

      if (result.isSuccess) {
        state = state.copyWith(
          participants: AsyncValue.data(result.valueOrNull!),
        );
      } else {
        state = state.copyWith(
          participants: AsyncValue.error(
            result.errorOrNull ?? AppErrorCode.generalUnknown,
            StackTrace.current,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        participants: AsyncValue.error(e, StackTrace.current),
      );
    }
  }

  void _watchKhatma(String khatmaId) {
    // Don't create duplicate streams
    if (_khatmaStreams.containsKey(khatmaId)) {
      return;
    }

    final stream = _repository.watchKhatma(khatmaId);
    final subscription = stream.listen(
      (result) {
        if (result.isSuccess) {
          final khatma = result.valueOrNull!;

          // Update the watched khatmas map
          final updatedWatchedKhatmas =
              Map<String, Khatma>.from(state.watchedKhatmas);
          updatedWatchedKhatmas[khatmaId] = khatma;

          state = state.copyWith(watchedKhatmas: updatedWatchedKhatmas);

          // If this is the selected khatma, update it
          if (state.selectedKhatma?.valueOrNull?.id == khatmaId) {
            state = state.copyWith(selectedKhatma: AsyncValue.data(khatma));
          }

          // Update the shared khatmas list if it contains this khatma
          final currentKhatmas = state.sharedKhatmasOrEmpty;
          final index = currentKhatmas.indexWhere((k) => k.id == khatmaId);
          if (index != -1) {
            final updatedKhatmas = List<Khatma>.from(currentKhatmas);
            updatedKhatmas[index] = khatma;
            state =
                state.copyWith(sharedKhatmas: AsyncValue.data(updatedKhatmas));
          }
        }
      },
      onError: (error) {
        // Handle stream errors gracefully
        state = state.copyWith(
          error: error is AppErrorCode ? error : AppErrorCode.generalUnknown,
        );
      },
    );

    _khatmaStreams[khatmaId] = subscription;
  }

  void _stopWatchingKhatma(String khatmaId) {
    final subscription = _khatmaStreams.remove(khatmaId);
    subscription?.cancel();

    // Remove from watched khatmas
    final updatedWatchedKhatmas =
        Map<String, Khatma>.from(state.watchedKhatmas);
    updatedWatchedKhatmas.remove(khatmaId);
    state = state.copyWith(watchedKhatmas: updatedWatchedKhatmas);
  }
}

// Convenience providers for accessing specific parts of the state
@riverpod
List<Khatma> userSharedKhatmas(Ref ref) {
  return ref.watch(sharedKhatmaNotifierProvider
      .select((state) => state.sharedKhatmasOrEmpty));
}

@riverpod
AsyncValue<Khatma>? selectedSharedKhatma(Ref ref) {
  return ref.watch(
      sharedKhatmaNotifierProvider.select((state) => state.selectedKhatma));
}

@riverpod
List<KhatmaParticipant> khatmaParticipants(Ref ref) {
  return ref.watch(sharedKhatmaNotifierProvider
      .select((state) => state.participantsOrEmpty));
}

@riverpod
Khatma? foundKhatmaByCode(Ref ref) {
  return ref
      .watch(sharedKhatmaNotifierProvider.select((state) => state.foundKhatma));
}
