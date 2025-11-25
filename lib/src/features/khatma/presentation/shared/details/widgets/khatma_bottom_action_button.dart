import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Action types for the bottom button
enum KhatmaActionType {
  join,
  reserveAndJoin,
  reserve,
  unreserve,
}

/// Button information model
class KhatmaButtonInfo {
  final String buttonText;
  final String subtitle;
  final String? hint;
  final IconData icon;
  final Color? color;
  final bool isWarning;
  final KhatmaActionType action;

  const KhatmaButtonInfo({
    required this.buttonText,
    required this.subtitle,
    this.hint,
    required this.icon,
    this.color,
    this.isWarning = false,
    required this.action,
  });
}

class KhatmaBottomActionButton extends StatelessWidget {
  const KhatmaBottomActionButton({
    super.key,
    required this.state,
    required this.khatma,
    required this.onAction,
  });

  final KhatmaDetailsState state;
  final KhatmaShared khatma;
  final void Function(KhatmaActionType action, List<int> selectedUnits) onAction;

  @override
  Widget build(BuildContext context) {
    final selectedUnitsCount = state.selectedUnits.length;
    final hasSelection = selectedUnitsCount > 0;
    final canConfirm = hasSelection && !state.isJoining;

    // Determine button text and action based on user state and selection
    final buttonInfo = _getButtonInfo(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selection info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonInfo.subtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (buttonInfo.hint != null)
                  Text(
                    buttonInfo.hint!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: buttonInfo.isWarning
                          ? Colors.orange.shade600
                          : Colors.green.shade600,
                    ),
                  ),
              ],
            ),
            gapH12,
            // Action button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: canConfirm
                    ? () {
                        final selectedUnits =
                            state.selectedUnits.map((u) => u.number).toList();
                        onAction(buttonInfo.action, selectedUnits);
                      }
                    : null,
                icon: state.isJoining
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(buttonInfo.icon),
                label: Text(
                  state.isJoining ? context.loc.loading : buttonInfo.buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: buttonInfo.color ?? khatma.style.hexColor,
                  disabledBackgroundColor:
                      context.colorScheme.surfaceContainerHighest,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  KhatmaButtonInfo _getButtonInfo(BuildContext context) {
    final selectedCount = state.selectedUnits.length;
    final isParticipant = state.isUserParticipant;
    final areReservedUnitsSelected = state.areAllSelectedUnitsReserved;
    final currentReserved = state.currentUserReservedCount;
    final maxReservations = state.maxReservationsPerUser;

    if (!isParticipant && selectedCount == 0) {
      // User not in khatma, no selection
      return KhatmaButtonInfo(
        buttonText: context.loc.joinKhatma,
        subtitle: context.loc.selectUnitsToJoin,
        icon: Icons.group_add,
        action: KhatmaActionType.join,
      );
    }

    if (!isParticipant && selectedCount > 0) {
      // User not in khatma, has selection
      return KhatmaButtonInfo(
        buttonText: context.loc.reserveAndJoin(selectedCount),
        subtitle:
            context.loc.unitsSelectedMax(selectedCount, maxReservations),
        hint: context.loc.willJoinKhatma,
        icon: Icons.group_add,
        action: KhatmaActionType.reserveAndJoin,
      );
    }

    if (isParticipant && areReservedUnitsSelected) {
      // User in khatma, selected their own reserved units
      return KhatmaButtonInfo(
        buttonText: context.loc.unreserveUnits(selectedCount),
        subtitle: context.loc.unitsSelected(selectedCount),
        hint: context.loc.willFreeUnits,
        icon: Icons.lock_open,
        color: Colors.orange.shade700,
        isWarning: true,
        action: KhatmaActionType.unreserve,
      );
    }

    // User in khatma, selecting free units
    final remaining = maxReservations - currentReserved;
    return KhatmaButtonInfo(
      buttonText: context.loc.reserveUnitsAction(selectedCount),
      subtitle: context.loc.reservedSelectedInfo(
          currentReserved, maxReservations, selectedCount),
      hint: remaining == selectedCount
          ? null
          : context.loc.unitsRemaining(remaining),
      icon: Icons.check_circle,
      action: KhatmaActionType.reserve,
    );
  }
}
