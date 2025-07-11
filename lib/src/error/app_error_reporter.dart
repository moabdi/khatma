import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/error/app_error_code.dart';

abstract class AppErrorReporter {
  static AppErrorReporter? _instance;

  static void init(AppErrorReporter reporter) {
    _instance = reporter;
  }

  static void reportError(
    AppErrorCode errorCode, {
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? userId,
  }) {
    _instance?.report(errorCode, details, stackTrace, context, userId);
  }

  void report(
    AppErrorCode errorCode,
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? userId,
  );
}

class DebugErrorReporter extends AppErrorReporter {
  @override
  void report(
    AppErrorCode errorCode,
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? userId,
  ) {
    debugPrint('🐛 ERROR REPORT:');
    debugPrint('  Code: $errorCode');
    debugPrint('  Severity: ${errorCode.severity}');
    debugPrint('  Category: ${errorCode.category}');
    if (details != null) debugPrint('  Details: $details');
    if (userId != null) debugPrint('  User: $userId');
    if (context != null) debugPrint('  Context: $context');
    if (stackTrace != null && errorCode.isCritical) {
      debugPrint('  Stack: $stackTrace');
    }
  }
}

class ProductionErrorReporter extends AppErrorReporter {
  @override
  void report(
    AppErrorCode errorCode,
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? userId,
  ) {
    FirebaseCrashlytics.instance.recordError(
      errorCode.toString(),
      stackTrace,
      reason: details,
      information: [
        ...context?.entries.map((e) => '${e.key}: ${e.value}') ?? []
      ],
    );

    // Pour l'instant, log en debug
    DebugErrorReporter()
        .report(errorCode, details, stackTrace, context, userId);
  }
}

// Extension pour utilisation facile
extension ErrorCodeReporting on AppErrorCode {
  void report({
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
    String? userId,
  }) {
    AppErrorReporter.reportError(
      this,
      details: details,
      stackTrace: stackTrace,
      context: context,
      userId: userId,
    );
  }
}
