import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/shared/presentation/khatma_details_page.dart';
import 'package:khatma/src/features/khatma/shared/presentation/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/shared/presentation/ui/widgets/unit_tile.dart';
import 'package:khatma/src/features/khatma/shared/presentation/ui/widgets/progress_stats.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Improved shared khatma details screen with modern design
///
/// Features:
/// - Clean header with circular avatar and progress
/// - Progress statistics cards
/// - Filter chips for unit filtering
/// - Improved unit tiles
/// - Reservation and completion features
class SharedKhatmaScreen extends ConsumerStatefulWidget {
  const SharedKhatmaScreen({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<SharedKhatmaScreen> createState() =>
      _ImprovedSharedKhatmaScreenState();
}

class _ImprovedSharedKhatmaScreenState
    extends ConsumerState<SharedKhatmaScreen> {
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
              Icons.edit_outlined,
              color: khatma.style.hexColor,
            ),
            onPressed: () {
              context.go('/khatma/shared/${khatma.id!}/edit');
            },
          ),
          gapW8,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with circular avatar
                  // KhatmaDetailsHeader(khatma: state.khatma),
                  gapH16,

                  // Description
                  if (state.khatma.description?.isNotEmpty ?? false) ...[
                    _buildDescription(context, state.khatma),
                    gapH16,
                  ],

                  // Progress statistics cards
                  KhatmaProgressStats(khatma: state.khatma),
                  gapH20,

                  // Section title
                  Text(
                    context.loc.khatmaUnits,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapH12,

                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          context,
                          UnitFilter.all,
                          state,
                          controller,
                        ),
                        gapW8,
                        _buildFilterChip(
                          context,
                          UnitFilter.mine,
                          state,
                          controller,
                        ),
                        gapW8,
                        _buildFilterChip(
                          context,
                          UnitFilter.free,
                          state,
                          controller,
                        ),
                        gapW8,
                        _buildFilterChip(
                          context,
                          UnitFilter.reserved,
                          state,
                          controller,
                        ),
                        gapW8,
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.khatma.totalUnits,
                    itemBuilder: (context, index) {
                      final unitNumber = index + 1;
                      final existingUnit = state.khatma.units.firstWhere(
                        (u) => u.number == unitNumber,
                        orElse: () =>
                            Unit(number: unitNumber, status: UnitStatus.free),
                      );

                      if (!state.shouldShowUnit(existingUnit)) {
                        return const SizedBox.shrink();
                      }

                      return UnitTile(
                        unit: existingUnit,
                        onTap: () =>
                            _toggleUnitSelection(existingUnit, controller),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom action button
          if (selectedUnits.isNotEmpty)
            Container(
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
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: state.isJoining
                        ? null
                        : () => _handleConfirm(controller, khatma.name),
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
                          : '${context.loc.confirmReading} (${selectedUnits.length})',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: khatma.style.hexColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, KhatmaShared khatma) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          gapH8,
          Text(
            khatma.description ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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
      showCheckmark: false,
      selectedColor: context.colorScheme.primaryContainer,
      side: BorderSide(
        color: isSelected
            ? context.colorScheme.primary
            : context.colorScheme.outlineVariant,
        width: isSelected ? 1.5 : 1,
      ),
    );
  }

  String _getFilterLabel(BuildContext context, UnitFilter filter) {
    switch (filter) {
      case UnitFilter.all:
        return context.loc.khatmaStatus;
      case UnitFilter.mine:
        return 'Mine';
      case UnitFilter.reserved:
        return context.loc.reserved;
      case UnitFilter.free:
        return 'Free';
      case UnitFilter.completed:
        return context.loc.completed;
    }
  }

  void _toggleUnitSelection(Unit unit, KhatmaDetailsController controller) {
    if (unit.status == UnitStatus.selected) {
      controller.unreserveUnit(unit);
    } else if (unit.isFree) {
      controller.reserveUnit(unit);
    }
  }

  Future<void> _handleConfirm(
      KhatmaDetailsController controller, String khatmaName) async {
    try {
      await controller.confirmJoin();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.loc.khatmaJoinSuccess(khatmaName),
            ),
            backgroundColor: context.colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.khatmaJoinError),
            backgroundColor: context.colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
