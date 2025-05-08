import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'auth_service.g.dart';

const _keyEmail = 'auth_email';
const _keyPassword = 'auth_password';
const _keyMode = 'auth_mode';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<void> build() {}

  Future<void> ensureAuthenticated() async {
    final authRepository = ref.read(authRepositoryProvider);
    if (authRepository.currentUser != null) return;

    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_keyMode);

    switch (mode) {
      case 'email':
        final email = prefs.getString(_keyEmail);
        final password = prefs.getString(_keyPassword);
        if (email != null && password != null) {
          await signInWithEmailAndPassword(email, password);
        }
        break;
      case 'anonymous':
        await signInAnonymously();
        break;
      default:
        break;
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signInWithEmailAndPassword(email, password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
    await prefs.setString(_keyMode, 'email');
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.createUserWithEmailAndPassword(email, password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
    await prefs.setString(_keyMode, 'email');
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signInAnonymously();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
    await prefs.setString(_keyMode, 'anonymous');
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
    await prefs.remove(_keyMode);
  }

  Future<void> _signInWithDeviceId() async {
    final authRepository = ref.read(authRepositoryProvider);
    try {
      final email = await _generatePseudoEmail();
      const password = 'WQz!49gfsdkjF*Z9x1D4!';

      try {
        await authRepository.createUserWithEmailAndPassword(email, password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          await authRepository.signInWithEmailAndPassword(email, password);
        } else {
          throw e;
        }
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyPassword, password);
      await prefs.setString(_keyMode, 'deviceId');
    } catch (err) {
      throw Exception('Failed to sign in with device ID: $err');
    }
  }

  static Future<String> _generatePseudoEmail() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        return '${android.id}@khatma.android';
      } else if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        return '${ios.identifierForVendor}@khatma.ios';
      } else {
        return '${Uuid().v4()}@khatma.platform';
      }
    } catch (e) {
      return '${Uuid().v4()}@khatma.other';
    }
  }
}
