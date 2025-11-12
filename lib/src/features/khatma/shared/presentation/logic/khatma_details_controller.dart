import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/shared/domain/shared_khatma.dart';
import 'package:khatma/src/features/khatma/shared/presentation/khatma_details_page.dart';

class KhatmaDetailsState {
  final SharedKhatma khatma;
  final Set<UnitFilter> activeFilters;
  final bool isJoining;

  KhatmaDetailsState({
    required this.khatma,
    required this.activeFilters,
    this.isJoining = false,
  });

  KhatmaDetailsState copyWith({
    SharedKhatma? khatma,
    Set<UnitFilter>? activeFilters,
    bool? isJoining,
  }) {
    return KhatmaDetailsState(
      khatma: khatma ?? this.khatma,
      activeFilters: activeFilters ?? this.activeFilters,
      isJoining: isJoining ?? this.isJoining,
    );
  }

  // Check if there are any selected units
  bool get hasSelectedUnits {
    return khatma.units.any((unit) => unit.status == UnitStatus.selected);
  }

  // Check if there are any visible units matching the current filter
  bool get hasVisibleUnits {
    for (int i = 0; i < khatma.totalUnits; i++) {
      final unitNumber = i + 1;
      final unit = khatma.units.firstWhere(
        (u) => u.unitNumber == unitNumber,
        orElse: () => SharedKhatmaUnit(unitNumber: unitNumber),
      );
      if (shouldShowUnit(unit)) {
        return true;
      }
    }
    return false;
  }

  bool shouldShowUnit(SharedKhatmaUnit unit) {
    if (activeFilters.contains(UnitFilter.all)) {
      return true;
    }

    for (final filter in activeFilters) {
      switch (filter) {
        case UnitFilter.all:
          return true;
        case UnitFilter.mine:
          if (unit.isReservedByCurrentUser) return true;
        case UnitFilter.reserved:
          if (unit.isReserved) return true;
        case UnitFilter.free:
          if (unit.isFree || unit.isSelected) return true;
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
        return khatma.units.where((u) => u.isReservedByCurrentUser).length;
      case UnitFilter.reserved:
        return khatma.units.where((u) => u.isReserved).length;
      case UnitFilter.free:
        return khatma.units.where((u) => u.isFree || u.isSelected).length;
      case UnitFilter.completed:
        return khatma.units.where((u) => u.isCompleted).length;
    }
  }
}

class KhatmaDetailsController extends StateNotifier<KhatmaDetailsState> {
  KhatmaDetailsController(SharedKhatma khatma)
      : super(KhatmaDetailsState(
          khatma: khatma,
          activeFilters: {UnitFilter.all},
        ));

  void toggleFilter(UnitFilter filter) {
    final newFilters = Set<UnitFilter>.from(state.activeFilters);
    newFilters.clear();

    if (filter == UnitFilter.all) {
      newFilters.clear();
      newFilters.add(UnitFilter.all);
    } else {
      if (newFilters.contains(UnitFilter.all)) {
        newFilters.clear();
      }

      if (newFilters.contains(filter)) {
        newFilters.remove(filter);
        if (newFilters.isEmpty) {
          newFilters.add(UnitFilter.all);
        }
      } else {
        newFilters.add(filter);
      }
    }

    state = state.copyWith(activeFilters: newFilters);
  }

  void reserveUnit(SharedKhatmaUnit unit) {
    final updatedUnits = state.khatma.units.map((u) {
      if (u.unitNumber == unit.unitNumber) {
        return u.copyWith(
          status: UnitStatus.selected,
        );
      }
      return u;
    }).toList();

    // Add the unit if it doesn't exist
    if (!updatedUnits.any((u) => u.unitNumber == unit.unitNumber)) {
      updatedUnits.add(SharedKhatmaUnit(
        unitNumber: unit.unitNumber,
        status: UnitStatus.selected,
        reservedByUserId: 'currentUser',
        reservedByUserName: 'You',
        reservedDate: DateTime.now(),
      ));
    }

    state = state.copyWith(
      khatma: state.khatma.copyWith(units: updatedUnits),
    );
  }

  void unreserveUnit(SharedKhatmaUnit unit) {
    final updatedUnits = state.khatma.units
        .where((u) => u.unitNumber != unit.unitNumber)
        .toList();

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
final khatmaDetailsControllerProvider = StateNotifierProvider.family<
    KhatmaDetailsController, KhatmaDetailsState, SharedKhatma>(
  (ref, khatma) => KhatmaDetailsController(khatma),
);
