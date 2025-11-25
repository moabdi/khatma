import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

class UnitReservationInfo extends StatelessWidget {
  const UnitReservationInfo({
    super.key,
    required this.unit,
    required this.isOverdue,
  });

  final Unit unit;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    String? dateText;

    if (unit.status == UnitStatus.reserved && unit.reservedDate != null) {
      final formattedDate = unit.reservedDate!.format();
      dateText = '${context.loc.reservedOn}: $formattedDate';
    } else if (unit.status == UnitStatus.completed &&
        unit.completedDate != null) {
      final formattedDate = unit.completedDate!.format();
      dateText = '${context.loc.completedOn}: $formattedDate';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Date on the left
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dateText != null)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: isOverdue
                                ? Colors.orange.shade700
                                : context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              dateText,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: isOverdue
                                    ? Colors.orange.shade700
                                    : context.colorScheme.onSurfaceVariant,
                                fontWeight: isOverdue ? FontWeight.w600 : null,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Username on the right
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit.reservedByName!,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (isOverdue) ...[
            const SizedBox(height: 2),
            Text(
              context.loc.daysOverdue(_getDaysSinceReserved()),
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  int _getDaysSinceReserved() {
    if (unit.reservedDate == null) return 0;
    return DateTime.now().difference(unit.reservedDate!).inDays;
  }
}
