import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';

typedef UserID = String;

class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.emailVerified = false,
    this.isAnonymous = true,
  });

  final UserID uid;
  final String? email;
  final String? displayName;
  final bool emailVerified;
  final bool isAnonymous;

  Future<Result<void, AppErrorCode>> sendEmailVerification() async {
    return const Result.failure(AppErrorCode.generalInvalidOperation);
  }

  Future<Result<bool, AppErrorCode>> isAdmin() async {
    return const Result.success(false);
  }

  Future<Result<void, AppErrorCode>> forceRefreshIdToken() async {
    return const Result.failure(AppErrorCode.generalInvalidOperation);
  }

  Future<Result<String?, AppErrorCode>> getIdToken(
      {bool forceRefresh = false}) async {
    return const Result.failure(AppErrorCode.generalInvalidOperation);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.isAnonymous == isAnonymous;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      emailVerified.hashCode ^
      isAnonymous.hashCode;

  @override
  String toString() =>
      'AppUser(uid: $uid, email: $email, emailVerified: $emailVerified, isAnonymous: $isAnonymous)';
}
