import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';

class KhatmaDetailsState {
  final KhatmaShared khatma;
  final Set<UnitFilter> activeFilters;
  final bool isJoining;
  final String? currentUserId;
  final Set<int> selectedUnitNumbers;

  KhatmaDetailsState({
    required this.khatma,
    required this.activeFilters,
    this.isJoining = false,
    this.currentUserId,
    this.selectedUnitNumbers = const {},
  });

  KhatmaDetailsState copyWith({
    KhatmaShared? khatma,
    Set<UnitFilter>? activeFilters,
    bool? isJoining,
    String? currentUserId,
    Set<int>? selectedUnitNumbers,
  }) {
    return KhatmaDetailsState(
      khatma: khatma ?? this.khatma,
      activeFilters: activeFilters ?? this.activeFilters,
      isJoining: isJoining ?? this.isJoining,
      currentUserId: currentUserId ?? this.currentUserId,
      selectedUnitNumbers: selectedUnitNumbers ?? this.selectedUnitNumbers,
    );
  }

  // Check if user is a participant
  bool get isUserParticipant {
    if (currentUserId == null) return false;
    return khatma.participants.any((p) => p.userId == currentUserId);
  }

  // Check if user is admin or creator
  bool get isUserAdminOrCreator {
    if (currentUserId == null) return false;
    return khatma.hasPrivileges(currentUserId!);
  }

  // Check if there are any selected units
  bool get hasSelectedUnits {
    return khatma.units.any((unit) => unit.status == UnitStatus.selected) || selectedUnitNumbers.isNotEmpty;
  }

  // Get all selected units
  List<Unit> get selectedUnits {
    return khatma.units.where((unit) =>
      unit.status == UnitStatus.selected || selectedUnitNumbers.contains(unit.number)
    ).toList();
  }

  // Check if all selected units are free
  bool get areAllSelectedUnitsFree {
    final selected = selectedUnits;
    if (selected.isEmpty) return false;
    return selected.every((unit) => unit.status == UnitStatus.selected && unit.reservedBy == null);
  }

  // Check if all selected units are reserved
  bool get areAllSelectedUnitsReserved {
    final selected = selectedUnits;
    if (selected.isEmpty) return false;
    return selected.every((unit) => unit.reservedBy != null);
  }

  // Get current user's reserved units count
  int get currentUserReservedCount {
    if (currentUserId == null) return 0;
    return khatma.userReservedUnits(currentUserId!).length;
  }

  // Get current user's completed units count
  int get currentUserCompletedCount {
    if (currentUserId == null) return 0;
    return khatma.userCompletedUnits(currentUserId!).length;
  }

  // Get current user's total units (reserved + completed)
  int get currentUserTotalUnits {
    if (currentUserId == null) return 0;
    return khatma.userTotalUnits(currentUserId!);
  }

  // Get max reservations allowed
  int get maxReservationsPerUser {
    return khatma.maxReservationsPerUser;
  }

  // Get max units to read (total limit)
  int get maxUnitsToRead {
    return khatma.config.maxUnitsToRead;
  }

  // Check if user has reached reservation limit
  bool get hasReachedReservationLimit {
    if (currentUserId == null) return false;
    return !khatma.canUserReserveMore(currentUserId!);
  }

  // Get remaining reservations for current user
  int get remainingReservations {
    if (currentUserId == null) return 0;
    return khatma.remainingReservations(currentUserId!);
  }

  // Check if there are any visible units matching the current filter
  bool get hasVisibleUnits {
    for (int i = 0; i < khatma.totalUnits; i++) {
      final number = i + 1;
      final unit = khatma.units.firstWhere(
        (u) => u.number == number,
        orElse: () => Unit(number: number),
      );
      if (shouldShowUnit(unit)) {
        return true;
      }
    }
    return false;
  }

  bool shouldShowUnit(Unit unit) {
    if (activeFilters.contains(UnitFilter.all)) {
      return true;
    }

    for (final filter in activeFilters) {
      switch (filter) {
        case UnitFilter.all:
          return true;
        case UnitFilter.mine:
          if (unit.isReserved) return true;
        case UnitFilter.reserved:
          if (unit.isReserved) return true;
        case UnitFilter.free:
          // Show units that are available (free OR selected - not confirmed yet)
          if (unit.isFree || unit.status == UnitStatus.selected) return true;
        case UnitFilter.completed:
          if (unit.status == UnitStatus.completed) return true;
      }
    }

    return false;
  }

  // Get count of units for each filter
  int getFilterCount(UnitFilter filter) {
    switch (filter) {
      case UnitFilter.all:
        return khatma.totalUnits;
      case UnitFilter.mine:
        return khatma.units.where((u) => u.isReserved).length;
      case UnitFilter.reserved:
        return khatma.units.where((u) => u.isReserved).length;
      case UnitFilter.free:
        // Count available units = totalUnits - (reserved + completed)
        // Includes both free AND selected (since selected is not confirmed)
        final reservedCount = khatma.units.where((u) => u.status == UnitStatus.reserved).length;
        final completedCount = khatma.units.where((u) => u.status == UnitStatus.completed).length;
        return khatma.totalUnits - reservedCount - completedCount;
      case UnitFilter.completed:
        return khatma.units.where((u) => u.isCompleted).length;
    }
  }
}

class KhatmaDetailsController extends StateNotifier<KhatmaDetailsState> {
  KhatmaDetailsController(KhatmaShared khatma, String? currentUserId)
      : super(KhatmaDetailsState(
          khatma: khatma,
          activeFilters: _getDefaultFilters(khatma, currentUserId),
          currentUserId: currentUserId,
        ));

  // Default filter logic:
  // - Non-participants: show "free" filter
  // - Participants with reserved units: show "mine" filter
  // - Participants without reserved units: show "all" filter
  static Set<UnitFilter> _getDefaultFilters(KhatmaShared khatma, String? currentUserId) {
    // Check if user is a participant
    final isParticipant = currentUserId != null &&
        khatma.participants.any((p) => p.userId == currentUserId);

    if (!isParticipant) {
      // Non-participant: show free units by default
      return {UnitFilter.free};
    }

    // For participants, check if they have reserved units
    final mineCount = khatma.units
        .where((u) => u.isReserved && u.reservedBy == currentUserId)
        .length;

    if (mineCount > 0) {
      return {UnitFilter.mine};
    }

    return {UnitFilter.all};
  }

  void setCurrentUserId(String userId) {
    state = state.copyWith(currentUserId: userId);
  }

  /// Update the khatma when it changes from the manager
  void updateKhatma(KhatmaShared updatedKhatma) {
    state = state.copyWith(khatma: updatedKhatma);
  }

  void toggleFilter(UnitFilter filter) {
    // Only one filter can be selected at a time
    // Simply replace the current filter with the new one
    state = state.copyWith(activeFilters: {filter});
  }

  /// Clear all selected units
  void clearSelection() {
    final updatedUnits = state.khatma.units.map((u) {
      if (u.status == UnitStatus.selected) {
        // If it was a free unit being selected, make it free
        if (u.reservedBy == null) {
          return u.copyWith(status: UnitStatus.free);
        }
        // If it was a reserved unit, keep it as reserved
        return u.copyWith(status: UnitStatus.reserved);
      }
      return u;
    }).toList();

    state = state.copyWith(
      khatma: state.khatma.copyWith(units: updatedUnits),
      selectedUnitNumbers: {}, // Clear the selection set
    );
  }

  /// Toggle unit selection with validation
  /// Returns error message if selection is invalid, null otherwise
  String? toggleUnitSelection(Unit unit) {
    final isCurrentlySelected = unit.status == UnitStatus.selected ||
                                state.selectedUnitNumbers.contains(unit.number);

    if (isCurrentlySelected) {
      // Deselect the unit
      _deselectUnit(unit);
      return null;
    }

    // Check if unit can be selected
    final canSelect = _canSelectUnit(unit);
    if (canSelect != null) {
      return canSelect; // Return error message
    }

    // Check for mixed selection type
    final mixedTypeError = _validateMixedSelection(unit);
    if (mixedTypeError != null) {
      return mixedTypeError;
    }

    // Select the unit
    _selectUnit(unit);
    return null;
  }

  /// Check if a unit can be selected
  String? _canSelectUnit(Unit unit) {
    // Completed units cannot be selected
    if (unit.isCompleted) {
      return 'Completed units cannot be selected';
    }

    // Free units - check both reservation limit and reading limit
    if (unit.isFree) {
      // Check if user would exceed reservation limit with this selection
      final currentReserved = state.currentUserReservedCount;
      final currentSelected = state.selectedUnits.where((u) => u.reservedBy == null).length;
      final totalReservedAfterSelection = currentReserved + currentSelected + 1;

      if (totalReservedAfterSelection > state.maxReservationsPerUser) {
        return 'Reservation limit reached: ${state.maxReservationsPerUser} units max';
      }

      // Check if user would exceed reading limit (total units)
      final currentTotal = state.currentUserTotalUnits;
      final totalUnitsAfterSelection = currentTotal + currentSelected + 1;

      if (totalUnitsAfterSelection > state.maxUnitsToRead) {
        return 'Reading limit reached: ${state.maxUnitsToRead} total units max';
      }

      return null;
    }

    // Reserved units can only be selected by owner or admin
    if (unit.isReserved) {
      final isOwner = unit.reservedBy == state.currentUserId;
      final isAdmin = state.isUserAdminOrCreator;

      if (!isOwner && !isAdmin) {
        return 'Only the owner or admin can select this reserved unit';
      }
      return null;
    }

    return null;
  }

  /// Validate that selection doesn't mix free and reserved units
  String? _validateMixedSelection(Unit newUnit) {
    final currentSelection = state.selectedUnits;

    if (currentSelection.isEmpty) {
      return null; // First selection, no conflict
    }

    final hasReservedInSelection = currentSelection.any((u) => u.reservedBy != null);
    final hasFreeInSelection = currentSelection.any((u) => u.reservedBy == null);

    final isNewUnitReserved = newUnit.reservedBy != null || newUnit.isReserved;

    if (hasReservedInSelection && !isNewUnitReserved) {
      return 'Cannot mix reserved and free units in selection';
    }

    if (hasFreeInSelection && isNewUnitReserved) {
      return 'Cannot mix free and reserved units in selection';
    }

    return null;
  }

  void _selectUnit(Unit unit) {
    // For reserved units, add to selectedUnitNumbers set without changing status
    if (unit.isReserved || unit.reservedBy != null) {
      final updatedSelection = Set<int>.from(state.selectedUnitNumbers)..add(unit.number);
      state = state.copyWith(selectedUnitNumbers: updatedSelection);
      return;
    }

    // For free units, change status to selected
    final updatedUnits = state.khatma.units.map((u) {
      if (u.number == unit.number) {
        return u.copyWith(status: UnitStatus.selected);
      }
      return u;
    }).toList();

    // Add the unit if it doesn't exist in the list
    if (!updatedUnits.any((u) => u.number == unit.number)) {
      updatedUnits.add(Unit(
        number: unit.number,
        status: UnitStatus.selected,
      ));
    }

    state = state.copyWith(
      khatma: state.khatma.copyWith(units: updatedUnits),
    );
  }

  void _deselectUnit(Unit unit) {
    // For reserved units, remove from selectedUnitNumbers set
    if (unit.isReserved || unit.reservedBy != null) {
      final updatedSelection = Set<int>.from(state.selectedUnitNumbers)..remove(unit.number);
      state = state.copyWith(selectedUnitNumbers: updatedSelection);
      return;
    }

    // For free units, change status back to free
    final updatedUnits = state.khatma.units.map((u) {
      if (u.number == unit.number) {
        return u.copyWith(status: UnitStatus.free);
      }
      return u;
    }).toList();

    state = state.copyWith(
      khatma: state.khatma.copyWith(units: updatedUnits),
    );
  }

  Future<void> confirmJoin() async {
    state = state.copyWith(isJoining: true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success - the calling widget should handle navigation
    } catch (e) {
      // Error - rethrow to let the widget handle it
      rethrow;
    } finally {
      state = state.copyWith(isJoining: false);
    }
  }
}

// Provider for the controller
// Use autoDispose to keep state alive during the screen session
// Key by khatma ID instead of entire khatma object to prevent recreating controller
final khatmaDetailsControllerProvider = StateNotifierProvider.family.autoDispose<
    KhatmaDetailsController, KhatmaDetailsState, String>(
  (ref, khatmaId) {
    // Watch the khatma manager state to get updates
    final managerState = ref.watch(khatmaManagerProvider);
    final khatmas = managerState.khatmas.valueOrNull ?? [];

    // Find the khatma by ID
    final khatma = khatmas.firstWhere(
      (k) => k.id == khatmaId,
      orElse: () => throw StateError('Khatma with id $khatmaId not found'),
    ) as KhatmaShared;

    // Get current user ID from auth provider
    final currentUser = ref.watch(userProvider);
    final currentUserId = currentUser?.id;

    final controller = KhatmaDetailsController(khatma, currentUserId);

    // Listen to khatma manager changes and update the controller's khatma
    ref.listen(
      khatmaManagerProvider,
      (previous, next) {
        final updatedKhatmas = next.khatmas.valueOrNull ?? [];
        final updatedKhatmaOrNull = updatedKhatmas.firstWhere(
          (k) => k.id == khatmaId,
          orElse: () => khatma,
        );

        if (updatedKhatmaOrNull is KhatmaShared && updatedKhatmaOrNull != khatma) {
          controller.updateKhatma(updatedKhatmaOrNull);
        }
      },
    );

    return controller;
  },
);
