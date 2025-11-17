import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:intl/intl.dart';

class UnitTile extends StatelessWidget {
  final Unit unit;
  final VoidCallback onTap;
  final int reservationWarningDays;
  final bool isUserAdminOrCreator;
  final VoidCallback? onSendReminder;
  final VoidCallback? onFreeUnit;

  const UnitTile({
    super.key,
    required this.unit,
    required this.onTap,
    this.reservationWarningDays = 7,
    this.isUserAdminOrCreator = false,
    this.onSendReminder,
    this.onFreeUnit,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor;
    Widget? trailingIcon;
    bool isClickable = true;
    Color avatarColor;
    Color numberColor;
    switch (unit.status) {
      case UnitStatus.free:
        tileColor = Theme.of(context).colorScheme.surfaceContainerLow;
        avatarColor = Theme.of(context).colorScheme.surface;
        numberColor = Theme.of(context).colorScheme.onSurfaceVariant;
        trailingIcon = null;
        isClickable = true;
        break;

      case UnitStatus.reserved:
        tileColor = Theme.of(context).colorScheme.surfaceContainer;
        avatarColor =
            Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3);
        numberColor = Theme.of(context).colorScheme.onSurfaceVariant;
        isClickable = false;
        trailingIcon = Icon(
          Icons.lock,
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          size: 20,
        );
        break;

      case UnitStatus.selected:
        tileColor = context.colorScheme.primaryContainer.withValues(alpha: 0.3);
        avatarColor = context.colorScheme.primary.withValues(alpha: 0.5);
        numberColor = context.colorScheme.onPrimaryContainer;
        isClickable = true;
        trailingIcon = Icon(
          Icons.check_circle,
          color: context.colorScheme.primary,
          size: 20,
        );
        break;

      // 4. COMPLETED (SUCCESS) - Solid Primary Green
      case UnitStatus.completed:
        tileColor = context.colorScheme.surfaceContainerHigh;
        avatarColor =
            context.colorScheme.primary.withAlpha(25); // Muted green avatar
        numberColor = context.colorScheme.primary; // Darker green number
        isClickable = false;
        trailingIcon = Icon(
          Icons.done_all_sharp,
          color: context.colorScheme.onPrimary, // White/Light color for icon
          size: 20,
        );
        break;
    }

    // Calculate start ayah for the hizb (example calculation)
    final startAyah = _getStartAyahForHizb(unit.number);

    // Check if unit is overdue (warning needed)
    final daysSinceReserved = unit.reservedDate != null
        ? DateTime.now().difference(unit.reservedDate!).inDays
        : 0;
    final isOverdue = (unit.status == UnitStatus.reserved ||
            unit.status == UnitStatus.reserved) &&
        daysSinceReserved >= reservationWarningDays;

    // Format dates
    String? formattedDate;
    String? dateLabel;
    if (unit.status == UnitStatus.reserved) {
      if (unit.reservedDate != null) {
        formattedDate = DateFormat('dd/MM/yyyy').format(unit.reservedDate!);
        dateLabel = context.loc.reservedOn;
      }
    } else if (unit.status == UnitStatus.completed) {
      if (unit.completedDate != null) {
        formattedDate = DateFormat('dd/MM/yyyy').format(unit.completedDate!);
        dateLabel = context.loc.completedOn;
      }
    }

    // Build subtitle text
    String subtitleText = 'Commence à: $startAyah';
    if (formattedDate != null && dateLabel != null) {
      subtitleText = '$dateLabel: $formattedDate';
      // Add overdue warning to subtitle
      if (isOverdue) {
        subtitleText += ' • ${context.loc.daysOverdue(daysSinceReserved)}';
      }
    }

    // Build subtitle widget with optional warning icon
    Widget subtitleWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOverdue) ...[
          Text(
            '⚠️',
            style: TextStyle(
              fontSize: 12,
              color: Colors.orange.shade700,
            ),
          ),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            subtitleText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isOverdue
                  ? Colors.orange.shade700
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isOverdue ? FontWeight.w600 : null,
            ),
          ),
        ),
      ],
    );

    // Build trailing widget with icon and member name
    Widget? trailing = trailingIcon;
    if (unit.reservedByName != null && (unit.status == UnitStatus.reserved ||
        unit.status == UnitStatus.completed)) {
      trailing = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (trailingIcon != null) trailingIcon,
          if (trailingIcon != null) const SizedBox(height: 2),
          Text(
            unit.reservedBy!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontSize: 10,
            ),
          ),
        ],
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: tileColor,
      elevation: unit.status == UnitStatus.reserved ? 2 : 1,
      child: ListTile(
        onTap: isClickable ? onTap : null,
        onLongPress: isOverdue && isUserAdminOrCreator
            ? () => _showAdminActions(context)
            : null,
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          radius: 20,
          child: Text(
            '${unit.number}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
          ),
        ),
        title: Text(
          'Hizb ${unit.number}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: subtitleWidget,
        trailing: trailing,
        dense: true,
      ),
    );
  }

  // Show admin actions for overdue units
  void _showAdminActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: Text(context.loc.sendReminder),
                subtitle: Text(
                  '${context.loc.reservedBy}: ${unit.reservedBy ?? "Unknown"}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                  if (onSendReminder != null) {
                    onSendReminder!();
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.lock_open, color: Colors.orange.shade700),
                title: Text(
                  context.loc.freeUnit,
                  style: TextStyle(color: Colors.orange.shade700),
                ),
                subtitle: Text(
                  context.loc.confirmFreeUnit,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmFreeUnit(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Confirm before freeing the unit
  void _confirmFreeUnit(BuildContext context) {
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

  // Helper method to calculate start ayah for each hizb
  String _getStartAyahForHizb(int hizbNumber) {
    // This is a simplified example - you would need actual Quran data
    // to get the correct ayah for each hizb
    final hizbData = {
      1: 'Al-Fatiha 1',
      2: 'Al-Baqarah 26',
      3: 'Al-Baqarah 60',
      4: 'Al-Baqarah 92',
      5: 'Al-Baqarah 124',
      6: 'Al-Baqarah 160',
      7: 'Al-Baqarah 177',
      8: 'Al-Baqarah 198',
      // Add more hizb data as needed
    };

    return hizbData[hizbNumber] ?? 'Hizb $hizbNumber';
  }
}
