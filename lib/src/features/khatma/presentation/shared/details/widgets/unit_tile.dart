import 'package:flutter/material.dart';
import 'package:khatma/src/core/app_dialog.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/unit_avatar.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/unit_reservation_info.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/unit_subtitle.dart';
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
    this.isOwnedByCurrentUser = false,
    this.onSendReminder,
    this.onFreeUnit,
    this.color,
    this.isSelected = false,
    this.userPhotoUrl,
  });

  final Unit unit;
  final VoidCallback onTap;
  final int reservationWarningDays;
  final bool isUserAdminOrCreator;
  final bool isOwnedByCurrentUser;
  final VoidCallback? onSendReminder;
  final VoidCallback? onFreeUnit;
  final Color? color;
  final bool isSelected;
  final String? userPhotoUrl;

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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Unit avatar
              UnitAvatar(
                unitNumber: unit.number,
                backgroundColor: statusInfo.avatarColor,
                borderColor: statusInfo.iconColor,
                numberColor: statusInfo.numberColor,
                isSelected: isSelected,
                userId: unit.reservedBy,
                userName: unit.reservedByName,
                userPhotoUrl: userPhotoUrl,
              ),
              gapW12,
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Hizb ${unit.number}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (statusInfo.trailingIcon != null)
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: _shouldShowActions()
                                  ? () => _showActions(context)
                                  : null,
                              icon: Icon(
                                _shouldShowActions()
                                    ? Icons.lock_reset
                                    : statusInfo.trailingIcon,
                                color: _shouldShowActions() ? Colors.amber : statusInfo.iconColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    // Subtitle
                    Row(
                      children: [
                        Expanded(
                          child: UnitSubtitle(unitNumber: unit.number),
                        ),
                      ],
                    ),
                    // Reservation info
                    if (unit.reservedByName != null &&
                        unit.reservedDate != null &&
                        (unit.status == UnitStatus.reserved ||
                            unit.status == UnitStatus.completed))
                      UnitReservationInfo(
                        unit: unit,
                        isOverdue: isOverdue,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowActions() {
    return (unit.status == UnitStatus.reserved) &&
        (isUserAdminOrCreator || isOwnedByCurrentUser);
  }

  Future<void> _showActions(BuildContext context) async {
    final confirmed = await AppDialog.showConfirm(
      context,
      title: isOwnedByCurrentUser
          ? context.loc.unreserveUnit
          : context.loc.freeUnit,
      message: isOwnedByCurrentUser
          ? context.loc.cancelYourReservation
          : context.loc.confirmFreeUnit,
      confirmText: isOwnedByCurrentUser
          ? context.loc.unreserveUnit
          : context.loc.freeUnit,
      cancelText: context.loc.cancel,
    );

    if (confirmed == true && onFreeUnit != null) {
      onFreeUnit!();
    }
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
        // Reserved units are clickable if owned by current user or user is admin
        final canClick = isOwnedByCurrentUser || isUserAdminOrCreator;
        return _StatusInfo(
          backgroundColor: context.colorScheme.surfaceContainer,
          avatarColor:
              context.colorScheme.onSurfaceVariant.withValues(alpha: 0.15),
          numberColor: context.colorScheme.onSurfaceVariant,
          iconColor: context.colorScheme.onSurfaceVariant,
          borderColor:
              context.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          trailingIcon: Icons.lock_outline,
          isClickable: canClick,
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
