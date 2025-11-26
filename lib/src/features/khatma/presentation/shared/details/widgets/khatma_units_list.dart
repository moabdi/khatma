import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';
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
    // Build list of all units with their display status
    final allUnits = List.generate(
      state.khatma.totalUnits,
      (index) {
        final number = index + 1;
        return state.khatma.units.firstWhere(
          (u) => u.number == number,
          orElse: () => Unit(number: number),
        );
      },
    );

    // Filter units based on active filter
    final visibleUnits = allUnits.where((unit) => state.shouldShowUnit(unit)).toList();

    // Sort units based on active filter
    final isMineFilter = state.activeFilters.contains(UnitFilter.mine);

    if (isMineFilter) {
      // For "mine" filter: show reserved first, then completed (both sorted by number)
      visibleUnits.sort((a, b) {
        // Both reserved - sort by number
        if (a.isReserved && b.isReserved) {
          return a.number.compareTo(b.number);
        }
        // a is reserved, b is not - a comes first
        if (a.isReserved) return -1;
        // b is reserved, a is not - b comes first
        if (b.isReserved) return 1;

        // Both completed - sort by number
        if (a.isCompleted && b.isCompleted) {
          return a.number.compareTo(b.number);
        }
        // a is completed, b is not - a comes first
        if (a.isCompleted) return -1;
        // b is completed, a is not - b comes first
        if (b.isCompleted) return 1;

        // Default: sort by number
        return a.number.compareTo(b.number);
      });
    } else {
      // For other filters: sort naturally by number
      visibleUnits.sort((a, b) => a.number.compareTo(b.number));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visibleUnits.length,
      itemBuilder: (context, index) {
        final unit = visibleUnits[index];

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
          userPhotoUrl: _getUserPhotoUrl(unit),
        );
      },
    );
  }

  bool _isOwnedByCurrentUser(Unit unit) {
    if (state.currentUserId == null) return false;
    return unit.reservedBy == state.currentUserId;
  }

  String? _getUserPhotoUrl(Unit unit) {
    if (unit.reservedBy == null) return null;

    // Find the participant in the khatma's participants list
    final participant = state.khatma.participants.firstWhere(
      (p) => p.userId == unit.reservedBy,
      orElse: () => Participant(
        userId: unit.reservedBy!,
        userName: unit.reservedByName ?? '',
        joinedDate: DateTime.now(),
      ),
    );

    return participant.userPhotoUrl;
  }
}
