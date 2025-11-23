import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/shared_config/counter_tile.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

/// Section for configuring user limits (max reservations and max units to read)
///
/// Can be reused in any screen that needs to configure user participation limits
class LimitsSection extends StatelessWidget {
  const LimitsSection({
    super.key,
    required this.config,
    required this.onConfigChanged,
    required this.maxUnits,
  });

  final SharedConfig config;
  final ValueChanged<SharedConfig> onConfigChanged;
  final int maxUnits;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CounterTile(
            title: context.loc.maxPartsToReserve,
            subtitle: context.loc.atSameTime,
            icon: Icons.playlist_add_check,
            value: config.maxReservationsPerUser,
            maxValue: config.maxUnitsToRead,
            onChanged: (value) {
              onConfigChanged(
                config.copyWith(maxReservationsPerUser: value),
              );
            },
          ),
          const Divider(height: 1),
          CounterTile(
            title: context.loc.maxPartsToRead,
            subtitle: context.loc.totalLimitPerUser,
            icon: Icons.book,
            value: config.maxUnitsToRead,
            maxValue: maxUnits,
            onChanged: (value) {
              // Ensure maxReservationsPerUser doesn't exceed maxUnitsToRead
              final updatedMaxReservations =
                  config.maxReservationsPerUser > value
                      ? value
                      : config.maxReservationsPerUser;
              onConfigChanged(
                config.copyWith(
                  maxUnitsToRead: value,
                  maxReservationsPerUser: updatedMaxReservations,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
