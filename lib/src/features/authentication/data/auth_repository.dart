import 'dart:async';

import 'package:khatma/src/features/authentication/data/firebase_app_user.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Future<void> signInAnonymously() async {
    print('[AuthRepository] Checking if user is already signed in');
    if (FirebaseAuth.instance.currentUser == null) {
      print('[AuthRepository] No user found, signing in anonymously...');
      await _auth.signInAnonymously();
      print('[AuthRepository] Signed in anonymously ${_auth.currentUser?.uid}');
    } else {
      print('[AuthRepository] Already signed in: ${_auth.currentUser?.uid}');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out).
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_convertUser);
  }

  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out) and also token refresh events.
  Stream<AppUser?> idTokenChanges() {
    return _auth.idTokenChanges().map(_convertUser);
  }

  AppUser? get currentUser => _convertUser(_auth.currentUser);

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) {
    print('[AuthRepository] Converting Firebase User to AppUser: $user');
    return user != null ? FirebaseAppUser(user) : null;
  }

}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseAuth.instance);
}

// * Using keepAlive since other providers need it to be an
// * [AlwaysAliveProviderListenable]
@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  print('[authStateChangesProvider] Watching auth state stream');
  return authRepository.authStateChanges().map((user) {
    print('[authStateChangesProvider] New auth state: $user');
    return user;
  });
}

@Riverpod(keepAlive: true)
Stream<AppUser?> idTokenChanges(IdTokenChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  print('[idTokenChangesProvider] Watching token stream');
  return authRepository.idTokenChanges().map((user) {
    print('[idTokenChangesProvider] New token change: $user');
    return user;
  });
}

@riverpod
FutureOr<bool> isCurrentUserAdmin(IsCurrentUserAdminRef ref) {
  final user = ref.watch(idTokenChangesProvider).value;
  if (user != null) {
    return user.isAdmin();
  } else {
    return false;
  }
}
