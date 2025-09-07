import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logging_service.g.dart';

class LoggingService {
  LoggingService({
    required FirebaseCrashlytics crashlytics,
    required FirebaseAnalytics analytics,
  })  : _crashlytics = crashlytics,
        _analytics = analytics;

  final FirebaseCrashlytics _crashlytics;
  final FirebaseAnalytics _analytics;

  /// Log authentication errors with detailed context
  Future<void> logAuthError({
    required String method,
    required String errorCode,
    required String errorMessage,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
    String? platform,
    int? attemptNumber,
  }) async {
    try {
      // Set user properties for better debugging
      await _crashlytics.setUserIdentifier(
          'auth_error_${DateTime.now().millisecondsSinceEpoch}');
      await _crashlytics.setCustomKey('auth_method', method);
      await _crashlytics.setCustomKey('error_code', errorCode);
      await _crashlytics.setCustomKey(
          'platform', platform ?? (kIsWeb ? 'web' : 'mobile'));

      if (attemptNumber != null) {
        await _crashlytics.setCustomKey('attempt_number', attemptNumber);
      }

      // Add additional context data
      if (additionalData != null) {
        for (final entry in additionalData.entries) {
          await _crashlytics.setCustomKey(
              entry.key, entry.value?.toString() ?? 'null');
        }
      }

      // Record the error to Crashlytics
      await _crashlytics.recordError(
        'Authentication Error: $method',
        stackTrace,
        fatal: false,
        printDetails: kDebugMode,
        information: [
          DiagnosticsProperty('method', method),
          DiagnosticsProperty('errorCode', errorCode),
          DiagnosticsProperty('errorMessage', errorMessage),
          DiagnosticsProperty(
              'platform', platform ?? (kIsWeb ? 'web' : 'mobile')),
          if (attemptNumber != null)
            DiagnosticsProperty('attemptNumber', attemptNumber),
          if (additionalData != null)
            ...additionalData.entries.map(
              (entry) => DiagnosticsProperty(entry.key, entry.value),
            ),
        ],
      );

      // Log to Analytics for tracking trends
      await _analytics.logEvent(
        name: 'auth_error',
        parameters: {
          'method': method,
          'error_code': errorCode,
          'platform': platform ?? (kIsWeb ? 'web' : 'mobile'),
          if (attemptNumber != null) 'attempt_number': attemptNumber,
          ...?additionalData,
        },
      );

      if (kDebugMode) {
        debugPrint('📊 Logged auth error: $method - $errorCode');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Failed to log auth error: $e');
      }
    }
  }

  /// Log successful authentication events
  Future<void> logAuthSuccess({
    required String method,
    required String userId,
    String? platform,
    int? attemptNumber,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      await _crashlytics.setUserIdentifier(userId);

      // Log successful auth to Analytics
      await _analytics.logEvent(
        name: 'auth_success',
        parameters: {
          'method': method,
          'platform': platform ?? (kIsWeb ? 'web' : 'mobile'),
          if (attemptNumber != null) 'attempt_number': attemptNumber,
          ...?additionalData,
        },
      );

      // Log to Crashlytics as non-fatal for tracking
      await _crashlytics.log('Auth success: $method for user $userId');

      if (kDebugMode) {
        debugPrint('✅ Logged auth success: $method');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Failed to log auth success: $e');
      }
    }
  }

  /// Log authentication step progress
  Future<void> logAuthStep({
    required String method,
    required String step,
    String? platform,
    int? attemptNumber,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _crashlytics
          .log('Auth step: $method - $step (attempt: $attemptNumber)');

      if (kDebugMode) {
        debugPrint('📝 Auth step: $method - $step');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Failed to log auth step: $e');
      }
    }
  }

  /// Log general errors with context
  Future<void> logError({
    required String category,
    required Object error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    bool fatal = false,
  }) async {
    try {
      // Set context as custom keys
      if (context != null) {
        for (final entry in context.entries) {
          await _crashlytics.setCustomKey(
              entry.key, entry.value?.toString() ?? 'null');
        }
      }

      await _crashlytics.recordError(
        error,
        stackTrace,
        fatal: fatal,
        printDetails: kDebugMode,
        information: [
          DiagnosticsProperty('category', category),
          if (context != null)
            ...context.entries.map(
              (entry) => DiagnosticsProperty(entry.key, entry.value),
            ),
        ],
      );

      if (kDebugMode) {
        debugPrint('🚨 Logged error [$category]: $error');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Failed to log error: $e');
      }
    }
  }
}

@Riverpod(keepAlive: true)
LoggingService loggingService(Ref ref) {
  return LoggingService(
    crashlytics: FirebaseCrashlytics.instance,
    analytics: FirebaseAnalytics.instance,
  );
}
