import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';

class FirebaseAppUser extends AppUser {
  FirebaseAppUser(this._user)
      : super(
            uid: _user.uid,
            email: _user.email,
            displayName: _user.displayName,
            emailVerified: _user.emailVerified,
            isAnonymous: _user.isAnonymous,
            authMethod: _mapProvider(_user));

  final User _user;

  @override
  Future<Result<void, AppErrorCode>> sendEmailVerification() async {
    try {
      await _user.sendEmailVerification();
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (_) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  @override
  Future<Result<bool, AppErrorCode>> isAdmin() async {
    try {
      final idTokenResult = await _user.getIdTokenResult();
      final claims = idTokenResult.claims;

      final isAdminUser = claims?['admin'] == true ||
          claims?['role'] == 'admin' ||
          claims?['isAdmin'] == true;

      return Result.success(isAdminUser);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (_) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  @override
  Future<Result<void, AppErrorCode>> forceRefreshIdToken() async {
    try {
      await _user.reload();
      await _user.getIdToken(true);
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (_) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  @override
  Future<Result<String?, AppErrorCode>> getIdToken(
      {bool forceRefresh = false}) async {
    try {
      final token = await _user.getIdToken(forceRefresh);
      return Result.success(token);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (_) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  static AuthMethod _mapProvider(User user) {
    if (user.isAnonymous || user.providerData.isEmpty)
      return AuthMethod.anonymous;

    final providerId = user.providerData.first.providerId;
    switch (providerId) {
      case 'password':
        return AuthMethod.emailPassword;
      case 'google.com':
        return AuthMethod.google;
      default:
        return AuthMethod.anonymous;
    }
  }

  AppErrorCode _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AppErrorCode.authUserNotLoggedIn;
      case 'too-many-requests':
        return AppErrorCode.netRateLimit;
      case 'network-request-failed':
        return AppErrorCode.netConnectionFailed;
      case 'requires-recent-login':
        return AppErrorCode.authSessionExpired;
      case 'user-disabled':
        return AppErrorCode.authInvalidAccount;
      case 'operation-not-allowed':
        return AppErrorCode.authPermissionDenied;
      case 'invalid-email':
        return AppErrorCode.validationInvalidFormat;
      default:
        return AppErrorCode.generalUnknown;
    }
  }
}
