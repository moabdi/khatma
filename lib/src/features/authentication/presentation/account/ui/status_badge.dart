import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

enum StatusType {
  success,
  warning,
  error,
  info,
  neutral,
}

class StatusBadge extends StatelessWidget {
  final String text;
  final StatusType type;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isCompact;
  final double? fontSize;
  final FontWeight? fontWeight;

  const StatusBadge({
    super.key,
    required this.text,
    required this.type,
    this.icon,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  });

  static StatusBadge forEmailVerification({
    required bool isVerified,
    required String verifiedText,
    required String unverifiedText,
    VoidCallback? onTap,
    bool isCompact = false,
  }) {
    return isVerified
        ? StatusBadge.verified(
            text: verifiedText,
            onTap: onTap,
            isCompact: isCompact,
          )
        : StatusBadge.unverified(
            text: unverifiedText,
            onTap: onTap,
            isCompact: isCompact,
          );
  }

  // Factory constructors for common use cases
  const StatusBadge.verified({
    super.key,
    required this.text,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  })  : type = StatusType.success,
        icon = Icons.verified_user;

  const StatusBadge.unverified({
    super.key,
    required this.text,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  })  : type = StatusType.warning,
        icon = Icons.warning_amber;

  const StatusBadge.error({
    super.key,
    required this.text,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  })  : type = StatusType.error,
        icon = Icons.error_outline;

  const StatusBadge.info({
    super.key,
    required this.text,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  })  : type = StatusType.info,
        icon = Icons.info_outline;
  const StatusBadge.neutral({
    super.key,
    required this.text,
    this.onTap,
    this.isCompact = false,
    this.fontSize,
    this.fontWeight,
  })  : type = StatusType.neutral,
        icon = null;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    final padding = isCompact
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    final iconSize = isCompact ? 14.0 : 16.0;
    final textSize = fontSize ?? (isCompact ? 11.0 : 12.0);
    final weight = fontWeight ?? FontWeight.w500;

    Widget badge = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize,
              color: colors.foreground,
            ),
            isCompact ? gapW4 : gapW8,
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: weight,
              color: colors.foreground,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: badge,
      );
    }

    return badge;
  }

  _StatusColors _getColors(BuildContext context) {
    final theme = Theme.of(context);

    switch (type) {
      case StatusType.success:
        return _StatusColors(
          background: Colors.green.shade50,
          border: Colors.green.shade300,
          foreground: Colors.green.shade700,
        );
      case StatusType.warning:
        return _StatusColors(
          background: Colors.orange.shade50,
          border: Colors.orange.shade300,
          foreground: Colors.orange.shade700,
        );
      case StatusType.error:
        return _StatusColors(
          background: Colors.red.shade50,
          border: Colors.red.shade300,
          foreground: Colors.red.shade700,
        );
      case StatusType.info:
        return _StatusColors(
          background: Colors.blue.shade100,
          border: Colors.blue.shade300,
          foreground: Colors.blue.shade700,
        );
      case StatusType.neutral:
        return _StatusColors(
          background: theme.colorScheme.surfaceVariant,
          border: theme.colorScheme.outline,
          foreground: theme.colorScheme.onSurfaceVariant,
        );
    }
  }
}

class _StatusColors {
  final Color background;
  final Color border;
  final Color foreground;

  const _StatusColors({
    required this.background,
    required this.border,
    required this.foreground,
  });
}

// Static helper method for email verification
