import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

/// Small badge showing khatma type (Personal, Shared, Hifz)
///
/// Can be reused anywhere khatma type needs to be displayed
class KhatmaTypeBadge extends StatelessWidget {
  const KhatmaTypeBadge({
    super.key,
    required this.type,
    this.size = BadgeSize.small,
  });

  final KhatmaType type;
  final BadgeSize size;

  @override
  Widget build(BuildContext context) {
    final config = _getTypeConfig(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size == BadgeSize.small ? 8 : 12,
        vertical: size == BadgeSize.small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: config.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            config.icon,
            size: size == BadgeSize.small ? 12 : 14,
            color: config.color,
          ),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: context.textTheme.labelSmall?.copyWith(
              color: config.color,
              fontWeight: FontWeight.w600,
              fontSize: size == BadgeSize.small ? 10 : 11,
            ),
          ),
        ],
      ),
    );
  }

  _TypeConfig _getTypeConfig(BuildContext context) {
    return switch (type) {
      KhatmaType.personal => _TypeConfig(
          label: context.loc.personal,
          icon: Icons.person,
          color: context.colorScheme.primary,
        ),
      KhatmaType.shared => _TypeConfig(
          label: context.loc.shared,
          icon: Icons.groups,
          color: const Color(0xFF10B981), // Green
        ),
      KhatmaType.hifz => _TypeConfig(
          label: context.loc.hifz,
          icon: Icons.school,
          color: const Color(0xFFF59E0B), // Amber
        ),
    };
  }
}

enum BadgeSize { small, medium }

class _TypeConfig {
  final String label;
  final IconData icon;
  final Color color;

  _TypeConfig({
    required this.label,
    required this.icon,
    required this.color,
  });
}
