import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/core/preferences_service.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_manager.g.dart';
part 'login_manager.freezed.dart';

class _PreferenceKeys {
  static const String authToken = 'auth_token'; // 🔒 Secure token
  static const String rememberMe = 'remember_me'; // 💭 Remember Me checkbox
  static const String userEmail = 'user_email'; // 👤 Current user email
  static const String userName = 'user_name'; // 👤 Current user name
  static const String isLoggedIn = 'is_logged_in'; // ✅ Login state
  static const String isAnonymous = 'is_anonymous'; // 👻 Anonymous flag
}

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    AppErrorCode? error,
  }) = _LoginState;
}

@riverpod
class LoginManager extends _$LoginManager {
  @override
  LoginState build() {
    return const LoginState();
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  Future<Result<void, AppErrorCode>> refreshToken() async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await user.forceRefreshIdToken();

      if (result.isSuccess) {
        ref.invalidate(authStateChangesProvider);
        final tokenResult = await user.getIdToken();
        if (tokenResult.isSuccess && tokenResult.dataOrNull != null) {
          await PreferencesService.setSecureString(
              _PreferenceKeys.authToken, tokenResult.dataOrNull!);
        }
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

  void clearError() {
    state = state.copyWith(error: null);
  }

  Future<Result<void, AppErrorCode>> submitEmailPassword({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _authenticateEmailPassword(email, password);

    if (result.isSuccess) {
      await PreferencesService.setBool(_PreferenceKeys.rememberMe, rememberMe);
      await PreferencesService.setString(_PreferenceKeys.userEmail, email);
      await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, true);
    }

    await ref.read(khatmaNotifierProvider.notifier).performSync();

    state = state.copyWith(isLoading: false, error: result.errorOrNull);
    return result;
  }

  Future<Result<void, AppErrorCode>> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await ref.read(authRepositoryProvider).signInWithGoogle();

    if (result.isSuccess) {
      final user = _authRepository.currentUser;
      if (user != null) {
        // Save user info after successful Google sign-in
        await PreferencesService.setString(
            _PreferenceKeys.userEmail, user.email ?? '');
        await PreferencesService.setString(
            _PreferenceKeys.userName, user.displayName ?? '');
        await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, true);

        // Get and save the ID token
        final tokenResult = await user.getIdToken();
        if (tokenResult.isSuccess && tokenResult.dataOrNull != null) {
          await PreferencesService.setSecureString(
              _PreferenceKeys.authToken, tokenResult.dataOrNull!);
        }
      }
      await ref.read(khatmaNotifierProvider.notifier).performSync();
    }

    state = state.copyWith(isLoading: false, error: result.errorOrNull);
    return result;
  }

  Future<Result<void, AppErrorCode>> signInAnonymously() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await ref.read(authRepositoryProvider).signInAnonymously();

    if (result.isSuccess) {
      await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, true);
      await PreferencesService.setBool(_PreferenceKeys.isAnonymous, true);
    }

    await ref.read(khatmaNotifierProvider.notifier).performSync();

    state = state.copyWith(isLoading: false, error: result.errorOrNull);
    return result;
  }

  Future<Result<void, AppErrorCode>> _authenticateEmailPassword(
      String email, String password) {
    final authRepository = ref.read(authRepositoryProvider);
    var signInWithEmailAndPassword =
        authRepository.signInWithEmailAndPassword(email, password);

    return signInWithEmailAndPassword;
  }

  Future<Result<void, AppErrorCode>> sendPasswordResetEmail(
      String email) async {
    state = state.copyWith(isLoading: true, error: null);

    final result =
        await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);

    state = state.copyWith(isLoading: false, error: result.errorOrNull);
    return result;
  }

  Future<Result<void, AppErrorCode>> confirmPasswordReset(
      String code, String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await ref
        .read(authRepositoryProvider)
        .confirmPasswordReset(code, newPassword);

    state = state.copyWith(isLoading: false, error: result.errorOrNull);
    return result;
  }

  Future<Result<void, AppErrorCode>> createAccount({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final authRepository = ref.read(authRepositoryProvider);

    final result =
        await authRepository.createUserWithEmailAndPassword(email, password);

    if (result.isFailure) {
      state = state.copyWith(isLoading: false, error: result.errorOrNull);
      return result;
    }

    if (displayName != null && displayName.isNotEmpty) {
      final updateResult =
          await authRepository.updateProfile(displayName: displayName);
      if (updateResult.isFailure) {
        state =
            state.copyWith(isLoading: false, error: updateResult.errorOrNull);
        return updateResult;
      }
    }

    await PreferencesService.setString(_PreferenceKeys.userEmail, email);
    if (displayName != null) {
      await PreferencesService.setString(_PreferenceKeys.userName, displayName);
    }
    await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, true);

    final user = _authRepository.currentUser;
    if (user != null) {
      final tokenResult = await user.getIdToken();
      if (tokenResult.isSuccess && tokenResult.dataOrNull != null) {
        await PreferencesService.setSecureString(
            _PreferenceKeys.authToken, tokenResult.dataOrNull!);
      }
    }

    state = state.copyWith(isLoading: false);
    return const Result.success(null);
  }

  Future<Result<void, AppErrorCode>> signOut() async {
    if (state.isLoading) {
      return const Result.failure(AppErrorCode.generalInvalidOperation);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authRepository.signOut();

      if (result.isSuccess) {
        await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, false);
        await PreferencesService.remove(_PreferenceKeys.userName);
        await PreferencesService.remove(_PreferenceKeys.isAnonymous);

        await PreferencesService.deleteSecureString(_PreferenceKeys.authToken);

        final rememberResult =
            await PreferencesService.getBool(_PreferenceKeys.rememberMe);
        if (rememberResult.isFailure || !(rememberResult.dataOrNull ?? false)) {
          await PreferencesService.remove(_PreferenceKeys.userEmail);
        }

        state = const LoginState();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorOrNull,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppErrorCode.generalUnknown,
      );
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  Future<Result<bool, AppErrorCode>> checkAutoLogin() async {
    try {
      final isLoggedInResult =
          await PreferencesService.getBool(_PreferenceKeys.isLoggedIn);
      if (isLoggedInResult.isFailure ||
          !(isLoggedInResult.dataOrNull ?? false)) {
        return const Result.success(false);
      }

      final tokenResult =
          await PreferencesService.getSecureString(_PreferenceKeys.authToken);
      if (tokenResult.isFailure || tokenResult.dataOrNull == null) {
        await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, false);
        return const Result.success(false);
      }

      final currentUser = _authRepository.currentUser;
      if (currentUser == null) {
        await _clearInvalidSession();
        return const Result.success(false);
      }

      final refreshResult = await currentUser.forceRefreshIdToken();
      if (refreshResult.isFailure) {
        await _clearInvalidSession();
        return const Result.success(false);
      }

      final newTokenResult = await currentUser.getIdToken();
      if (newTokenResult.isSuccess && newTokenResult.dataOrNull != null) {
        await PreferencesService.setSecureString(
            _PreferenceKeys.authToken, newTokenResult.dataOrNull!);
      }

      return const Result.success(true);
    } catch (e) {
      await _clearInvalidSession();
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  Future<Result<String?, AppErrorCode>> getCurrentToken() async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    try {
      final tokenResult = await user.getIdToken(); // Force refresh
      if (tokenResult.isSuccess && tokenResult.dataOrNull != null) {
        await PreferencesService.setSecureString(
            _PreferenceKeys.authToken, tokenResult.dataOrNull!);
        return Result.success(tokenResult.dataOrNull);
      }
      return const Result.failure(AppErrorCode.authSessionExpired);
    } catch (e) {
      return const Result.failure(AppErrorCode.authSessionExpired);
    }
  }

  Future<Result<String?, AppErrorCode>> getStoredToken() async {
    return await PreferencesService.getSecureString(_PreferenceKeys.authToken);
  }

  Future<void> _clearInvalidSession() async {
    await PreferencesService.setBool(_PreferenceKeys.isLoggedIn, false);
    await PreferencesService.remove(_PreferenceKeys.userEmail);
    await PreferencesService.remove(_PreferenceKeys.userName);
    await PreferencesService.remove(_PreferenceKeys.isAnonymous);
    await PreferencesService.deleteSecureString(_PreferenceKeys.authToken);
  }

  Future<String?> getSavedEmail() async {
    final result =
        await PreferencesService.getString(_PreferenceKeys.userEmail);
    return result.dataOrNull;
  }

  Future<bool> isRememberMeEnabled() async {
    final result = await PreferencesService.getBool(_PreferenceKeys.rememberMe);
    return result.dataOrNull ?? false;
  }
}

@riverpod
Future<bool> rememberMe(Ref ref) {
  return ref.watch(loginManagerProvider.notifier).isRememberMeEnabled();
}

@riverpod
bool isLoginLoading(Ref ref) {
  final loginState = ref.watch(loginManagerProvider);
  return loginState.isLoading;
}

@riverpod
AppErrorCode? loginError(Ref ref) {
  final loginState = ref.watch(loginManagerProvider);
  return loginState.error;
}
