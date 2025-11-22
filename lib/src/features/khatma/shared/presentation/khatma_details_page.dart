import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/shared/presentation/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/shared/presentation/ui/widgets/unit_tile.dart';
import 'package:khatma/src/features/khatma/shared/presentation/ui/widgets/progress_stats.dart';
import 'package:khatma/src/features/khatma/shared/presentation/widgets/filter_chip.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

enum UnitFilter {
  all,
  mine,
  reserved,
  free,
  completed,
}

class KhatmaDetailsPage extends ConsumerStatefulWidget {
  final KhatmaShared khatma;

  const KhatmaDetailsPage({
    super.key,
    required this.khatma,
  });

  @override
  ConsumerState<KhatmaDetailsPage> createState() => _KhatmaDetailsPageState();
}

class _KhatmaDetailsPageState extends ConsumerState<KhatmaDetailsPage> {
  final GlobalKey _filterButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(khatmaDetailsControllerProvider(widget.khatma));
    final controller =
        ref.read(khatmaDetailsControllerProvider(widget.khatma).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.khatma.name),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

                  // Description in ExpansionTile
                  if (state.khatma.description?.isNotEmpty ?? false) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.only(top: 12),
                          title: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                context.loc.khatmaDescription,
                                style: context.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.khatma.description ?? '',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapH16,
                  ],
            // Statistics Cards
            KhatmaProgressStats(khatma: state.khatma),
            gapH20,

            // Khatma Overview
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .shadow
                        .withValues(alpha: 0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(context.loc.khatmaUnitsWithType(
                      state.khatma.unit.name)),
                  gapH12,
                  // Filter chips
                  SingleChildScrollView(
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
                        // Filter menu button
                        IconButton.filledTonal(
                          key: _filterButtonKey,
                          onPressed: () => _showFilterMenu(context, state, controller),
                          icon: Stack(
                            children: [
                              const Icon(Icons.tune_rounded, size: 20),
                              if (state.activeFilters.contains(UnitFilter.reserved) ||
                                  state.activeFilters.contains(UnitFilter.completed))
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          tooltip: context.loc.filterUnits,
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH16,
                ],
              ),
            ),

            // Units Grid
            Expanded(
              child: !state.hasVisibleUnits
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                                  .withValues(alpha: 0.5),
                            ),
                            gapH16,
                            Text(
                              context.loc.noUnitsFound,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            gapH8,
                            Text(
                              context.loc.tryChangingFilter,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant
                                        .withValues(alpha: 0.7),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.khatma.totalUnits,
                            itemBuilder: (context, index) {
                              final number = index + 1;
                              final unit = state.khatma.units.firstWhere(
                                (u) => u.number == number,
                                orElse: () =>
                                    Unit(number: number),
                              );

                              // Apply filter
                              if (!state.shouldShowUnit(unit)) {
                                return const SizedBox.shrink();
                              }

                              return UnitTile(
                                unit: unit,
                                onTap: () => _toggleUnitReservation(
                                    unit, state, controller),
                                reservationWarningDays: 7, // TODO: Use state.khatma.reservationWarningDays after regenerating Freezed
                                isUserAdminOrCreator: _isUserAdminOrCreator(state),
                                onSendReminder: () => _sendReminder(unit, controller),
                                onFreeUnit: () => _freeUnit(unit, controller),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),

            // Join/Confirm Button
            if (state.hasSelectedUnits)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Reservation info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.loc.reservedUnitsCount(
                            state.khatma.userReservedUnits("").length,
                            state.khatma.maxReservationsPerUser,
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        if (state.khatma.remainingReservations("") > 0)
                          Text(
                            context.loc.unitsRemaining(
                                state.khatma.remainingReservations("ss")),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.green.shade600,
                                    ),
                          )
                        else
                          Text(
                            context.loc.limitReached,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.orange.shade600,
                                    ),
                          ),
                      ],
                    ),
                    gapH12,
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: !state.isJoining
                            ? () => _confirmJoin(controller)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state.isJoining
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                context.loc.confirmJoinKhatma,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _toggleUnitReservation(
    Unit unit,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    if (unit.isFree) {
      // Check if limit reached before attempting reservation
      if (!state.khatma.canUserReserveMore("")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                context.loc.reservationLimitReached(
                    state.khatma.maxReservationsPerUser)),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
      controller.reserveUnit(unit);
    } else if (unit.isReserved || unit.isSelected) {
      controller.unreserveUnit(unit);
    }
  }

  Future<void> _confirmJoin(KhatmaDetailsController controller) async {
    try {
      await controller.confirmJoin();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                context.loc
                    .joinedKhatmaSuccess(widget.khatma.name)),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        // Navigate back or to a success page
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.errorJoiningKhatma),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Check if current user is admin or creator
  bool _isUserAdminOrCreator(KhatmaDetailsState state) {
    // TODO: Implement actual user role check
    // For now, return false - you'll need to add currentUserId to the state
    // and check if it matches creatorId or if user has admin role
    return false;
  }

  // Send reminder to the user who reserved the unit
  Future<void> _sendReminder(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      // TODO: Implement reminder sending logic
      // This should call a method in the controller to send a notification
      // await controller.sendReminderForUnit(unit);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.reminderSentSuccess),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending reminder: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Free an overdue unit (admin action)
  Future<void> _freeUnit(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      // TODO: Implement unit freeing logic
      // This should call a method in the controller to free the unit
      // await controller.freeUnit(unit);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.unitFreedSuccess),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error freeing unit: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Show filter menu popup under the button
  void _showFilterMenu(
    BuildContext context,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    // Get the button position
    final RenderBox? renderBox =
        _filterButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    final buttonSize = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy + buttonSize.height,
        buttonPosition.dx + buttonSize.width,
        0,
      ),
      items: [
        // Reserved filter
        PopupMenuItem<void>(
          enabled: state.getFilterCount(UnitFilter.reserved) > 0,
          onTap: () => controller.toggleFilter(UnitFilter.reserved),
          child: StatefulBuilder(
            builder: (context, setState) => Row(
              children: [
                Checkbox(
                  value: state.activeFilters.contains(UnitFilter.reserved),
                  onChanged: state.getFilterCount(UnitFilter.reserved) > 0
                      ? (value) {
                          controller.toggleFilter(UnitFilter.reserved);
                        }
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.loc.filterReserved,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${state.getFilterCount(UnitFilter.reserved)} ${context.loc.unitsLowercase}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Completed filter
        PopupMenuItem<void>(
          enabled: state.getFilterCount(UnitFilter.completed) > 0,
          onTap: () => controller.toggleFilter(UnitFilter.completed),
          child: StatefulBuilder(
            builder: (context, setState) => Row(
              children: [
                Checkbox(
                  value: state.activeFilters.contains(UnitFilter.completed),
                  onChanged: state.getFilterCount(UnitFilter.completed) > 0
                      ? (value) {
                          controller.toggleFilter(UnitFilter.completed);
                        }
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.loc.filterCompleted,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${state.getFilterCount(UnitFilter.completed)} ${context.loc.unitsLowercase}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
