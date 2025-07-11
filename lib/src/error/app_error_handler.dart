import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_dialog.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class AppErrorHandler {
  static String getLocalizedError(BuildContext context, AppErrorCode errorCode,
      [String? details]) {
    String message = errorCode.translate(context);

    if (details != null &&
        details.isNotEmpty &&
        (errorCode.severity == ErrorSeverity.critical || kDebugMode)) {
      message += '\n\n $details';
    }

    return message;
  }

  static void showErrorSnackBar(
    BuildContext context,
    AppErrorCode errorCode, [
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
        backgroundColor: errorCode.severityColor,
        duration: duration ?? errorCode.displayDuration,
        behavior: SnackBarBehavior.floating,
        action: severity == ErrorSeverity.critical
            ? SnackBarAction(
                label: '',
                textColor: Colors.white,
                onPressed: () => showErrorDialog(context, errorCode, details),
              )
            : null,
      ),
    );
  }

  static void logError(
    AppErrorCode errorCode,
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
    AppErrorCode errorCode, [
    String? details,
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
  ]) {
    logError(errorCode, details);
    AppErrorDialog.show(context, errorCode);
    onDismiss?.call();
  }

  static void showErrorDialog(
    BuildContext context,
    AppErrorCode errorCode,
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
              color: errorCode.severityColor,
            ),
            const SizedBox(width: 8),
            Text(context.loc.error),
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
                '${context.loc.errorCode}: $errorCode',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.ok),
          ),
        ],
      ),
    );
  }
}

extension ResultErrorHandling<T> on Result<T, AppErrorCode> {
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
        AppErrorHandler.handleError(
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
      AppErrorDialog.show(context, errorInfo);
    }
  }
}
