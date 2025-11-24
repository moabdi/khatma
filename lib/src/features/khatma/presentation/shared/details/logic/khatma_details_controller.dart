import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';

class KhatmaDetailsState {
  final KhatmaShared khatma;
  final Set<UnitFilter> activeFilters;
  final bool isJoining;

  KhatmaDetailsState({
    required this.khatma,
    required this.activeFilters,
    this.isJoining = false,
  });

  KhatmaDetailsState copyWith({
    KhatmaShared? khatma,
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
  KhatmaDetailsController(KhatmaShared khatma)
      : super(KhatmaDetailsState(
          khatma: khatma,
          activeFilters: _getDefaultFilters(khatma),
        ));

  // Default to "mine" filter if user has reserved units, otherwise "all"
  static Set<UnitFilter> _getDefaultFilters(KhatmaShared khatma) {
    final mineCount = khatma.units.where((u) => u.isReserved).length;
    if (mineCount > 0) {
      return {UnitFilter.mine};
    }
    return {UnitFilter.all};
  }

  void toggleFilter(UnitFilter filter) {
    // Only one filter can be selected at a time
    // Simply replace the current filter with the new one
    state = state.copyWith(activeFilters: {filter});
  }

  void reserveUnit(Unit unit) {
    final updatedUnits = state.khatma.units.map((u) {
      if (u.number == unit.number) {
        return u.copyWith(
          status: UnitStatus.selected,
        );
      }
      return u;
    }).toList();

    // Add the unit if it doesn't exist
    if (!updatedUnits.any((u) => u.number == unit.number)) {
      updatedUnits.add(Unit(
        number: unit.number,
        status: UnitStatus.selected,
        reservedBy: 'currentUser',
        reservedByName: 'You',
        reservedDate: DateTime.now(),
      ));
    }

    state = state.copyWith(
      khatma: state.khatma.copyWith(units: updatedUnits),
    );
  }

  void unreserveUnit(Unit unit) {
    final updatedUnits = state.khatma.units
        .where((u) => u.number != unit.number)
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
// Use autoDispose to keep state alive during the screen session
// Key by khatma ID instead of entire khatma object to prevent recreating controller
final khatmaDetailsControllerProvider = StateNotifierProvider.family.autoDispose<
    KhatmaDetailsController, KhatmaDetailsState, String>(
  (ref, khatmaId) {
    // Get the khatma from the manager
    final manager = ref.watch(khatmaManagerProvider.notifier);
    final khatma = manager.getKhatmaById(khatmaId) as KhatmaShared?;

    if (khatma == null) {
      throw StateError('Khatma with id $khatmaId not found');
    }

    return KhatmaDetailsController(khatma);
  },
);
