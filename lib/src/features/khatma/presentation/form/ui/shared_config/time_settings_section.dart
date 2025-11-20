import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/shared_config/counter_tile.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

/// Section for configuring time-related settings (warnings, expirations, auto-release)
///
/// Can be reused in any screen that needs time-based reservation management
class TimeSettingsSection extends StatelessWidget {
  const TimeSettingsSection({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  final SharedConfig config;
  final ValueChanged<SharedConfig> onConfigChanged;

  static const Color orangeColor = Color(0xFFFF9800);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CounterTile(
            title: context.loc.warningDelay,
            subtitle: context.loc.daysBeforeReminder,
            icon: Icons.warning_amber,
            value: config.reservationWarningDays,
            leadingIconColor: orangeColor,
            onChanged: (value) {
              onConfigChanged(
                config.copyWith(reservationWarningDays: value),
              );
            },
          ),
          const Divider(height: 1),
          CounterTile(
            title: context.loc.expirationDelay,
            subtitle: context.loc.daysBeforeAutoRelease,
            icon: Icons.timer_off,
            value: config.reservationExpirationDays ?? 0,
            leadingIconColor: orangeColor,
            isOptional: true,
            onChanged: (value) {
              onConfigChanged(
                config.copyWith(
                  reservationExpirationDays: value == 0 ? null : value,
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: orangeColor.withValues(alpha: 0.15),
              child: const Icon(Icons.auto_fix_high, color: orangeColor),
            ),
            title: Text(context.loc.autoReleaseExpired),
            subtitle: Text(context.loc.freeUpExpiredReservedUnits),
            trailing: Switch(
              value: config.autoReleaseExpiredReservations,
              onChanged: (value) {
                onConfigChanged(
                  config.copyWith(autoReleaseExpiredReservations: value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
