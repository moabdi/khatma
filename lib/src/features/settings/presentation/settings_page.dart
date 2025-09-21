import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/personal/application/khatma_sync_manager.dart';
import 'package:khatma/src/features/khatma/personal/presentation/sync/khatma_sync_screen.dart';
import 'package:khatma/src/features/settings/application/setting_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/themes/theme_provider.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(context.loc.language),
                    subtitle: Text(context.loc.languageName),
                    onTap: () => context.pushNamed(AppRoute.languages.name),
                  ),
                  ListTile(
                    leading: Icon(Icons.brightness_6),
                    title: Text(context.loc.theme),
                    subtitle: Text(
                        context.loc.themeMode(ref.read(themeProvider).name)),
                    onTap: () => context.pushNamed(AppRoute.theme.name),
                  ),
                ],
              ),
            ),
            gapH8,
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.book_sharp,
                ),
                title: Text(context.loc.riwaya),
                subtitle: Text(context.loc.riwayaMode(settings.riwaya)),
                onTap: () => context.pushNamed(AppRoute.recitation.name),
              ),
            ),
            gapH8,
            Card(
              child: _buildSyncTile(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncTile(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;

    // Only show sync option for authenticated users
    if (user == null || user.isAnonymous) {
      return const SizedBox.shrink();
    }

    final syncManager = ref.watch(syncManagerProvider.notifier);
    final isCurrentlySyncing = syncManager.isSyncing;
    final lastSync = ref.watch(syncManagerProvider.notifier).lastSuccessfulSync;
    final hasFailures = syncManager.consecutiveFailures > 0;

    // Determine sync status and colors
    IconData syncIcon;
    Color? iconColor;
    String subtitle;

    if (isCurrentlySyncing) {
      syncIcon = Icons.sync;
      iconColor = context.theme.colorScheme.primary;
      subtitle = context.loc.syncing;
    } else if (hasFailures) {
      syncIcon = Icons.sync_problem;
      iconColor = context.theme.colorScheme.error;
      subtitle = context.loc.syncError;
    } else if (lastSync != null) {
      syncIcon = Icons.cloud_done;
      iconColor = Colors.green;
      subtitle = context.loc.lastSyncTime(_formatSyncTime(context, lastSync));
    } else {
      syncIcon = Icons.cloud_off;
      iconColor = context.theme.colorScheme.onSurfaceVariant;
      subtitle = context.loc.neverSynced;
    }

    Column(
      children: [
        gapH2,
        ListTile(
          dense: true,
          leading: isCurrentlySyncing
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: iconColor,
                  ),
                )
              : Icon(syncIcon, color: iconColor),
          title: Text(
            context.loc.dataSynchronization,
            style: TextStyle(
              color: hasFailures
                  ? context.theme.colorScheme.error
                  : context.theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: hasFailures
                  ? context.theme.colorScheme.error.withOpacity(0.7)
                  : context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () => context.pushNamed(AppRoute.sync.name),
        ),
      ],
    );

    return SimplifiedSyncContent();
  }

  String _formatSyncTime(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return context.loc.justNow;
    } else if (difference.inHours < 1) {
      return context.loc.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return context.loc.hoursAgo(difference.inHours);
    } else {
      return context.loc.daysAgo(difference.inDays);
    }
  }
}
