import 'package:flutter/material.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitTile extends StatelessWidget {
  final SharedKhatmaUnit unit;
  final VoidCallback onTap;

  const UnitTile({
    super.key,
    required this.unit,
    required this.onTap,
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
            Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3);
        numberColor = Theme.of(context).colorScheme.onSurfaceVariant;
        isClickable = false;
        trailingIcon = Icon(
          Icons.lock,
          color:
              Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
          size: 20,
        );
        break;

      case UnitStatus.selected:
        tileColor = context.colorScheme.primaryContainer.withOpacity(0.3);
        avatarColor = context.colorScheme.primary.withOpacity(0.5);
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

      default:
        // Use a safe, readable default for undefined statuses
        tileColor = Theme.of(context).colorScheme.surfaceContainer;
        avatarColor = Theme.of(context).colorScheme.error.withOpacity(0.3);
        numberColor = Theme.of(context).colorScheme.onErrorContainer;
        trailingIcon = null;
        isClickable = true;
        break;
    }

    // Calculate start ayah for the hizb (example calculation)
    final startAyah = _getStartAyahForHizb(unit.unitNumber);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: tileColor,
      elevation: unit.status == UnitStatus.reservedByCurrentUser ? 2 : 1,
      child: ListTile(
        onTap: isClickable ? onTap : null,
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          radius: 20,
          child: Text(
            '${unit.unitNumber}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
          ),
        ),
        title: Text(
          'Hizb ${unit.unitNumber}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          'Commence à: $startAyah',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: trailingIcon,
        dense: true,
      ),
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
