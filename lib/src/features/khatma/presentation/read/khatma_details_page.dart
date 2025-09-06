// lib/src/features/shared_khatma/presentation/khatma_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import 'package:khatma/src/features/shared_khatma/domain/shared_khatma.dart';
//import 'package:khatma/src/features/shared_khatma/application/shared_khatma_provider.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
/*
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

  @override
  void initState() {
    super.initState();
    _currentKhatma = widget.khatma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentKhatma.name),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () => _showKhatmaInfo(context),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          // Khatma Overview
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and description section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      gapW16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _currentKhatma.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            gapH4,
                            Text(
                              _currentKhatma.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.8),
                                    height: 1.4,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  gapH24,

                  // Statistics cards
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.group_rounded,
                        label: 'Membres',
                        value: '${_currentKhatma.membersCount}',
                        context: context,
                      ),
                      gapW16,
                      _StatCard(
                        icon: Icons.library_books_rounded,
                        label: 'Disponibles',
                        value: '${_currentKhatma.unitsAvailable}',
                        context: context,
                      ),
                      gapW16,
                      _StatCard(
                        icon: Icons.trending_up_rounded,
                        label: 'Progression',
                        value:
                            '${(_currentKhatma.completionPercent * 100).toInt()}%',
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Units Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unités (${_currentKhatma.unit.displayName})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  gapH16,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _currentKhatma.totalUnits,
                    itemBuilder: (context, index) {
                      final unitNumber = index + 1;
                      final unit = _currentKhatma.units.firstWhere(
                        (u) => u.unitNumber == unitNumber,
                        orElse: () => SharedKhatmaUnit(unitNumber: unitNumber),
                      );

                      return _UnitTile(
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
                if (_currentKhatma.userReservedUnits.isNotEmpty) gapH12,
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _currentKhatma.userReservedUnits.isNotEmpty &&
                            !_isJoining
                        ? _confirmJoin
                        : null,
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
    } else if (unit.isReservedByCurrentUser) {
      _unreserveUnit(unit);
    }
    // Do nothing if reserved by another user or completed
  }

  void _reserveUnit(SharedKhatmaUnit unit) {
    setState(() {
      final updatedUnits = _currentKhatma.units.map((u) {
        if (u.unitNumber == unit.unitNumber) {
          return u.copyWith(
            status: UnitStatus.reservedByCurrentUser,
            reservedByUserId: 'currentUser',
            reservedByUserName: 'You',
            reservedDate: DateTime.now(),
          );
        }
        return u;
      }).toList();

      // Add the unit if it doesn't exist
      if (!updatedUnits.any((u) => u.unitNumber == unit.unitNumber)) {
        updatedUnits.add(SharedKhatmaUnit(
          unitNumber: unit.unitNumber,
          status: UnitStatus.reservedByCurrentUser,
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
      final updatedUnits = _currentKhatma.units.map((u) {
        if (u.unitNumber == unit.unitNumber && u.isReservedByCurrentUser) {
          return u.copyWith(
            status: UnitStatus.free,
            reservedByUserId: null,
            reservedByUserName: null,
            reservedDate: null,
          );
        }
        return u;
      }).toList();

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

  void _showKhatmaInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_currentKhatma.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(
              label: 'Type',
              value: _currentKhatma.unit.displayName,
            ),
            _InfoRow(
              label: 'Créé le',
              value: _formatDate(_currentKhatma.createDate),
            ),
            _InfoRow(
              label: 'Créé par',
              value: _currentKhatma.creatorName ?? 'Anonyme',
            ),
            _InfoRow(
              label: 'Total unités',
              value: '${_currentKhatma.totalUnits}',
            ),
            _InfoRow(
              label: 'Statut',
              value: _currentKhatma.isPublic ? 'Public' : 'Privé',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final BuildContext context;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
            ),
            gapH8,
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            gapH4,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitTile extends StatelessWidget {
  final SharedKhatmaUnit unit;
  final VoidCallback onTap;

  const _UnitTile({
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor;
    Widget? trailingIcon;
    bool isClickable = true;
    Color avatarColor;
    Color numberColor;

    // Determine colors and states based on unit status
    switch (unit.status) {
      case UnitStatus.free:
        tileColor = Theme.of(context).colorScheme.surface;
        avatarColor = Theme.of(context).colorScheme.primary.withOpacity(0.1);
        numberColor = Theme.of(context).colorScheme.primary;
        trailingIcon = null;
        break;

      case UnitStatus.reserved:
        tileColor = Colors.grey.shade100;
        avatarColor = Colors.grey.shade300;
        numberColor = Colors.grey.shade600;
        isClickable = false;
        trailingIcon = Icon(
          Icons.lock,
          color: Colors.grey.shade600,
          size: 20,
        );
        break;

      case UnitStatus.reservedByCurrentUser:
        tileColor = context.colorScheme.primary.withOpacity(0.1);
        avatarColor = context.colorScheme.primary.withOpacity(0.2);
        numberColor = context.colorScheme.primary;
        trailingIcon = Icon(
          Icons.check_circle,
          color: context.colorScheme.primary,
          size: 20,
        );
        break;

      case UnitStatus.completed:
        tileColor = Colors.green.shade50;
        avatarColor = Colors.green.shade100;
        numberColor = Colors.green.shade700;
        isClickable = false;
        trailingIcon = Icon(
          Icons.check,
          color: Colors.green.shade700,
          size: 20,
        );
        break;
    }

    // Calculate start ayah for the hizb (example calculation)
    final startAyah = _getStartAyahForHizb(unit.unitNumber);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: tileColor,
      elevation: unit.status == UnitStatus.reservedByCurrentUser ? 2 : 1,
      child: ListTile(
        onTap: isClickable ? onTap : null,
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          radius: 20,
          child: Text(
            '${unit.unitNumber}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
          ),
        ),
        title: Text(
          'Hizb ${unit.unitNumber}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          'Commence à: $startAyah',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: trailingIcon,
        dense: true,
      ),
    );
  }

  // Helper method to calculate start ayah for each hizb
  String _getStartAyahForHizb(int hizbNumber) {
    // This is a simplified example - you would need actual Quran data
    // to get the correct ayah for each hizb
    final hizbData = {
      1: 'Al-Fatiha 1',
      2: 'Al-Baqarah 26',
      3: 'Al-Baqarah 60',
      4: 'Al-Baqarah 92',
      5: 'Al-Baqarah 124',
      6: 'Al-Baqarah 160',
      7: 'Al-Baqarah 177',
      8: 'Al-Baqarah 198',
      // Add more hizb data as needed
    };

    return hizbData[hizbNumber] ?? 'Hizb $hizbNumber';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

*/
