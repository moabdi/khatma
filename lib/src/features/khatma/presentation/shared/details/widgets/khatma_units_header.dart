import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaUnitsHeader extends StatelessWidget {
  const KhatmaUnitsHeader({
    super.key,
    required this.unitName,
    required this.hasSelectedUnits,
    required this.onClearSelection,
  });

  final String unitName;
  final bool hasSelectedUnits;
  final VoidCallback onClearSelection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.loc.khatmaUnitsWithType(unitName),
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Clear selection button (only visible when units are selected)
        if (hasSelectedUnits)
          TextButton.icon(
            onPressed: onClearSelection,
            icon: const Icon(Icons.clear_all, size: 18),
            label: Text(context.loc.clearSelection),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
      ],
    );
  }
}
