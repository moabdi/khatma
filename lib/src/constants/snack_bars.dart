import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

SnackBar buildSnackBar(BuildContext context, Widget message,
    {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return SnackBar(
    duration: const Duration(seconds: 2),
    content: message,
    backgroundColor: backgroundColor ?? null,
  );
}

SnackBar buildSnackBarLoading(BuildContext context, Widget message,
    {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return SnackBar(
    backgroundColor: backgroundColor ?? null,
    duration: const Duration(seconds: 2),
    content: Row(
      children: [
        LinearProgressIndicator(),
        gapW12,
        message,
      ],
    ),
  );
}
