// lib/src/features/profil/profile_menu_page.dart
// Updated to include sync functionality

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/security_section.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/settings_tile.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/profile_header.dart';
import 'package:khatma/src/features/info/presentation/widgets/contact_method_bottom_sheet.dart';
import 'package:khatma/src/features/khatma/presentation/sync/data_sync_list_tile_screen.dart';
import 'package:khatma/src/features/khatma/application/khatma_sync_manager.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileMenuPage extends ConsumerWidget {
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.profile),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRoute.home.name),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gapH24,

            // Simplified Profile Header
            ProfileHeader(user: user),

            gapH32,

            // Menu Items
            _buildMenuItems(context, user, ref),

            gapH48,
            // Footer
            _buildFooter(context),

            gapH24,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, user, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Account Section
          Card(
            child: Column(
              children: [
                if (user == null)
                  SettingsTile(
                    icon: Icons.login,
                    title: context.loc.signInOrSignUp,
                    titleColor: context.theme.colorScheme.primary,
                    onTap: () => context.goNamed(AppRoute.login.name),
                  ),
                if (user != null)
                  SettingsTile(
                    icon: Icons.person,
                    title: context.loc.myAccount,
                    onTap: () => context.goNamed(AppRoute.account.name),
                  ),
                gapH2,
                SettingsTile(
                  icon: Icons.settings,
                  title: context.loc.settings,
                  onTap: () => context.goNamed(AppRoute.settings.name),
                ),
                // Updated sync tile with modern UI
                _buildSyncTile(context, ref, user),
              ],
            ),
          ),

          gapH12,

          // Support Section
          Card(
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.question_answer,
                  title: context.loc.faq,
                  onTap: () => context.pushNamed(AppRoute.faq.name),
                ),
                gapH2,
                SettingsTile(
                  icon: Icons.article,
                  title: context.loc.legalNotices,
                  onTap: () => context.pushNamed(AppRoute.mentionsLegales.name),
                ),
                gapH2,
                SettingsTile(
                  icon: Icons.help_center,
                  title: context.loc.aboutUs,
                  onTap: () => context.pushNamed(AppRoute.aboutUs.name),
                ),
                gapH2,
                SettingsTile(
                  icon: Icons.support_agent,
                  title: context.loc.contactSupport,
                  onTap: () => ContactMethodBottomSheet.show(context),
                ),
              ],
            ),
          ),
          gapH12,
          SecuritySection(user: user),
        ],
      ),
    );
  }

  Widget _buildSyncTile(BuildContext context, WidgetRef ref, user) {
    // Only show sync option for authenticated users
    if (user == null || user.isAnonymous) {
      return const SizedBox.shrink();
    }

    final syncManager = ref.watch(syncManagerProvider.notifier);
    final isCurrentlySyncing = syncManager.isSyncing;
    final lastSync = syncManager.lastSuccessfulSync;
    final hasFailures = syncManager.consecutiveFailures > 0;

    // Determine sync status and colors
    IconData syncIcon;
    Color? iconColor;
    String subtitle;

    print("lastSync: $lastSync");

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

    return SettingsTile(
      leadingColor: iconColor,
      icon: syncIcon,
      title: context.loc.dataSynchronization,
      onTap: () => DataSyncListTileScreen.show(context),
    );
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

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Khatma AMM',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).disabledColor,
              ),
        ),
        gapH4,
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final version = snapshot.data?.version ?? '1.0.0';
            final buildNumber = snapshot.data?.buildNumber ?? '1';

            return Text(
              'v$version ($buildNumber)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            );
          },
        ),
        gapH8,
        Text(
          context.loc.madeWithLove,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
