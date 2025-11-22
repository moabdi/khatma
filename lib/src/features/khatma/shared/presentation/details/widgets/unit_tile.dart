import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

class UnitTile extends StatelessWidget {
  const UnitTile({
    super.key,
    required this.unit,
    required this.onTap,
    this.reservationWarningDays = 7,
    this.isUserAdminOrCreator = false,
    this.onSendReminder,
    this.onFreeUnit,
    this.color,
  });

  final Unit unit;
  final VoidCallback onTap;
  final int reservationWarningDays;
  final bool isUserAdminOrCreator;
  final VoidCallback? onSendReminder;
  final VoidCallback? onFreeUnit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(context);
    final isOverdue = _isOverdue();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      elevation: unit.status == UnitStatus.selected ? .5 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: statusInfo.borderColor,
          width: unit.status == UnitStatus.selected ? .5 : 0,
        ),
      ),
      color: statusInfo.backgroundColor,
      child: InkWell(
        onTap: statusInfo.isClickable ? onTap : null,
        onLongPress: isOverdue && isUserAdminOrCreator
            ? () => _showAdminActions(context)
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Unit number avatar
              _buildAvatar(context, statusInfo),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hizb ${unit.number}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Status icon
                        if (statusInfo.trailingIcon != null)
                          Icon(
                            statusInfo.trailingIcon,
                            color: statusInfo.iconColor,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Subtitle with metadata
                    _buildSubtitle(context, isOverdue),
                    // Member name for reserved/completed
                    if (unit.reservedByName != null &&
                        (unit.status == UnitStatus.reserved ||
                            unit.status == UnitStatus.completed)) ...[
                      const SizedBox(height: 4),
                      Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, _StatusInfo statusInfo) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: statusInfo.avatarColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: statusInfo.iconColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '${unit.number}',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: statusInfo.numberColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isOverdue) {
    String subtitleText = _getStartAyahForHizb(unit.number);
    String? dateText;

    if (unit.status == UnitStatus.reserved && unit.reservedDate != null) {
      final formattedDate = unit.reservedDate!.format();
      dateText = '${context.loc.reservedOn}: $formattedDate';
    } else if (unit.status == UnitStatus.completed &&
        unit.completedDate != null) {
      final formattedDate = unit.completedDate!.format();
      dateText = '${context.loc.completedOn}: $formattedDate';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Start ayah
        Row(
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 12,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              subtitleText,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
        // Date info
        if (dateText != null) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              if (isOverdue) ...[
                const Text(
                  '⚠️',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 4),
              ],
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
        // Overdue warning
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
    );
  }

  _StatusInfo _getStatusInfo(BuildContext context) {
    switch (unit.status) {
      case UnitStatus.free:
        return _StatusInfo(
          backgroundColor: context.colorScheme.surfaceContainerLow,
          avatarColor: context.colorScheme.surface,
          numberColor: context.colorScheme.onSurfaceVariant,
          iconColor: context.colorScheme.onSurfaceVariant,
          borderColor: context.colorScheme.outlineVariant,
          trailingIcon: null,
          isClickable: true,
        );

      case UnitStatus.reserved:
        return _StatusInfo(
          backgroundColor: context.colorScheme.surfaceContainer,
          avatarColor:
              context.colorScheme.onSurfaceVariant.withValues(alpha: 0.15),
          numberColor: context.colorScheme.onSurfaceVariant,
          iconColor: context.colorScheme.onSurfaceVariant,
          borderColor:
              context.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          trailingIcon: Icons.lock_outline,
          isClickable: false,
        );

      case UnitStatus.selected:
        final selectionColor = color ?? context.colorScheme.primary;
        return _StatusInfo(
          backgroundColor: selectionColor.withValues(alpha: 0.15),
          avatarColor: selectionColor.withValues(alpha: 0.2),
          numberColor: selectionColor,
          iconColor: selectionColor,
          borderColor: selectionColor,
          trailingIcon: Icons.check_circle,
          isClickable: true,
        );

      case UnitStatus.completed:
        return _StatusInfo(
          backgroundColor: context.colorScheme.surfaceContainerHigh,
          avatarColor: context.colorScheme.primary.withValues(alpha: 0.15),
          numberColor: context.colorScheme.primary,
          iconColor: context.colorScheme.primary,
          borderColor: context.colorScheme.primary.withValues(alpha: 0.3),
          trailingIcon: Icons.done_all_sharp,
          isClickable: false,
        );
    }
  }

  bool _isOverdue() {
    if (unit.status != UnitStatus.reserved || unit.reservedDate == null) {
      return false;
    }
    return _getDaysSinceReserved() >= reservationWarningDays;
  }

  int _getDaysSinceReserved() {
    if (unit.reservedDate == null) return 0;
    return DateTime.now().difference(unit.reservedDate!).inDays;
  }

  String _getStartAyahForHizb(int hizbNumber) {
    final hizbData = {
      1: 'Al-Fatiha 1',
      2: 'Al-Baqarah 26',
      3: 'Al-Baqarah 60',
      4: 'Al-Baqarah 92',
      5: 'Al-Baqarah 124',
      6: 'Al-Baqarah 160',
      7: 'Al-Baqarah 177',
      8: 'Al-Baqarah 198',
    };
    return hizbData[hizbNumber] ?? 'Hizb $hizbNumber';
  }

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
                  style: context.textTheme.bodySmall,
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
                  style: context.textTheme.bodySmall,
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
}

/// Internal class to hold status styling information
class _StatusInfo {
  final Color backgroundColor;
  final Color avatarColor;
  final Color numberColor;
  final Color iconColor;
  final Color borderColor;
  final IconData? trailingIcon;
  final bool isClickable;

  _StatusInfo({
    required this.backgroundColor,
    required this.avatarColor,
    required this.numberColor,
    required this.iconColor,
    required this.borderColor,
    this.trailingIcon,
    required this.isClickable,
  });
}
