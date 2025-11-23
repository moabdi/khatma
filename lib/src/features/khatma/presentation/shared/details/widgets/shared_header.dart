import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/list/widgets/list_components.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/utils/duration_formatter.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Header component for khatma details screen
///
/// Shows circular avatar with progress, title, and metadata
class KhatmaDetailsHeader extends StatelessWidget {
  const KhatmaDetailsHeader({
    super.key,
    required this.khatma,
  });

  final KhatmaShared khatma;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            khatma.style.hexColor.withValues(alpha: 0.1),
            khatma.style.hexColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: khatma.style.hexColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular avatar with progress
          KhatmaCircularAvatar(
            icon: khatma.style.icon,
            color: khatma.style.hexColor,
            progress: khatma.completionPercent,
            size: 80,
            showPercentage: true,
          ),
          gapW16,
          // Title and metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  khatma.name,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: khatma.style.hexColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                gapH8,
                // Type badge
                _TypeBadge(khatma: khatma),
                gapH12,
                // Metadata row
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${khatma.membersCount} ${context.loc.members}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        formatDateAsTextDuration(
                          context.loc,
                          khatma.lastUpdated ?? khatma.createDate,
                        ),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Type badge showing khatma type
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.khatma});

  final KhatmaShared khatma;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: khatma.style.hexColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: khatma.style.hexColor.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 14,
            color: khatma.style.hexColor,
          ),
          const SizedBox(width: 4),
          Text(
            'Shared',
            style: context.textTheme.labelSmall?.copyWith(
              color: khatma.style.hexColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
