import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';

class PreferencesService {
  PreferencesService._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device),
  );

  static void _logError(String message, {Object? error}) {
    developer.log('[PreferencesService] ERROR: $message', error: error);
  }

  // Secure Storage
  static Future<Result<void, AppErrorCode>> setSecureString(
      String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set secure string: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<String?, AppErrorCode>> getSecureString(
      String key) async {
    try {
      final result = await _secureStorage.read(key: key);
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get secure string: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> deleteSecureString(
      String key) async {
    try {
      await _secureStorage.delete(key: key);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to delete secure string: $key', error: e);
      return const Result.failure(AppErrorCode.storageDeleteFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> clearSecureStorage() async {
    try {
      await _secureStorage.deleteAll();
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to clear secure storage', error: e);
      return const Result.failure(AppErrorCode.storageDeleteFailed);
    }
  }

  // Regular Preferences
  static Future<Result<void, AppErrorCode>> setString(
      String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set string: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<String?, AppErrorCode>> getString(String key,
      [String? defaultValue]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getString(key) ?? defaultValue;
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get string: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> setBool(
      String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set bool: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<bool, AppErrorCode>> getBool(String key,
      [bool defaultValue = false]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(key) ?? defaultValue;
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get bool: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> setInt(
      String key, int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set int: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<int, AppErrorCode>> getInt(String key,
      [int defaultValue = 0]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getInt(key) ?? defaultValue;
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get int: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> setDouble(
      String key, double value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(key, value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set double: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<double, AppErrorCode>> getDouble(String key,
      [double defaultValue = 0.0]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getDouble(key) ?? defaultValue;
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get double: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> setStringList(
      String key, List<String> value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(key, value);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to set string list: $key', error: e);
      return const Result.failure(AppErrorCode.storageSaveFailed);
    }
  }

  static Future<Result<List<String>, AppErrorCode>> getStringList(String key,
      [List<String>? defaultValue]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getStringList(key) ?? defaultValue ?? [];
      return Result.success(result);
    } catch (e) {
      _logError('Failed to get string list: $key', error: e);
      return const Result.failure(AppErrorCode.storageLoadFailed);
    }
  }

  static Future<Result<void, AppErrorCode>> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to remove: $key', error: e);
      return const Result.failure(AppErrorCode.storageDeleteFailed);
    }
  }

  static Future<Result<bool, AppErrorCode>> hasKey(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return Result.success(prefs.containsKey(key));
    } catch (e) {
      return const Result.success(false);
    }
  }

  static Future<Result<void, AppErrorCode>> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return const Result.success(null);
    } catch (e) {
      _logError('Failed to clear all', error: e);
      return const Result.failure(AppErrorCode.storageDeleteFailed);
    }
  }
}
