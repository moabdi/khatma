import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/generated/app_localizations.dart';

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
    final theme = Theme.of(context);

    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      fullscreenDialog: true,
      barrierColor: Colors.black54,
      barrierLabel: "Labe",
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Buttons - Fixed approach without Expanded issues
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(cancelText ?? l10n.cancel),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 15,
                              )),
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(confirmText),
                        ),
                      ),
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

  // Alternative approach - No flex widgets at all
  static Future<bool?> showAlternative(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required IconData icon,
    required Color color,
    String? cancelText,
  }) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Buttons - No Expanded, just fixed width approach
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelText ?? l10n.cancel),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(confirmText),
                    ),
                  ),
                ],
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
    final theme = Theme.of(context);

    return _show(
      context,
      title: title,
      message: message,
      confirmText: confirmText ?? l10n.ok,
      icon: Icons.help_outline,
      color: theme.colorScheme.primary,
      cancelText: cancelText,
    );
  }

  static Future<bool?> showDelete(
    BuildContext context, {
    String? itemName,
  }) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final message = itemName != null
        ? l10n.confirmDeleteItem(itemName)
        : l10n.confirmDelete;

    return _show(
      context,
      title: l10n.confirmDeleteTitle,
      message: message,
      confirmText: l10n.delete,
      icon: Icons.delete_outline,
      color: theme.colorScheme.error,
    );
  }

  static Future<bool?> showLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _show(
      context,
      title: l10n.confirmLogoutTitle,
      message: l10n.confirmLogout,
      confirmText: l10n.logout,
      icon: Icons.logout,
      color: Colors.orange,
    );
  }

  static Future<bool?> showExit(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return _show(
      context,
      title: l10n.confirmExitTitle,
      message: l10n.confirmExitApp,
      confirmText: l10n.exit,
      icon: Icons.exit_to_app,
      color: theme.colorScheme.error,
    );
  }
}
