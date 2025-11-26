import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaUnitsHeader extends StatelessWidget {
  const KhatmaUnitsHeader({
    super.key,
    required this.unitName,
    required this.hasSelectedUnits,
    required this.onClearSelection,
    this.selectedReservedCount = 0,
    this.onUnreserveAll,
  });

  final String unitName;
  final bool hasSelectedUnits;
  final VoidCallback onClearSelection;
  final int selectedReservedCount;
  final VoidCallback? onUnreserveAll;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.loc.khatmaUnitsWithType(unitName),
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          // Action buttons (only visible when units are selected)
          if (hasSelectedUnits)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Unreserve all button (only for reserved units)
                if (selectedReservedCount > 0 && onUnreserveAll != null)
                  TextButton.icon(
                    onPressed: onUnreserveAll,
                    icon: const Icon(Icons.lock_open, size: 18),
                    label: Text(context.loc.unreserveUnits(selectedReservedCount)),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      foregroundColor: Colors.orange.shade700,
                    ),
                  ),
                // Clear selection button
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
            ),
        ],
      ),
    );
  }
}
