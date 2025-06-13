import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/exceptions/error_code.dart';

class ErrorHandler {
  static String getLocalizedError(BuildContext context, ErrorCode errorCode,
      [String? details]) {
    String message = errorCode.translate(context);

    if (details != null &&
        details.isNotEmpty &&
        _shouldShowDetails(errorCode)) {
      message += '\n\n $details';
    }

    return message;
  }

  static void showErrorSnackBar(
    BuildContext context,
    ErrorCode errorCode, [
    String? details,
    Duration? duration,
  ]) {
    final message = getLocalizedError(context, errorCode, details);
    final severity = errorCode.severity;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: _getSeverityColor(severity),
        duration: duration ?? _getSeverityDuration(severity),
        behavior: SnackBarBehavior.floating,
        action: severity == ErrorSeverity.critical
            ? SnackBarAction(
                label: '',
                textColor: Colors.white,
                onPressed: () => _showErrorDialog(context, errorCode, details),
              )
            : null,
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    ErrorCode errorCode, [
    String? details,
  ]) {
    _showErrorDialog(context, errorCode, details);
  }

  static void logError(
    ErrorCode errorCode,
    String? details, [
    StackTrace? stackTrace,
  ]) {
    final category = errorCode.category;
    final severity = errorCode.severity;

    debugPrint('ERROR [$severity] $category:$errorCode - $details');
    if (stackTrace != null && severity == ErrorSeverity.critical) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  static void handleError(
    BuildContext context,
    ErrorCode errorCode, [
    String? details,
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
  ]) {
    logError(errorCode, details);

    switch (errorCode.severity) {
      case ErrorSeverity.info:
        showErrorSnackBar(context, errorCode, details);

      case ErrorSeverity.warning:
        showErrorSnackBar(context, errorCode, details);

      case ErrorSeverity.error:
        showErrorSnackBar(context, errorCode, details);

      case ErrorSeverity.critical:
        _showCriticalErrorDialog(context, errorCode, details, onRetry);
    }

    onDismiss?.call();
  }

  static Color _getSeverityColor(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return Colors.blue;
      case ErrorSeverity.warning:
        return Colors.orange;
      case ErrorSeverity.error:
        return Colors.red;
      case ErrorSeverity.critical:
        return Colors.red.shade800;
    }
  }

  static Duration _getSeverityDuration(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return const Duration(seconds: 3);
      case ErrorSeverity.warning:
        return const Duration(seconds: 5);
      case ErrorSeverity.error:
        return const Duration(seconds: 7);
      case ErrorSeverity.critical:
        return const Duration(seconds: 10);
    }
  }

  static bool _shouldShowDetails(ErrorCode errorCode) {
    return errorCode.severity == ErrorSeverity.critical || kDebugMode;
  }

  static void _showErrorDialog(
    BuildContext context,
    ErrorCode errorCode,
    String? details,
  ) {
    final message = getLocalizedError(context, errorCode, details);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: _getSeverityColor(errorCode.severity),
            ),
            const SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (details != null && details.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Error Code: $errorCode',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _showCriticalErrorDialog(
    BuildContext context,
    ErrorCode errorCode,
    String? details,
    VoidCallback? onRetry,
  ) {
    final message = getLocalizedError(context, errorCode, details);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Text('Critical Error'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 16),
            Text(
              'This error requires attention. Please contact support if the problem persists.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static bool isAuthError(ErrorCode errorInfo) {
    return errorInfo.category == ErrorCategory.auth;
  }

  static bool isNetworkError(ErrorCode errorInfo) {
    return errorInfo.category == ErrorCategory.network;
  }
}

extension ResultErrorHandling<T> on Result<T, ErrorCode> {
  void handleUI(
    BuildContext context, {
    required VoidCallback onSuccess,
    VoidCallback? onError,
    VoidCallback? onRetry,
  }) {
    switch (this) {
      case Success():
        onSuccess();

      case Failure(error: final errorInfo):
        ErrorHandler.handleError(
          context,
          errorInfo,
          null,
          onRetry,
          onError,
        );
    }
  }

  void showErrorIfFailed(BuildContext context) {
    if (this case Failure(error: final errorInfo)) {
      ErrorHandler.showErrorSnackBar(context, errorInfo);
    }
  }

  bool get requiresAuth {
    return switch (this) {
      Failure(error: final errorInfo) => ErrorHandler.isAuthError(errorInfo),
      Success() => false,
    };
  }

  bool get isNetworkError {
    return switch (this) {
      Failure(error: final errorInfo) => ErrorHandler.isNetworkError(errorInfo),
      Success() => false,
    };
  }
}

class ErrorInfo {
  final ErrorCode code;
  final String? details;

  const ErrorInfo(this.code, [this.details]);

  @override
  String toString() => details != null ? '$code: $details' : code.name;
}

extension ResultErrorInfoHandling<T> on Result<T, ErrorInfo> {
  void handleUI(
    BuildContext context, {
    required VoidCallback onSuccess,
    VoidCallback? onError,
    VoidCallback? onRetry,
  }) {
    switch (this) {
      case Success():
        onSuccess();

      case Failure(error: final errorInfo):
        ErrorHandler.handleError(
          context,
          errorInfo.code,
          errorInfo.details,
          onRetry,
          onError,
        );
    }
  }

  void showErrorIfFailed(BuildContext context) {
    if (this case Failure(error: final errorInfo)) {
      ErrorHandler.showErrorSnackBar(
          context, errorInfo.code, errorInfo.details);
    }
  }

  bool get requiresAuth {
    return switch (this) {
      Failure(error: final errorInfo) =>
        ErrorHandler.isAuthError(errorInfo.code),
      Success() => false,
    };
  }

  bool get isNetworkError {
    return switch (this) {
      Failure(error: final errorInfo) =>
        ErrorHandler.isNetworkError(errorInfo.code),
      Success() => false,
    };
  }
}
