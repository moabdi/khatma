import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/features/authentication/application/login_manager.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_manager.g.dart';
part 'account_manager.freezed.dart';

/// État pour les opérations de gestion de compte
@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    @Default(false) bool isLoading,
    AppUser? user,
    AppErrorCode? error,
  }) = _AccountState;
}

/// Provider métier pour les opérations de gestion de compte
@riverpod
class AccountManager extends _$AccountManager {
  @override
  AccountState build() {
    return const AccountState();
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  // ==================== PROFILE MANAGEMENT ====================

  /// Mettre à jour le nom d'affichage
  Future<Result<void, AppErrorCode>> updateDisplayName(
      String displayName) async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    final trimmedName = displayName.trim();
    if (trimmedName.isEmpty) {
      return const Result.failure(AppErrorCode.validationMissingFields);
    }

    if (trimmedName.length < 2) {
      return const Result.failure(AppErrorCode.validationInvalidData);
    }

    if (trimmedName.length > 50) {
      return const Result.failure(AppErrorCode.validationOutOfRange);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result =
          await _authRepository.updateProfile(displayName: trimmedName);

      if (result.isSuccess) {
        ref.invalidate(authStateChangesProvider);
      }

      state = state.copyWith(
        isLoading: false,
        error: result.isFailure ? result.errorOrNull : null,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Mettre à jour le profil complet
  Future<Result<void, AppErrorCode>> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authRepository.updateProfile(
        displayName: displayName?.trim(),
      );

      if (result.isSuccess) {
        ref.invalidate(authStateChangesProvider);
      }

      state = state.copyWith(
        isLoading: false,
        error: result.isFailure ? result.errorOrNull : null,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  // ==================== PASSWORD MANAGEMENT ====================

  /// Changer le mot de passe
  Future<Result<void, AppErrorCode>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    // Validation du nouveau mot de passe
    final passwordValidation = _validatePassword(newPassword);
    if (passwordValidation != null) {
      return Result.failure(passwordValidation);
    }

    // Vérifier que les mots de passe sont différents
    if (currentPassword == newPassword) {
      return const Result.failure(AppErrorCode.validationInvalidData);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Ré-authentifier avec le mot de passe actuel
      final reauthResult =
          await _authRepository.reauthenticateWithPassword(currentPassword);
      if (reauthResult.isFailure) {
        state = state.copyWith(
          isLoading: false,
          error: reauthResult.errorOrNull,
        );
        return reauthResult;
      }

      // Mettre à jour le mot de passe
      final updateResult = await _authRepository.updatePassword(newPassword);

      state = state.copyWith(
        isLoading: false,
        error: updateResult.isFailure ? updateResult.errorOrNull : null,
      );

      return updateResult;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  // ==================== EMAIL VERIFICATION ====================

  /// Envoyer un email de vérification
  Future<Result<void, AppErrorCode>> sendEmailVerification() async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    final user = _authRepository.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    if (user.emailVerified) {
      return const Result.failure(AppErrorCode.validationInvalidOperation);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await user.sendEmailVerification();

      state = state.copyWith(
        isLoading: false,
        error: result.isFailure ? result.errorOrNull : null,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Vérifier l'état de vérification de l'email
  Future<Result<void, AppErrorCode>> checkEmailVerification() async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await user.forceRefreshIdToken();

      if (result.isSuccess) {
        ref.invalidate(authStateChangesProvider);
      }

      state = state.copyWith(
        isLoading: false,
        error: result.isFailure ? result.errorOrNull : null,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  // ==================== ACCOUNT DELETION ====================

  /// Supprimer le compte utilisateur
  Future<Result<void, AppErrorCode>> deleteAccount(
      {required String password}) async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    final user = _authRepository.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    if (password.trim().isEmpty) {
      return const Result.failure(AppErrorCode.validationMissingFields);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Ré-authentifier avant suppression
      final reauthResult =
          await _authRepository.reauthenticateWithPassword(password);
      if (reauthResult.isFailure) {
        state = state.copyWith(
          isLoading: false,
          error: reauthResult.errorOrNull,
        );
        return reauthResult;
      }

      // Supprimer le compte
      final deleteResult = await _authRepository.deleteAccount();

      if (deleteResult.isSuccess) {
        // Réinitialiser l'état après suppression réussie
        state = const AccountState();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: deleteResult.errorOrNull,
        );
      }

      return deleteResult;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  // ==================== UTILITIES ====================

  /// Valider un mot de passe
  AppErrorCode? _validatePassword(String password) {
    if (password.length < 8) {
      return AppErrorCode.authWeakPassword;
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return AppErrorCode.authWeakPassword;
    }

    return null;
  }

  /// Réinitialiser l'état d'erreur
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Vérifier si une opération est en cours
  bool get isAnyOperationInProgress => state.isLoading;
}

// ==================== PROVIDERS AUXILIAIRES ====================

/// Provider pour l'état de chargement account
@riverpod
bool isAccountLoading(Ref ref) {
  final accountState = ref.watch(accountManagerProvider);
  return accountState.isLoading;
}

/// Provider pour les erreurs account
@riverpod
AppErrorCode? accountError(Ref ref) {
  final accountState = ref.watch(accountManagerProvider);
  return accountState.error;
}

/// Provider pour l'état de chargement global (login OU account)
@riverpod
bool isAuthLoading(Ref ref) {
  // Note: Vous devrez importer login_manager.dart pour utiliser isLoginLoadingProvider
  // import 'login_manager.dart';
  final loginLoading = ref.watch(loginManagerProvider).isLoading;
  final accountLoading = ref.watch(accountManagerProvider).isLoading;
  return loginLoading || accountLoading;
}
