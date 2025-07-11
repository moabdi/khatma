import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/settings_tile.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/profile_header.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';
import './ui/account_settings_section.dart';
import 'ui/delete_account_section.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateChangesProvider).value;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.myAccount),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(user: user),
              gapH32,
              AccountSettingsSection(user: user),
              gapH16,
              if (user.isAnonymous)
                SettingsTile(
                  leadingColor: context.theme.primaryColor,
                  icon: Icons.person,
                  title: context.loc.becomeMember,
                  titleColor: context.theme.primaryColor,
                  onTap: () => context.goNamed(AppRoute.login.name),
                ),
              gapH8,
              if (!user.isAnonymous) const DeleteAccountSection(),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
