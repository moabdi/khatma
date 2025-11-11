import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/features/shared_khatma/presentation/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/filter_chip.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/unit_tile.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

enum UnitFilter {
  all,
  mine,
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
                        title: const Text('Description'),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(state.khatma.description),
                          ),
                        ],
                      ),
                    ),
                  gapH12,
                  // Title
                  Text('Unités (${state.khatma.unit.displayName})'),
                  gapH8,
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        KhatmaFilterChip(
                          label: 'Tout',
                          icon: Icons.apps_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.all),
                          onTap: () => controller.toggleFilter(UnitFilter.all),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: 'Mes unités',
                          icon: Icons.person_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.mine),
                          onTap: () => controller.toggleFilter(UnitFilter.mine),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: 'Disponibles',
                          icon: Icons.check_circle_outline_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.free),
                          onTap: () => controller.toggleFilter(UnitFilter.free),
                        ),
                        gapW8,
                        KhatmaFilterChip(
                          label: 'Complétées',
                          icon: Icons.done_all_rounded,
                          isSelected:
                              state.activeFilters.contains(UnitFilter.completed),
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
                              'Aucune unité trouvée',
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
                              'Essayez de changer le filtre',
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
                          'Réservé: ${state.khatma.userReservedUnits.length}/${state.khatma.maxReservationsPerUser}',
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
                            '${state.khatma.remainingReservations} restantes',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.green.shade600,
                                    ),
                          )
                        else
                          Text(
                            'Limite atteinte',
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
                            : const Text(
                                'Confirmer rejoindre',
                                style: TextStyle(
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
                'Limite atteinte: ${state.khatma.maxReservationsPerUser} unités maximum par utilisateur'),
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
                'Vous avez rejoint "${widget.khatma.name}" avec succès!'),
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
          const SnackBar(
            content: Text('Erreur lors de la participation à la Khatma'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
