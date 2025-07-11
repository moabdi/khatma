import 'dart:async';

import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_controller.g.dart';

@riverpod
class AccountController extends _$AccountController {
  @override
  FutureOr<void> build() {}

  /// Sign out the current user
  Future<Result<void, AppErrorCode>> signOut() async {
    final result = await ref.read(authRepositoryProvider).signOut();
    return result;
  }

  /// Send email verification to the current user
  Future<Result<void, AppErrorCode>> sendEmailVerification() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      const errorCode = AppErrorCode.authUserNotLoggedIn;
      return const Result.failure(errorCode);
    }

    final result = await user.sendEmailVerification();
    return result;
  }

  /// Update user profile (display name)
  Future<Result<void, AppErrorCode>> updateProfile(
      {String? displayName}) async {
    final result = await ref
        .read(authRepositoryProvider)
        .updateProfile(displayName: displayName);
    return result;
  }

  /// Update user password (requires current password for reauthentication)
  Future<Result<void, AppErrorCode>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);

    // First, reauthenticate the user
    final reauthResult =
        await authRepository.reauthenticateWithPassword(currentPassword);
    if (reauthResult.isFailure) {
      return reauthResult;
    }

    // Then update the password
    final updateResult = await authRepository.updatePassword(newPassword);
    return updateResult;
  }

  /// Delete user account (requires password for reauthentication)
  Future<Result<void, AppErrorCode>> deleteAccount(
      {required String password}) async {
    final authRepository = ref.read(authRepositoryProvider);

    // First, reauthenticate the user
    final reauthResult =
        await authRepository.reauthenticateWithPassword(password);
    if (reauthResult.isFailure) {
      return reauthResult;
    }

    // Then delete the account
    final deleteResult = await authRepository.deleteAccount();
    return deleteResult;
  }

  /// Force refresh the user's ID token
  Future<Result<void, AppErrorCode>> refreshToken() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      const errorCode = AppErrorCode.authUserNotLoggedIn;
      return const Result.failure(errorCode);
    }

    final result = await user.forceRefreshIdToken();
    return result;
  }
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {}

  /// Update user display name
  Future<Result<void, AppErrorCode>> updateDisplayName(
      String displayName) async {
    if (displayName.trim().isEmpty) {
      const errorCode = AppErrorCode.validationMissingFields;
      return const Result.failure(errorCode);
    }

    final result = await ref
        .read(authRepositoryProvider)
        .updateProfile(displayName: displayName.trim());

    // If successful, invalidate auth state to refresh user data
    if (result.isSuccess) {
      ref.invalidate(authStateChangesProvider);
    }

    return result;
  }
}

@riverpod
class PasswordController extends _$PasswordController {
  @override
  FutureOr<void> build() {}

  /// Change user password
  Future<Result<void, AppErrorCode>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Validate new password
    if (newPassword.length < 8) {
      const errorCode = AppErrorCode.validationInvalidData;
      return const Result.failure(errorCode);
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(newPassword)) {
      const errorCode = AppErrorCode.validationInvalidData;
      return const Result.failure(errorCode);
    }

    if (currentPassword == newPassword) {
      const errorCode = AppErrorCode.validationInvalidData;
      return const Result.failure(errorCode);
    }

    final authRepository = ref.read(authRepositoryProvider);

    // Reauthenticate with current password
    final reauthResult =
        await authRepository.reauthenticateWithPassword(currentPassword);
    if (reauthResult.isFailure) {
      return reauthResult;
    }

    // Update to new password
    final updateResult = await authRepository.updatePassword(newPassword);
    return updateResult;
  }
}

@riverpod
class EmailVerificationController extends _$EmailVerificationController {
  @override
  FutureOr<void> build() {}

  /// Send email verification
  Future<Result<void, AppErrorCode>> sendVerificationEmail() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      const errorCode = AppErrorCode.authUserNotLoggedIn;
      return const Result.failure(errorCode);
    }

    if (user.emailVerified) {
      const errorCode = AppErrorCode.validationInvalidOperation;
      return const Result.failure(errorCode);
    }

    final result = await user.sendEmailVerification();
    return result;
  }

  /// Check if email is verified (refresh token to get latest status)
  Future<Result<void, AppErrorCode>> checkEmailVerification() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      const errorCode = AppErrorCode.authUserNotLoggedIn;
      return const Result.failure(errorCode);
    }

    final result = await user.forceRefreshIdToken();

    // If successful, invalidate auth state to refresh user data
    if (result.isSuccess) {
      ref.invalidate(authStateChangesProvider);
    }

    return result;
  }
}

@riverpod
class AccountDeletionController extends _$AccountDeletionController {
  @override
  FutureOr<void> build() {}

  /// Delete user account with password confirmation
  Future<Result<void, AppErrorCode>> deleteAccount(
      {required String password}) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      const errorCode = AppErrorCode.authUserNotLoggedIn;
      return const Result.failure(errorCode);
    }

    if (password.trim().isEmpty) {
      const errorCode = AppErrorCode.validationMissingFields;
      return const Result.failure(errorCode);
    }

    final authRepository = ref.read(authRepositoryProvider);

    // Reauthenticate before deletion
    final reauthResult =
        await authRepository.reauthenticateWithPassword(password);
    if (reauthResult.isFailure) {
      return reauthResult;
    }

    // Delete the account
    final deleteResult = await authRepository.deleteAccount();
    return deleteResult;
  }
}
