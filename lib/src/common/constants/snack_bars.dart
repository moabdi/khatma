import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:khatma/src/constants/app_sizes.dart';

SnackBar buildSnackBar(BuildContext context, Widget message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return SnackBar(
    duration: const Duration(seconds: 2),
    content: Row(
      children: [
        lottieCheckAsset,
        gapW12,
        message,
      ],
    ),
  );
}

SnackBar buildSnackBarLoading(BuildContext context, Widget message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return SnackBar(
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
