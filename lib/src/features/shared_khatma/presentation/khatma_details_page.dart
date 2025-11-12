import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/features/shared_khatma/presentation/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/filter_chip.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/unit_tile.dart';
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
  final SharedKhatma khatma;

  const KhatmaDetailsPage({
    super.key,
    required this.khatma,
  });

  @override
  ConsumerState<KhatmaDetailsPage> createState() => _KhatmaDetailsPageState();
}

class _KhatmaDetailsPageState extends ConsumerState<KhatmaDetailsPage> {
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
                  if (state.khatma.description.isNotEmpty)
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        childrenPadding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        tilePadding: const EdgeInsets.all(0),
                        title: Text(context.loc.khatmaDescription),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(state.khatma.description),
                          ),
                        ],
                      ),
                    ),
                  gapH12,
            // Statistics Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Members Progress Card with taken units percentage
                _ProgressStatCardWithCount(
                  icon: Icons.people_rounded,
                  label: context.loc.members,
                  count: state.khatma.membersCount.toString(),
                  percent: (state.khatma.reservedUnits.length +
                           state.khatma.units.where((u) => u.isCompleted).length) /
                           state.khatma.totalUnits,
                  color: context.colorScheme.primary,
                ),
                // Free Units Progress Card with circular progress
                _ProgressStatCard(
                  label: context.loc.freeUnits,
                  percent: state.khatma.unitsAvailable / state.khatma.totalUnits,
                  color: context.colorScheme.secondary,
                ),
                // Completion Progress Card with circular progress
                _ProgressStatCard(
                  label: context.loc.completed,
                  percent: state.khatma.completionPercent,
                  color: context.colorScheme.tertiary,
                ),
              ],
            ),
            gapH16,

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
                      state.khatma.unit.displayName)),
                  gapH8,
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        KhatmaFilterChip(
                          label: context.loc.filterAll,
                          icon: Icons.apps_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.all),
                          count: state.getFilterCount(UnitFilter.all),
                          onTap: () => controller.toggleFilter(UnitFilter.all),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: context.loc.filterMyUnits,
                          icon: Icons.person_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.mine),
                          count: state.getFilterCount(UnitFilter.mine),
                          isEnabled: state.getFilterCount(UnitFilter.mine) > 0,
                          onTap: () => controller.toggleFilter(UnitFilter.mine),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: context.loc.filterAvailable,
                          icon: Icons.check_circle_outline_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.free),
                          count: state.getFilterCount(UnitFilter.free),
                          isEnabled: state.getFilterCount(UnitFilter.free) > 0,
                          onTap: () => controller.toggleFilter(UnitFilter.free),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: context.loc.filterReserved,
                          icon: Icons.lock_clock_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.reserved),
                          count: state.getFilterCount(UnitFilter.reserved),
                          isEnabled: state.getFilterCount(UnitFilter.reserved) > 0,
                          onTap: () => controller.toggleFilter(UnitFilter.reserved),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: context.loc.filterCompleted,
                          icon: Icons.done_all_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.completed),
                          count: state.getFilterCount(UnitFilter.completed),
                          isEnabled: state.getFilterCount(UnitFilter.completed) > 0,
                          onTap: () =>
                              controller.toggleFilter(UnitFilter.completed),
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
                              final unitNumber = index + 1;
                              final unit = state.khatma.units.firstWhere(
                                (u) => u.unitNumber == unitNumber,
                                orElse: () =>
                                    SharedKhatmaUnit(unitNumber: unitNumber),
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
                            state.khatma.userReservedUnits.length,
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
                        if (state.khatma.remainingReservations > 0)
                          Text(
                            context.loc.unitsRemaining(
                                state.khatma.remainingReservations),
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
    SharedKhatmaUnit unit,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    if (unit.isFree) {
      // Check if limit reached before attempting reservation
      if (!state.khatma.canUserReserveMore) {
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
    } else if (unit.isReservedByCurrentUser || unit.isSelected) {
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
    SharedKhatmaUnit unit,
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
    SharedKhatmaUnit unit,
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
}

/// Progress stat card with count, icon and circular progress indicator
class _ProgressStatCardWithCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final double percent;
  final Color color;

  const _ProgressStatCardWithCount({
    required this.icon,
    required this.label,
    required this.count,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular progress indicator with icon and count
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: percent.clamp(0.0, 1.0),
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Icon and count
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 14,
                  ),
                  Text(
                    count,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        gapH4,
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Progress stat card widget with circular progress indicator
class _ProgressStatCard extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;

  const _ProgressStatCard({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular progress indicator
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: percent.clamp(0.0, 1.0),
                  strokeWidth: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Percentage text
              Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
              ),
            ],
          ),
        ),
        gapH4,
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
