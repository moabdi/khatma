import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/unit_tile.dart';

class KhatmaUnitsList extends StatelessWidget {
  const KhatmaUnitsList({
    super.key,
    required this.state,
    required this.onUnitTap,
    required this.onSendReminder,
    required this.onFreeUnit,
  });

  final KhatmaDetailsState state;
  final void Function(Unit unit) onUnitTap;
  final void Function(Unit unit) onSendReminder;
  final void Function(Unit unit) onFreeUnit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.khatma.totalUnits,
      itemBuilder: (context, index) {
        final number = index + 1;
        final unit = state.khatma.units.firstWhere(
          (u) => u.number == number,
          orElse: () => Unit(number: number),
        );

        // Apply filter
        if (!state.shouldShowUnit(unit)) {
          return const SizedBox.shrink();
        }

        return UnitTile(
          unit: unit,
          onTap: () => onUnitTap(unit),
          reservationWarningDays: state.khatma.reservationWarningDays,
          isUserAdminOrCreator: state.isUserAdminOrCreator,
          isOwnedByCurrentUser: _isOwnedByCurrentUser(unit),
          onSendReminder: () => onSendReminder(unit),
          onFreeUnit: () => onFreeUnit(unit),
          color: state.khatma.style.hexColor,
          isSelected: state.selectedUnitNumbers.contains(unit.number),
        );
      },
    );
  }

  bool _isOwnedByCurrentUser(Unit unit) {
    if (state.currentUserId == null) return false;
    return unit.reservedBy == state.currentUserId;
  }
}
