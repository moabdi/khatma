// lib/src/features/shared_khatma/presentation/khatma_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/filter_chip.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/info_row.dart';
import 'package:khatma/src/features/shared_khatma/presentation/widgets/stat_card.dart';
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
  late SharedKhatma _currentKhatma;
  bool _isJoining = false;
  final Set<UnitFilter> _activeFilters = {UnitFilter.all};

  @override
  void initState() {
    super.initState();
    _currentKhatma = widget.khatma;
  }

  // Check if there are any selected units (not completed/reserved by others)
  bool get _hasSelectedUnits {
    return _currentKhatma.units.any((unit) => unit.status == UnitStatus.selected);
  }

  // Check if there are any visible units matching the current filter
  bool get _hasVisibleUnits {
    for (int i = 0; i < _currentKhatma.totalUnits; i++) {
      final unitNumber = i + 1;
      final unit = _currentKhatma.units.firstWhere(
        (u) => u.unitNumber == unitNumber,
        orElse: () => SharedKhatmaUnit(unitNumber: unitNumber),
      );
      if (_shouldShowUnit(unit)) {
        return true;
      }
    }
    return false;
  }

  void _toggleFilter(UnitFilter filter) {
    setState(() {
        _activeFilters.clear();
      if (filter == UnitFilter.all) {
        _activeFilters.clear();
        _activeFilters.add(UnitFilter.all);
      } else {
        if (_activeFilters.contains(UnitFilter.all)) {
          _activeFilters.clear();
        }

        if (_activeFilters.contains(filter)) {
          _activeFilters.remove(filter);
          if (_activeFilters.isEmpty) {
            _activeFilters.add(UnitFilter.all);
          }
        } else {
          _activeFilters.add(filter);
        }
      }
    });
  }

  bool _shouldShowUnit(SharedKhatmaUnit unit) {
    if (_activeFilters.contains(UnitFilter.all)) {
      return true;
    }

    for (final filter in _activeFilters) {
      switch (filter) {
        case UnitFilter.all:
          return true;
        case UnitFilter.mine:
          if (unit.isReservedByCurrentUser) return true;
        case UnitFilter.free:
          if (unit.isFree || unit.isSelected) return true;
        case UnitFilter.completed:
          if (unit.status == UnitStatus.completed) return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentKhatma.name),
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
                    color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
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
                  if (_currentKhatma.description.isNotEmpty)
                    ExpansionTile(
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      tilePadding: EdgeInsets.all(0),
                      title: Text('Description'),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(_currentKhatma.description),
                        ),
                      ],
                    ),
                    gapH12,
                    // Title
                    Text('Unités (${_currentKhatma.unit.displayName})'),
                    gapH8,
                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          KhatmaFilterChip(
                            label: 'Tout',
                            isSelected: _activeFilters.contains(UnitFilter.all),
                            onTap: () => _toggleFilter(UnitFilter.all),
                          ),
                          gapW8,
                          KhatmaFilterChip(
                            label: 'Mes unités',
                            isSelected: _activeFilters.contains(UnitFilter.mine),
                            onTap: () => _toggleFilter(UnitFilter.mine),
                          ),
                          gapW8,
                          KhatmaFilterChip(
                            label: 'Disponibles',
                            isSelected: _activeFilters.contains(UnitFilter.free),
                            onTap: () => _toggleFilter(UnitFilter.free),
                          ),
                          gapW8,
                          KhatmaFilterChip(
                            label: 'Complétées',
                            isSelected: _activeFilters.contains(UnitFilter.completed),
                            onTap: () => _toggleFilter(UnitFilter.completed),
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
              child: !_hasVisibleUnits
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
                            itemCount: _currentKhatma.totalUnits,
                            itemBuilder: (context, index) {
                              final unitNumber = index + 1;
                              final unit = _currentKhatma.units.firstWhere(
                                (u) => u.unitNumber == unitNumber,
                                orElse: () =>
                                    SharedKhatmaUnit(unitNumber: unitNumber),
                              );

                              // Apply filter
                              if (!_shouldShowUnit(unit)) {
                                return const SizedBox.shrink();
                              }

                              return UnitTile(
                                unit: unit,
                                onTap: () => _toggleUnitReservation(unit),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
        
            // Join/Confirm Button
            if (_hasSelectedUnits)
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
                    color: Colors.black.withOpacity(0.1),
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
                        'Réservé: ${_currentKhatma.userReservedUnits.length}/${_currentKhatma.maxReservationsPerUser}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (_currentKhatma.remainingReservations > 0)
                        Text(
                          '${_currentKhatma.remainingReservations} restantes',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.green.shade600,
                              ),
                        )
                      else
                        Text(
                          'Limite atteinte',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                        onPressed: !_isJoining ? _confirmJoin : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              Theme.of(context).colorScheme.surfaceContainerHighest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isJoining
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
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

  void _toggleUnitReservation(SharedKhatmaUnit unit) {
    if (unit.isFree) {
      // Check if limit reached before attempting reservation
      if (!_currentKhatma.canUserReserveMore) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Limite atteinte: ${_currentKhatma.maxReservationsPerUser} unités maximum par utilisateur'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
      _reserveUnit(unit);
    } else if (unit.isReservedByCurrentUser || unit.isSelected) {
      _unreserveUnit(unit);
    }
    // Do nothing if reserved by another user or completed
  }

  void _reserveUnit(SharedKhatmaUnit unit) {
    setState(() {
      final updatedUnits = _currentKhatma.units.map((u) {
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

      _currentKhatma = _currentKhatma.copyWith(units: updatedUnits);
    });
  }

  void _unreserveUnit(SharedKhatmaUnit unit) {
    setState(() {
      final updatedUnits = _currentKhatma.units
          .where((u) => u.unitNumber != unit.unitNumber)
          .toList();

      _currentKhatma = _currentKhatma.copyWith(units: updatedUnits);
    });

    // Pas de SnackBar après libération
  }

  void _confirmJoin() async {
    setState(() {
      _isJoining = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Vous avez rejoint "${_currentKhatma.name}" avec succès!'),
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
    } finally {
      if (mounted) {
        setState(() {
          _isJoining = false;
        });
      }
    }
  }
}
