import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/security_section.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/settings_tile.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/profile_header.dart';
import 'package:khatma/src/features/info/presentation/widgets/contact_method_bottom_sheet.dart';
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
            ProfileHeader(user: user),
            gapH32,
            _buildMenuItems(context, user, ref),
            gapH48,
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

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        gapH8,
        Text(
          'Khatma AMM',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
