import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class AppDialog {
  static Future<bool?> _show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required IconData icon,
    required Color color,
    String? cancelText,
  }) {
    final l10n = AppLocalizations.of(context);

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: context.theme.disabledColor,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 20, top: 16, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              gapH12,

              // Message
              Text(
                message,
                style: context.theme.listTileTheme.subtitleTextStyle,
                textAlign: TextAlign.center,
              ),
              gapH24,

              // Buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelText ?? l10n.cancel),
                    ),
                    gapW20,
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(confirmText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) {
    final l10n = AppLocalizations.of(context);
    return _show(
      context,
      title: title,
      message: message,
      confirmText: confirmText ?? l10n.ok,
      icon: Icons.help_outline,
      color: context.theme.colorScheme.primary,
      cancelText: cancelText,
    );
  }

  static Future<bool?> showDelete(
    BuildContext context, {
    String? itemName,
  }) {
    final message = itemName != null
        ? context.loc.confirmDeleteItem(itemName)
        : context.loc.confirmDelete;

    return _show(
      context,
      title: context.loc.confirmDeleteTitle,
      message: message,
      confirmText: context.loc.delete,
      icon: Icons.delete_outline,
      color: Colors.red,
    );
  }

  static Future<bool?> showLogout(BuildContext context) {
    return _show(
      context,
      title: context.loc.confirmLogoutTitle,
      message: context.loc.confirmLogout,
      confirmText: context.loc.logout,
      icon: Icons.logout,
      color: Colors.orange,
    );
  }

  static Future<bool?> showExit(BuildContext context) {
    return _show(
      context,
      title: context.loc.confirmExitTitle,
      message: context.loc.confirmExitApp,
      confirmText: context.loc.exit,
      icon: Icons.exit_to_app,
      color: Colors.red,
    );
  }
}
