import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/core/result.dart';

import 'package:khatma/src/features/authentication/data/firebase_app_user.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth, this._googleSignIn);
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  /// Sign in with Google - Enhanced for Web
  Future<Result<void, AppErrorCode>> signInWithGoogle() async {
    try {
      if (kDebugMode) {
        print('🔍 Starting Google Sign-In for ${kIsWeb ? 'Web' : 'Mobile'}...');
      }

      if (kIsWeb) {
        // WEB-SPECIFIC IMPLEMENTATION
        return await _signInWithGoogleWeb();
      } else {
        // MOBILE IMPLEMENTATION (existing logic)
        return await _signInWithGoogleMobile();
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      }
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      if (kDebugMode) {
        print('❌ General Error: $e');
      }
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Web-specific Google Sign-In implementation
  Future<Result<void, AppErrorCode>> _signInWithGoogleWeb() async {
    try {
      if (kDebugMode) {
        print('🌐 Web Google Sign-In implementation');
      }

      // Method 1: Try Firebase Auth popup directly (recommended for web)
      try {
        if (kDebugMode) {
          print('🔄 Method 1: Firebase Auth popup...');
        }

        final GoogleAuthProvider googleProvider = GoogleAuthProvider();

        // Add additional scopes
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        googleProvider.addScope('openid');

        // Set custom parameters for better UX
        googleProvider.setCustomParameters({
          'login_hint': 'user@example.com',
          'prompt': 'select_account',
        });

        final UserCredential result =
            await _auth.signInWithPopup(googleProvider);

        if (result.user != null) {
          if (kDebugMode) {
            print('✅ Firebase Auth popup succeeded');
            print('  - UID: ${result.user!.uid}');
            print('  - Email: ${result.user!.email}');
            print('  - DisplayName: ${result.user!.displayName}');
          }
          return const Result.success(null);
        }
      } catch (e) {
        if (kDebugMode) {
          print('❌ Method 1 failed: $e');
        }
      }

      // Method 2: Fallback to GoogleSignIn package
      try {
        if (kDebugMode) {
          print('🔄 Method 2: GoogleSignIn package fallback...');
        }

        // Clean any previous state
        await _googleSignIn.signOut();

        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          if (kDebugMode) {
            print('❌ User cancelled Google Sign-In');
          }
          return const Result.failure(AppErrorCode.authActionCancelled);
        }

        if (kDebugMode) {
          print('✅ GoogleSignIn succeeded: ${googleUser.email}');
        }

        // Get authentication details
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        if (googleAuth.accessToken == null || googleAuth.idToken == null) {
          if (kDebugMode) {
            print('❌ Missing tokens from GoogleSignIn');
          }
          return const Result.failure(AppErrorCode.authInvalidAccount);
        }

        // Create Firebase credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken!,
          idToken: googleAuth.idToken!,
        );

        // Sign in to Firebase
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (kDebugMode) {
          print('✅ Firebase credential sign-in succeeded');
          print('  - UID: ${userCredential.user?.uid}');
          print('  - Email: ${userCredential.user?.email}');
        }

        return const Result.success(null);
      } catch (e) {
        if (kDebugMode) {
          print('❌ Method 2 failed: $e');
        }
      }

      // Method 3: Redirect-based authentication (for some web environments)
      try {
        if (kDebugMode) {
          print('🔄 Method 3: Redirect-based auth...');
        }

        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');

        await _auth.signInWithRedirect(googleProvider);

        // Note: This method will redirect the page, so we won't reach this return
        // The redirect result should be handled in your app initialization
        return const Result.success(null);
      } catch (e) {
        if (kDebugMode) {
          print('❌ Method 3 failed: $e');
        }
      }

      if (kDebugMode) {
        print('❌ All web sign-in methods failed');
      }
      return const Result.failure(AppErrorCode.authInvalidAccount);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Web Google Sign-In error: $e');
      }
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Mobile-specific Google Sign-In implementation (your existing logic)
  Future<Result<void, AppErrorCode>> _signInWithGoogleMobile() async {
    try {
      if (kDebugMode) {
        print('📱 Mobile Google Sign-In implementation');
      }

      // Clean previous state
      try {
        await _googleSignIn.signOut();
        if (kDebugMode) {
          print('🧹 Previous state cleaned');
        }
      } catch (e) {
        if (kDebugMode) {
          print('⚠️ Cleanup ignored: $e');
        }
      }

      // Step 1: Google Sign-In
      if (kDebugMode) {
        print('🚀 Starting Google Sign-In...');
      }

      GoogleSignInAccount? googleUser;

      try {
        googleUser = await _googleSignIn.signIn();
      } catch (e) {
        if (kDebugMode) {
          print('❌ Google Sign-In error: $e');
        }
        return const Result.failure(AppErrorCode.netConnectionFailed);
      }

      if (googleUser == null) {
        return const Result.failure(AppErrorCode.authActionCancelled);
      }

      if (kDebugMode) {
        print('✅ GoogleUser obtained: ${googleUser.email}');
      }

      // Step 2: Get authentication tokens with multiple methods
      if (kDebugMode) {
        print('🔐 Getting authentication tokens...');
      }

      GoogleSignInAuthentication? googleAuth;

      // Try multiple methods to get tokens (your existing retry logic)
      for (int attempt = 1; attempt <= 5; attempt++) {
        try {
          if (kDebugMode) {
            print('🔄 Token attempt $attempt...');
          }

          switch (attempt) {
            case 1:
              googleAuth = await googleUser?.authentication;
              break;
            case 2:
              await Future.delayed(const Duration(seconds: 2));
              googleAuth = await googleUser?.authentication;
              break;
            case 3:
              await _googleSignIn.signOut();
              await _googleSignIn.disconnect();
              await Future.delayed(const Duration(milliseconds: 1000));
              final newGoogleUser = await _googleSignIn.signIn();
              if (newGoogleUser == null) {
                return const Result.failure(AppErrorCode.authActionCancelled);
              }
              googleAuth = await newGoogleUser.authentication;
              googleUser = newGoogleUser;
              break;
            case 4:
              googleAuth = await googleUser?.authentication.timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw Exception('Token timeout'),
              );
              break;
            case 5:
              final silentUser = await _googleSignIn.signInSilently();
              if (silentUser != null) {
                googleAuth = await silentUser.authentication;
                googleUser = silentUser;
              }
              break;
          }

          if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
            if (kDebugMode) {
              print('✅ Tokens obtained on attempt $attempt');
            }
            break;
          }
        } catch (e) {
          if (kDebugMode) {
            print('❌ Attempt $attempt failed: $e');
          }
          if (attempt == 5) rethrow;
        }
      }

      if (googleAuth == null ||
          googleAuth.accessToken == null ||
          googleAuth.idToken == null) {
        if (kDebugMode) {
          print('❌ Failed to get valid tokens');
        }
        return const Result.failure(AppErrorCode.authInvalidAccount);
      }

      if (kDebugMode) {
        print('✅ Valid tokens retrieved');
      }

      // Step 3: Firebase Sign-In
      if (kDebugMode) {
        print('🔥 Signing in to Firebase...');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!,
        idToken: googleAuth.idToken!,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (kDebugMode) {
        print('🎉 FIREBASE SIGN-IN SUCCESSFUL!');
        print('  - UID: ${userCredential.user?.uid}');
        print('  - Email: ${userCredential.user?.email}');
        print('  - DisplayName: ${userCredential.user?.displayName}');
      }

      return const Result.success(null);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Mobile Google Sign-In error: $e');
      }
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Handle redirect result for web (call this in your app initialization)
  Future<Result<void, AppErrorCode>> handleRedirectResult() async {
    if (!kIsWeb) return const Result.success(null);

    try {
      final UserCredential? result = await _auth.getRedirectResult();

      if (result?.user != null) {
        if (kDebugMode) {
          print('✅ Redirect result processed successfully');
          print('  - UID: ${result!.user!.uid}');
          print('  - Email: ${result.user!.email}');
        }
        return const Result.success(null);
      }

      return const Result.success(null);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Redirect result error: $e');
      }
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Sign in anonymously
  Future<Result<void, AppErrorCode>> signInAnonymously() async {
    try {
      if (kDebugMode) {
        print('👤 Starting anonymous sign-in... ${_auth.currentUser}');
      }
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
        if (kDebugMode) {
          print('🎭 Anonymous sign-in successful');
        }
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Sign in with email and password
  Future<Result<void, AppErrorCode>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('📧 Email/password sign-in successful: $email');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Create user with email and password
  Future<Result<void, AppErrorCode>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('👤 Account created successfully: $email');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Send password reset email
  Future<Result<void, AppErrorCode>> sendPasswordResetEmail(
      String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (kDebugMode) {
        print('📧 Password reset email sent to: $email');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Confirm password reset with code and new password
  Future<Result<void, AppErrorCode>> confirmPasswordReset(
      String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      if (kDebugMode) {
        print('🔑 Password reset successful');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Update user password
  Future<Result<void, AppErrorCode>> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    try {
      await user.updatePassword(newPassword);
      if (kDebugMode) {
        print('🔑 Password updated');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Update user profile
  Future<Result<void, AppErrorCode>> updateProfile(
      {String? displayName}) async {
    final user = _auth.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    try {
      await user.updateDisplayName(displayName);
      await user.reload();
      if (kDebugMode) {
        print('👤 Profile updated: $displayName');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Reauthenticate user with password
  Future<Result<void, AppErrorCode>> reauthenticateWithPassword(
      String password) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      if (kDebugMode) {
        print('🔐 Reauthentication successful');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Delete user account
  Future<Result<void, AppErrorCode>> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      return const Result.failure(AppErrorCode.authUserNotLoggedIn);
    }

    try {
      await user.delete();
      if (kDebugMode) {
        print('🗑️ Account deleted');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseAuthException(e));
    } catch (e) {
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Sign out
  Future<Result<void, AppErrorCode>> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      if (kDebugMode) {
        print('🚪 Sign out successful');
      }
      return const Result.success(null);
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Sign out error: $e');
      }
      return const Result.failure(AppErrorCode.generalUnknown);
    }
  }

  /// Auth state changes stream
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_convertUser);
  }

  /// ID token changes stream
  Stream<AppUser?> idTokenChanges() {
    return _auth.idTokenChanges().map(_convertUser);
  }

  /// Current user
  AppUser? get currentUser => _convertUser(_auth.currentUser);

  /// Convert Firebase User to AppUser
  AppUser? _convertUser(User? user) =>
      user != null ? FirebaseAppUser(user) : null;

  /// Map Firebase Auth exceptions to ErrorCode
  AppErrorCode _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
      case 'invalid-credential':
      case 'invalid-email':
      case 'user-disabled':
      case 'user-not-found':
      case 'wrong-password':
        return AppErrorCode.authInvalidCredential;
      case 'operation-not-allowed':
        return AppErrorCode.authPermissionDenied;
      case 'email-already-in-use':
        return AppErrorCode.authEmailAlreadyInUse;
      case 'weak-password':
        return AppErrorCode.authWeakPassword;
      case 'requires-recent-login':
        return AppErrorCode.authRequiresRecentLogin;
      case 'too-many-requests':
        return AppErrorCode.authTooManyRequests;
      case 'network-request-failed':
        return AppErrorCode.authNetworkRequestFailed;
      case 'popup-blocked':
        return AppErrorCode.authPopupBlocked;
      case 'popup-closed-by-user':
        return AppErrorCode.authPopClosedByUser;
      case 'unauthorized-domain':
        return AppErrorCode.authPermissionDenied;
      default:
        return AppErrorCode.generalUnknown;
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  GoogleSignIn googleSignIn;

  if (kIsWeb) {
    // Enhanced web configuration
    googleSignIn = GoogleSignIn(
      clientId:
          '1071136508165-i2ik3lcl1mavfnsju2lrbgeelqcpq207.apps.googleusercontent.com', // Replace with your actual web client ID
      scopes: [
        'email',
        'profile',
        'openid',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );

    if (kDebugMode) {
      print('🌐 GoogleSignIn Web configured with enhanced settings');
    }
  } else {
    googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'openid',
      ],
    );

    if (kDebugMode) {
      print('📱 GoogleSignIn Mobile configured');
    }
  }

  return AuthRepository(
    FirebaseAuth.instance,
    googleSignIn,
  );
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}

@Riverpod(keepAlive: true)
Stream<AppUser?> idTokenChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.idTokenChanges();
}

@riverpod
Future<bool> isCurrentUserAdmin(Ref ref) async {
  final user = ref.watch(idTokenChangesProvider).value;
  if (user != null) {
    final result = await user.isAdmin();
    return result.isSuccess ? true : false;
  } else {
    return false;
  }
}
