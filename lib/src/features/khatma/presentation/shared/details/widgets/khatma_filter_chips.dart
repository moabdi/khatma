import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/shared_khatma_screen.dart';
import 'package:khatma/src/features/khatma/presentation/shared/search/widgets/filter_chip.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart' hide KhatmaFilterChip;

class KhatmaFilterChips extends StatelessWidget {
  const KhatmaFilterChips({
    super.key,
    required this.state,
    required this.controller,
  });

  final KhatmaDetailsState state;
  final KhatmaDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          KhatmaFilterChip(
            label: context.loc.filterAll,
            icon: Icons.apps_rounded,
            isSelected: state.activeFilters.contains(UnitFilter.all),
            count: state.getFilterCount(UnitFilter.all),
            onTap: () => controller.toggleFilter(UnitFilter.all),
          ),
          gapW8,
          KhatmaFilterChip(
            label: context.loc.filterMyUnits,
            icon: Icons.person_rounded,
            isSelected: state.activeFilters.contains(UnitFilter.mine),
            count: state.getFilterCount(UnitFilter.mine),
            isEnabled: state.getFilterCount(UnitFilter.mine) > 0,
            onTap: () => controller.toggleFilter(UnitFilter.mine),
          ),
          gapW8,
          KhatmaFilterChip(
            label: context.loc.filterAvailable,
            icon: Icons.check_circle_outline_rounded,
            isSelected: state.activeFilters.contains(UnitFilter.free),
            count: state.getFilterCount(UnitFilter.free),
            isEnabled: state.getFilterCount(UnitFilter.free) > 0,
            onTap: () => controller.toggleFilter(UnitFilter.free),
          ),
          gapW8,
          KhatmaFilterChip(
            label: context.loc.filterReserved,
            icon: Icons.lock_outline,
            isSelected: state.activeFilters.contains(UnitFilter.reserved),
            count: state.getFilterCount(UnitFilter.reserved),
            isEnabled: state.getFilterCount(UnitFilter.reserved) > 0,
            onTap: () => controller.toggleFilter(UnitFilter.reserved),
          ),
          gapW8,
          KhatmaFilterChip(
            label: context.loc.filterCompleted,
            icon: Icons.done_all,
            isSelected: state.activeFilters.contains(UnitFilter.completed),
            count: state.getFilterCount(UnitFilter.completed),
            isEnabled: state.getFilterCount(UnitFilter.completed) > 0,
            onTap: () => controller.toggleFilter(UnitFilter.completed),
          ),
        ],
      ),
    );
  }
}
