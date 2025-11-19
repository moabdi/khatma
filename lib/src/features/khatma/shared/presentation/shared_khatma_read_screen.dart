import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/shared/presentation/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/shared/presentation/widgets/unit_tile.dart';
import 'package:khatma/src/features/khatma/shared/presentation/khatma_details_page.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

class SharedKhatmaReadScreen extends ConsumerStatefulWidget {
  const SharedKhatmaReadScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  ConsumerState<SharedKhatmaReadScreen> createState() =>
      _SharedKhatmaReadScreenState();
}

class _SharedKhatmaReadScreenState
    extends ConsumerState<SharedKhatmaReadScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the shared khatma from the provider
    Khatma? khatma = ref.watch(khatmaNotifierProvider).selectedKhatma;

    // If no selected khatma, try to find it by ID
    if (khatma == null || khatma.id != widget.khatmaId) {
      khatma = ref
          .watch(khatmaNotifierProvider.notifier)
          .getKhatmaById(widget.khatmaId);
      // Update the selected khatma if found
      if (khatma != null) {
        ref.read(khatmaNotifierProvider.notifier).selectKhatma(khatma);
      }
    }

    // Handle different khatma states
    if (khatma == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.khatma)),
        body: const EmptyPlaceholderWidget(message: 'Khatma not found'),
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

    return _buildContent(khatma, context);
  }

  Widget _buildContent(KhatmaShared khatma, BuildContext context) {
    final state = ref.watch(khatmaDetailsControllerProvider(khatma));
    final controller =
        ref.read(khatmaDetailsControllerProvider(khatma).notifier);

    // Get selected units from the state
    final selectedUnits = state.khatma.units
        .where((unit) => unit.status == UnitStatus.selected)
        .map((unit) => unit.number)
        .toList();

    final khatmaName = khatma.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(khatma.name),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/khatma'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: khatma.style.color.toColor(),
            ),
            onPressed: () {
              context.go('/khatma/shared/${khatma.id!}/edit');
            },
          ),
          gapW16,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Description
            if (state.khatma.description?.isNotEmpty ?? false)
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  tilePadding: const EdgeInsets.all(0),
                  title: Text(context.loc.khatmaDescription),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(state.khatma.description ?? ''),
                    ),
                  ],
                ),
              ),
            gapH12,

            // Statistics Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProgressStatCardWithCount(
                  icon: Icons.people_rounded,
                  label: context.loc.members,
                  count: state.khatma.membersCount.toString(),
                  percent: _calculateTakenUnitsPercent(state.khatma),
                  color: context.colorScheme.primary,
                ),
                _ProgressStatCard(
                  label: context.loc.freeUnits,
                  percent: _calculateFreeUnitsPercent(state.khatma),
                  color: context.colorScheme.secondary,
                ),
                _ProgressStatCard(
                  label: context.loc.completed,
                  percent: state.khatma.completionPercent,
                  color: context.colorScheme.tertiary,
                ),
              ],
            ),
            gapH16,

            // Filter chips - show all filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // All filter
                  _buildFilterChip(
                    context,
                    UnitFilter.all,
                    state,
                    controller,
                  ),
                  gapW8,
                  // Mine filter
                  _buildFilterChip(
                    context,
                    UnitFilter.mine,
                    state,
                    controller,
                  ),
                  gapW8,
                  // Free filter
                  _buildFilterChip(
                    context,
                    UnitFilter.free,
                    state,
                    controller,
                  ),
                  gapW8,
                  // Reserved filter
                  _buildFilterChip(
                    context,
                    UnitFilter.reserved,
                    state,
                    controller,
                  ),
                  gapW8,
                  // Completed filter
                  _buildFilterChip(
                    context,
                    UnitFilter.completed,
                    state,
                    controller,
                  ),
                ],
              ),
            ),
            gapH16,

            // Units list
            Expanded(
              child: ListView.builder(
                // Display all possible units (1 to totalUnits)
                itemCount: state.khatma.totalUnits,
                itemBuilder: (context, index) {
                  final unitNumber = index + 1;
                  // Find existing unit or create a free one
                  final existingUnit = state.khatma.units.firstWhere(
                    (u) => u.number == unitNumber,
                    orElse: () => Unit(number: unitNumber, status: UnitStatus.free),
                  );

                  if (!state.shouldShowUnit(existingUnit)) {
                    return const SizedBox.shrink();
                  }
                  return UnitTile(
                    unit: existingUnit,
                    onTap: () => _toggleUnitSelection(existingUnit, controller),
                  );
                },
              ),
            ),

            // Bottom action button
            if (selectedUnits.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isJoining
                        ? null
                        : () => _handleConfirm(controller, khatmaName),
                    child: state.isJoining
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            '${context.loc.confirmReading} (${selectedUnits.length})',
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    UnitFilter filter,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    final isSelected = state.activeFilters.contains(filter);
    final count = state.getFilterCount(filter);
    final label = _getFilterLabel(context, filter);

    return FilterChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (_) => controller.toggleFilter(filter),
    );
  }

  String _getFilterLabel(BuildContext context, UnitFilter filter) {
    switch (filter) {
      case UnitFilter.all:
        return context.loc.khatmaStatus; // Use existing string
      case UnitFilter.mine:
        return 'Mine'; // Fallback - add to localizations
      case UnitFilter.reserved:
        return context.loc.reserved;
      case UnitFilter.free:
        return 'Free'; // Fallback - add to localizations
      case UnitFilter.completed:
        return context.loc.completed;
    }
  }

  double _calculateTakenUnitsPercent(KhatmaShared khatma) {
    // Calculate taken units: reserved + completed (NOT selected - they're not reserved yet)
    final reservedCount = khatma.units.where((u) => u.status == UnitStatus.reserved).length;
    final completedCount = khatma.units.where((u) => u.status == UnitStatus.completed).length;
    final takenCount = reservedCount + completedCount;
    return (takenCount / khatma.totalUnits).clamp(0.0, 1.0);
  }

  double _calculateFreeUnitsPercent(KhatmaShared khatma) {
    // Calculate free units: total - (reserved + completed)
    // Note: selected units are still counted as free until confirmed
    final reservedCount = khatma.units.where((u) => u.status == UnitStatus.reserved).length;
    final completedCount = khatma.units.where((u) => u.status == UnitStatus.completed).length;
    final freeCount = khatma.totalUnits - reservedCount - completedCount;
    return (freeCount / khatma.totalUnits).clamp(0.0, 1.0);
  }

  void _toggleUnitSelection(Unit unit, KhatmaDetailsController controller) {
    if (unit.status == UnitStatus.selected) {
      controller.unreserveUnit(unit);
    } else if (unit.isFree) {
      controller.reserveUnit(unit);
    }
  }

  Future<void> _handleConfirm(KhatmaDetailsController controller, String khatmaName) async {
    try {
      await controller.confirmJoin();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.loc.khatmaJoinSuccess(khatmaName),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.loc.khatmaJoinError)),
        );
      }
    }
  }
}

// Progress card with count (circular indicator)
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

// Progress card without count (circular indicator)
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
