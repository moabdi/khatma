import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/presentation/shared/application/shared_khatma_provider.dart';
import 'package:khatma/src/features/khatma/presentation/shared/presentation/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/presentation/details/widgets/progress_stats.dart';
import 'package:khatma/src/features/khatma/presentation/shared/presentation/details/widgets/unit_tile.dart';
import 'package:khatma/src/features/khatma/presentation/shared/presentation/search/widgets/filter_chip.dart';
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
  final GlobalKey _filterButtonKey = GlobalKey();

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
    final state = ref.watch(khatmaDetailsControllerProvider(khatma));
    final controller =
        ref.read(khatmaDetailsControllerProvider(khatma).notifier);

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

                        // Section title
                        Text(
                          context.loc.khatmaUnitsWithType(state.khatma.unit.name),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
          // More filters button
          IconButton.filledTonal(
            key: _filterButtonKey,
            onPressed: () => _showMoreFilters(state, controller),
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
                        color: context.colorScheme.primary,
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
    // Count currently selected units
    final selectedUnitsCount = state.khatma.units
        .where((unit) => unit.status == UnitStatus.selected)
        .length;

    // Count already reserved units + currently selected units
    final alreadyReservedCount = state.khatma.userReservedUnits("").length;
    final totalReservations = alreadyReservedCount + selectedUnitsCount;
    final maxReservations = state.khatma.maxReservationsPerUser;

    // Check if button should be enabled
    final hasSelection = selectedUnitsCount > 0;
    final canConfirm = hasSelection && !state.isJoining;

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
            // Reservation info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$selectedUnitsCount / $maxReservations max',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (totalReservations < maxReservations)
                  Text(
                    context.loc.unitsRemaining(maxReservations - totalReservations),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.green.shade600,
                    ),
                  )
                else
                  Text(
                    context.loc.limitReached,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.orange.shade600,
                    ),
                  ),
              ],
            ),
            gapH12,
            // Confirm button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: canConfirm
                    ? () => _confirmJoin(state, khatma.name)
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
                    : const Icon(Icons.check_circle),
                label: Text(
                  state.isJoining
                      ? context.loc.loading
                      : '${context.loc.confirmJoinKhatma} ($selectedUnitsCount)',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: khatma.style.hexColor,
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

  // === Event Handlers ===

  void _toggleUnitReservation(
    Unit unit,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    if (unit.isFree) {
      // Count already reserved units + currently selected units
      final alreadyReservedCount = state.khatma.userReservedUnits("").length;
      final currentlySelectedCount = state.khatma.units
          .where((u) => u.status == UnitStatus.selected)
          .length;
      final totalReservations = alreadyReservedCount + currentlySelectedCount;

      // Check reservation limit (including already selected units)
      if (totalReservations >= state.khatma.maxReservationsPerUser) {
        _showSnackBar(
          context.loc.reservationLimitReached(
            state.khatma.maxReservationsPerUser,
          ),
          isError: true,
        );
        return;
      }
      controller.reserveUnit(unit);
    } else if (unit.isReserved || unit.isSelected) {
      controller.unreserveUnit(unit);
    }
  }

  Future<void> _confirmJoin(
    KhatmaDetailsState state,
    String khatmaName,
  ) async {
    try {
      // Get the selected unit numbers
      final selectedUnits = state.khatma.units
          .where((unit) => unit.status == UnitStatus.selected)
          .map((unit) => unit.number)
          .toList();

      if (selectedUnits.isEmpty) {
        _showSnackBar(
          'Please select at least one unit to reserve',
          isError: true,
        );
        return;
      }

      // Call the provider to join khatma with selected units
      await ref
          .read(sharedKhatmasProvider.notifier)
          .joinKhatma(widget.khatmaId, selectedUnits);

      if (mounted) {
        _showSnackBar(context.loc.joinedKhatmaSuccess(khatmaName));
        context.goNamed(AppRoute.home.name);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(
          '${context.loc.errorJoiningKhatma}: ${e.toString()}',
          isError: true,
        );
      }
    }
  }

  void _showMoreFilters(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
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
        _buildFilterMenuItem(
          UnitFilter.reserved,
          context.loc.filterReserved,
          state,
          controller,
        ),
        _buildFilterMenuItem(
          UnitFilter.completed,
          context.loc.filterCompleted,
          state,
          controller,
        ),
      ],
    );
  }

  PopupMenuItem<void> _buildFilterMenuItem(
    UnitFilter filter,
    String label,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    final count = state.getFilterCount(filter);
    final isEnabled = count > 0;
    final isSelected = state.activeFilters.contains(filter);

    return PopupMenuItem<void>(
      enabled: isEnabled,
      onTap: isEnabled ? () => controller.toggleFilter(filter) : null,
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: isEnabled
                ? (value) => controller.toggleFilter(filter)
                : null,
          ),
          gapW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium,
                ),
                Text(
                  '$count ${context.loc.unitsLowercase}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // === Helper Methods ===

  bool _isUserAdminOrCreator(KhatmaDetailsState state) {
    // TODO: Implement actual user role check
    return false;
  }

  Future<void> _sendReminder(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      // TODO: Implement reminder logic
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
      // TODO: Implement free unit logic
      if (mounted) {
        _showSnackBar(context.loc.unitFreedSuccess);
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
}
