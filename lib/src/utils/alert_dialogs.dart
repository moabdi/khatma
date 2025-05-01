import 'package:flutter/material.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
  Color? confirmTextColor,
  Color? cancelTextColor = Colors.black,
}) async {
  return showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(
              cancelActionText,
              style: TextStyle(color: cancelTextColor),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: Text(
            defaultActionText,
            style: TextStyle(color: confirmTextColor),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK'.hardcoded,
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented'.hardcoded,
    );
