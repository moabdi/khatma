import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/themes/theme.dart';
import '../logic/account_controller.dart';

class TokenRefreshHandler {
  static Future<void> refresh(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(accountControllerProvider.notifier);
    final result = await controller.refreshToken();

    if (!context.mounted) return;

    result.handleUI(
      context,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.dataRefreshed),
            backgroundColor: context.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}
