import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/list/ui/components/list_components.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/utils/duration_formatter.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Improved khatma tile with modern design
///
/// Features:
/// - Type badge (Personal/Shared/Hifz)
/// - Progress with percentage
/// - Stats chips (participants, time, etc.)
/// - Better visual hierarchy
class ImprovedKhatmaTile extends StatelessWidget {
  const ImprovedKhatmaTile({
    super.key,
    required this.khatma,
    required this.onPressed,
  });

  final Khatma khatma;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: khatma.style.hexColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Circular Avatar with Progress + Title + Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KhatmaCircularAvatar(
                    icon: khatma.style.icon,
                    color: khatma.style.hexColor,
                    progress: khatma.completionPercent,
                    size: 52,
                    showPercentage: true,
                  ),
                  gapW12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          khatma.name,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            // Time/Date
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatDateAsTextDuration(
                                context.loc,
                                khatma.lastUpdated ?? khatma.createDate,
                              ),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            // Participants (for shared khatmas only)
                            if (khatma is KhatmaShared) ...[
                              const SizedBox(width: 12),
                              Icon(
                                Icons.people,
                                size: 14,
                                color: const Color(0xFF10B981),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(khatma as KhatmaShared).membersCount}',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF10B981),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  gapW8,
                  Icon(
                    Icons.chevron_right_rounded,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
