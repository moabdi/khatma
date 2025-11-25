import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitActionsSheet extends StatelessWidget {
  const UnitActionsSheet({
    super.key,
    required this.unit,
    required this.isUserAdminOrCreator,
    required this.isOwnedByCurrentUser,
    this.onSendReminder,
    this.onFreeUnit,
  });

  final Unit unit;
  final bool isUserAdminOrCreator;
  final bool isOwnedByCurrentUser;
  final VoidCallback? onSendReminder;
  final VoidCallback? onFreeUnit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Send reminder option (admin only)
          if (isUserAdminOrCreator && !isOwnedByCurrentUser)
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(context.loc.sendReminder),
              subtitle: Text(
                '${context.loc.reservedBy}: ${unit.reservedByName ?? "Unknown"}',
                style: context.textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pop(context);
                if (onSendReminder != null) {
                  onSendReminder!();
                }
              },
            ),
          // Free/Unreserve unit option
          ListTile(
            leading: Icon(
              Icons.lock_open,
              color: isOwnedByCurrentUser
                  ? context.colorScheme.primary
                  : Colors.orange.shade700,
            ),
            title: Text(
              isOwnedByCurrentUser
                  ? context.loc.unreserveUnit
                  : context.loc.freeUnit,
              style: TextStyle(
                color: isOwnedByCurrentUser
                    ? context.colorScheme.primary
                    : Colors.orange.shade700,
              ),
            ),
            subtitle: Text(
              isOwnedByCurrentUser
                  ? context.loc.cancelYourReservation
                  : context.loc.confirmFreeUnit,
              style: context.textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.pop(context);
              _showConfirmFreeDialog(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _showConfirmFreeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.loc.freeUnit),
          content: Text(context.loc.confirmFreeUnit),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.loc.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (onFreeUnit != null) {
                  onFreeUnit!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
              ),
              child: Text(context.loc.freeUnit),
            ),
          ],
        );
      },
    );
  }
}
