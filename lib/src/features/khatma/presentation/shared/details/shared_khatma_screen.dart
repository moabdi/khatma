import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/progress_stats.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/unit_tile.dart';
import 'package:khatma/src/features/khatma/presentation/shared/search/widgets/filter_chip.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Filter options for displaying units
enum UnitFilter {
  all,
  mine,
  reserved,
  free,
  completed,
}

/// Shared khatma details screen with modern design
///
/// Displays:
/// - Description (if available)
/// - Progress statistics
/// - Filterable unit list
/// - Reservation confirmation
class SharedKhatmaScreen extends ConsumerStatefulWidget {
  const SharedKhatmaScreen({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<SharedKhatmaScreen> createState() =>
      _SharedKhatmaScreenState();
}

class _SharedKhatmaScreenState extends ConsumerState<SharedKhatmaScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the shared khatma from the provider
    Khatma? khatma = ref.watch(khatmaManagerProvider).selectedKhatma;

    // If no selected khatma, try to find it by ID
    if (khatma == null || khatma.id != widget.khatmaId) {
      khatma = ref
          .watch(khatmaManagerProvider.notifier)
          .getKhatmaById(widget.khatmaId);
      // Update the selected khatma if found
      if (khatma != null) {
        ref.read(khatmaManagerProvider.notifier).selectKhatma(khatma);
      }
    }

    // Handle different khatma states
    if (khatma == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.khatma)),
        body: EmptyPlaceholderWidget(message: context.loc.khatmaNotFound),
      );
    }

    // Only show content for shared khatmas
    if (khatma is! KhatmaShared) {
      return Scaffold(
        appBar: AppBar(title: Text(khatma.name)),
        body: const EmptyPlaceholderWidget(
          message: 'This khatma type is not supported in this view',
        ),
      );
    }

    return _buildContent(khatma);
  }

  Widget _buildContent(KhatmaShared khatma) {
    final state = ref.watch(khatmaDetailsControllerProvider(khatma.id!));
    final controller =
        ref.read(khatmaDetailsControllerProvider(khatma.id!).notifier);

    return Scaffold(
      appBar: _buildAppBar(khatma),
      body: Column(
        children: [
          Expanded(
            child: !state.hasVisibleUnits
                ? _buildEmptyState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description section
                        if (state.khatma.description?.isNotEmpty ?? false) ...[
                          _buildDescription(state.khatma),
                          gapH16,
                        ],

                        // Progress statistics
                        KhatmaProgressStats(khatma: state.khatma),
                        gapH20,

                        // Section title with clear selection button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.khatmaUnitsWithType(state.khatma.unit.name),
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Clear selection button (only visible when units are selected)
                            if (state.hasSelectedUnits)
                              TextButton.icon(
                                onPressed: () => controller.clearSelection(),
                                icon: const Icon(Icons.clear_all, size: 18),
                                label: Text(context.loc.clearSelection),
                                style: TextButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                          ],
                        ),
                        gapH12,

                        // Filter chips
                        _buildFilterChips(state, controller),
                        gapH16,

                        // Units list
                        _buildUnitsList(state, controller),
                      ],
                    ),
                  ),
          ),

          // Bottom action button - always show but disabled if no selection
          _buildBottomActionButton(state, controller, khatma),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(KhatmaShared khatma) {
    return AppBar(
      title: Text(khatma.name),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.go('/khatma'),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: khatma.style.hexColor,
          ),
          onPressed: () => context.go('/khatma/shared/${khatma.id!}/edit'),
        ),
        gapW8,
      ],
    );
  }

  Widget _buildDescription(KhatmaShared khatma) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
              gapW8,
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
                khatma.description ?? '',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
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

  Widget _buildUnitsList(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
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
          onTap: () => _toggleUnitReservation(unit, state, controller),
          reservationWarningDays: 7,
          isUserAdminOrCreator: _isUserAdminOrCreator(state),
          isOwnedByCurrentUser: _isOwnedByCurrentUser(unit, state),
          onSendReminder: () => _sendReminder(unit, controller),
          onFreeUnit: () => _freeUnit(unit, controller),
          color: state.khatma.color,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            gapH16,
            Text(
              context.loc.noUnitsFound,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            gapH8,
            Text(
              context.loc.tryChangingFilter,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionButton(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
    KhatmaShared khatma,
  ) {
    final selectedUnitsCount = state.selectedUnits.length;
    final hasSelection = selectedUnitsCount > 0;
    final canConfirm = hasSelection && !state.isJoining;

    // Determine button text and action based on user state and selection
    final buttonInfo = _getButtonInfo(state);

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
                      color: buttonInfo.isWarning ? Colors.orange.shade600 : Colors.green.shade600,
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
                    ? () => _performAction(state, controller, khatma.name, buttonInfo.action)
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

  _ButtonInfo _getButtonInfo(KhatmaDetailsState state) {
    final selectedCount = state.selectedUnits.length;
    final isParticipant = state.isUserParticipant;
    final areReservedUnitsSelected = state.areAllSelectedUnitsReserved;
    final currentReserved = state.currentUserReservedCount;
    final maxReservations = state.maxReservationsPerUser;

    if (!isParticipant && selectedCount == 0) {
      // User not in khatma, no selection
      return _ButtonInfo(
        buttonText: context.loc.joinKhatma,
        subtitle: context.loc.selectUnitsToJoin,
        icon: Icons.group_add,
        action: _ActionType.join,
      );
    }

    if (!isParticipant && selectedCount > 0) {
      // User not in khatma, has selection
      return _ButtonInfo(
        buttonText: context.loc.reserveAndJoin(selectedCount),
        subtitle: context.loc.unitsSelectedMax(selectedCount, maxReservations),
        hint: context.loc.willJoinKhatma,
        icon: Icons.group_add,
        action: _ActionType.reserveAndJoin,
      );
    }

    if (isParticipant && areReservedUnitsSelected) {
      // User in khatma, selected their own reserved units
      return _ButtonInfo(
        buttonText: context.loc.unreserveUnits(selectedCount),
        subtitle: context.loc.unitsSelected(selectedCount),
        hint: context.loc.willFreeUnits,
        icon: Icons.lock_open,
        color: Colors.orange.shade700,
        isWarning: true,
        action: _ActionType.unreserve,
      );
    }

    // User in khatma, selecting free units
    final remaining = maxReservations - currentReserved;
    return _ButtonInfo(
      buttonText: context.loc.reserveUnitsAction(selectedCount),
      subtitle: context.loc.reservedSelectedInfo(currentReserved, maxReservations, selectedCount),
      hint: remaining == selectedCount ? null : context.loc.unitsRemaining(remaining),
      icon: Icons.check_circle,
      action: _ActionType.reserve,
    );
  }

  // === Event Handlers ===

  void _toggleUnitReservation(
    Unit unit,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    // Use the new validation logic
    final error = controller.toggleUnitSelection(unit);

    if (error != null) {
      _showSnackBar(error, isError: true);
    }
  }

  // === Helper Methods ===

  bool _isUserAdminOrCreator(KhatmaDetailsState state) {
    return state.isUserAdminOrCreator;
  }

  bool _isOwnedByCurrentUser(Unit unit, KhatmaDetailsState state) {
    if (state.currentUserId == null) return false;
    return unit.reservedBy == state.currentUserId;
  }

  Future<void> _sendReminder(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      // TODO: Implement actual reminder notification system (push notification/email)
      // For now, this is a placeholder that simulates sending a reminder
      // In a real implementation, this would:
      // 1. Send a push notification to the user who reserved the unit
      // 2. Or send an email reminder
      // 3. Update the lastReminderSent timestamp
      // 4. Increment the reminderCount

      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call

      if (mounted) {
        _showSnackBar(context.loc.reminderSentSuccess);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error sending reminder: $e', isError: true);
      }
    }
  }

  Future<void> _freeUnit(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      final currentUser = ref.read(userProvider);
      if (currentUser == null) {
        if (mounted) {
          _showSnackBar(context.loc.userNotLoggedIn, isError: true);
        }
        return;
      }

      final result = await ref
          .read(khatmaManagerProvider.notifier)
          .releaseUnit(
            khatmaId: widget.khatmaId,
            unitNumber: unit.number,
            userId: currentUser.id,
          );

      if (mounted) {
        if (result.isSuccess) {
          _showSnackBar(context.loc.unitFreedSuccess);
        } else {
          _showSnackBar('Error: ${result.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error freeing unit: $e', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? context.colorScheme.error
            : context.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _performAction(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
    String khatmaName,
    _ActionType actionType,
  ) async {
    try {
      final selectedUnits = state.selectedUnits
          .map((unit) => unit.number)
          .toList();

      if (selectedUnits.isEmpty && actionType != _ActionType.join) {
        _showSnackBar(context.loc.pleaseSelectAtLeastOneUnit, isError: true);
        return;
      }

      switch (actionType) {
        case _ActionType.join:
          // Just join without reserving units
          await ref
              .read(khatmaManagerProvider.notifier)
              .joinKhatma(khatmaId: widget.khatmaId, reservedUnits: []);

          if (mounted) {
            _showSnackBar(context.loc.joinedKhatmaSuccessfully(khatmaName));
            context.goNamed(AppRoute.home.name);
          }
          break;

        case _ActionType.reserveAndJoin:
          // Join and reserve selected units
          await ref
              .read(khatmaManagerProvider.notifier)
              .joinKhatma(khatmaId: widget.khatmaId, reservedUnits: selectedUnits);

          if (mounted) {
            _showSnackBar(context.loc.joinedAndReservedUnits(khatmaName, selectedUnits.length));
          }
          break;

        case _ActionType.reserve:
          // Just reserve units (user already in khatma)
          final currentUser = ref.read(userProvider);
          if (currentUser == null) {
            if (mounted) {
              _showSnackBar(context.loc.userNotLoggedIn, isError: true);
            }
            return;
          }

          final reserveResult = await ref
              .read(khatmaManagerProvider.notifier)
              .reserveUnits(
                khatmaId: widget.khatmaId,
                unitNumbers: selectedUnits,
                userId: currentUser.id,
                userName: currentUser.displayName ?? currentUser.email ?? 'User',
              );

          if (mounted) {
            if (reserveResult.isSuccess) {
              _showSnackBar(context.loc.reservedUnitsSuccess(selectedUnits.length));
              controller.clearSelection();
            } else {
              _showSnackBar('Error: ${reserveResult.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
            }
            // Stay on the same page - don't navigate
          }
          break;

        case _ActionType.unreserve:
          // Unreserve units
          final currentUserForUnreserve = ref.read(userProvider);
          if (currentUserForUnreserve == null) {
            if (mounted) {
              _showSnackBar(context.loc.userNotLoggedIn, isError: true);
            }
            return;
          }

          final unreserveResult = await ref
              .read(khatmaManagerProvider.notifier)
              .releaseUnits(
                khatmaId: widget.khatmaId,
                unitNumbers: selectedUnits,
                userId: currentUserForUnreserve.id,
              );

          if (mounted) {
            if (unreserveResult.isSuccess) {
              _showSnackBar(context.loc.unitFreedSuccess);
              controller.clearSelection();
            } else {
              _showSnackBar('Error: ${unreserveResult.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
            }
            // Stay on the same page - don't navigate
          }
          break;
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error: ${e.toString()}', isError: true);
      }
    }
  }
}

// Helper enum for action types
enum _ActionType {
  join,
  reserveAndJoin,
  reserve,
  unreserve,
}

// Helper class for button information
class _ButtonInfo {
  final String buttonText;
  final String subtitle;
  final String? hint;
  final IconData icon;
  final Color? color;
  final bool isWarning;
  final _ActionType action;

  _ButtonInfo({
    required this.buttonText,
    required this.subtitle,
    this.hint,
    required this.icon,
    this.color,
    this.isWarning = false,
    required this.action,
  });
}
