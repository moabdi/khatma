import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Progress statistics cards for khatma details
///
/// Shows three stat cards: Members, Free Units, and Completed
class KhatmaProgressStats extends StatelessWidget {
  const KhatmaProgressStats({
    super.key,
    required this.khatma,
  });

  final KhatmaShared khatma;

  double _calculateTakenUnitsPercent() {
    final reservedCount =
        khatma.units.where((u) => u.status == UnitStatus.reserved).length;
    final completedCount =
        khatma.units.where((u) => u.status == UnitStatus.completed).length;
    final takenCount = reservedCount + completedCount;
    return (takenCount / khatma.totalUnits).clamp(0.0, 1.0);
  }

  double _calculateFreeUnitsPercent() {
    final reservedCount =
        khatma.units.where((u) => u.status == UnitStatus.reserved).length;
    final completedCount =
        khatma.units.where((u) => u.status == UnitStatus.completed).length;
    final freeCount = khatma.totalUnits - reservedCount - completedCount;
    return (freeCount / khatma.totalUnits).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _ProgressStatCardWithCount(
                icon: Icons.people_rounded,
                label: context.loc.members,
                count: khatma.membersCount.toString(),
                percent: _calculateTakenUnitsPercent(),
                color: context.colorScheme.primary,
              ),
            ),
            gapW12,
            Expanded(
              child: _ProgressStatCard(
                label: context.loc.freeUnits,
                percent: _calculateFreeUnitsPercent(),
                color: context.colorScheme.secondary,
              ),
            ),
            gapW12,
            Expanded(
              child: _ProgressStatCard(
                label: context.loc.completed,
                percent: khatma.completionPercent,
                color: context.colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Progress card with count (circular indicator)
class _ProgressStatCardWithCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final double percent;
  final Color color;

  const _ProgressStatCardWithCount({
    required this.icon,
    required this.label,
    required this.count,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular progress indicator with icon and count
        SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  value: percent.clamp(0.0, 1.0),
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Icon and count
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 16,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    count,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        gapH8,
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// Progress card without count (circular indicator)
class _ProgressStatCard extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;

  const _ProgressStatCard({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular progress indicator
        SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  value: percent.clamp(0.0, 1.0),
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Percentage text
              Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
              ),
            ],
          ),
        ),
        gapH8,
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
