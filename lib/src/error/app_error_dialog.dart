import 'package:flutter/material.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class AppErrorDialog extends StatelessWidget {
  final AppErrorCode errorCode;
  final String? customTitle;
  final String? customMessage;
  final String? buttonText;
  final VoidCallback? onPressed;

  const AppErrorDialog({
    Key? key,
    required this.errorCode,
    this.customTitle,
    this.customMessage,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = errorCode.getIconForCategory();
    final title = customTitle ?? errorCode.getTitle(context);
    final message = customMessage ?? errorCode.translate(context);
    final buttonText = this.buttonText ?? AppLocalizations.of(context).ok;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) => Transform.scale(
                scale: value,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: errorCode.severityColor.withOpacity(0.1),
                  child: Icon(icon, color: errorCode.severityColor, size: 30),
                ),
              ),
            ),
            gapH24,

            // Title
            Text(title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            gapH12,

            // Message
            Text(message,
                style: context.theme.listTileTheme.subtitleTextStyle,
                textAlign: TextAlign.center),
            gapH24,

            // Button
            SizedBox(
              height: 45,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      context.theme.colorScheme.error.withAlpha(25),
                  foregroundColor: context.theme.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onPressed ?? () => Navigator.of(context).pop(true),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> show(
    BuildContext context,
    AppErrorCode errorCode, {
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: context.theme.disabledColor,
      builder: (context) => AppErrorDialog(
        errorCode: errorCode,
        customTitle: title,
        customMessage: message,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}
