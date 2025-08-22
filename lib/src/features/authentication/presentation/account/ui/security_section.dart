import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/core/app_dialog.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import '../logic/account_controller.dart';
import '../ui/settings_tile.dart';

class SecuritySection extends ConsumerWidget {
  final AppUser? user;

  const SecuritySection({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return user == null
        ? SizedBox.shrink()
        : Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sign Out
                SettingsTile(
                  icon: Icons.logout_outlined,
                  title: context.loc.signOut,
                  onTap: () => _showSignOutDialog(context, ref),
                ),
              ],
            ),
          );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) async {
    final shouldLogout = await AppDialog.showLogout(context);

    if (shouldLogout == true) {
      final controller = ref.read(accountControllerProvider.notifier);
      await controller.signOut();
      Navigator.of(context).pop();
      context.goNamed(AppRoute.home.name);
    }
  }
}
