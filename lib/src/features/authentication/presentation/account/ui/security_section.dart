import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/components/modern_modal_sheet.dart';
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

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    ModernBottomSheet.show(
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      title: context.loc.signOut,
      content: Card(
        child: ListTile(
          title: Text(context.loc.confirmSignOut),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final controller = ref.read(accountControllerProvider.notifier);
            final result = await controller.signOut();

            if (!context.mounted) return;

            result.handleUI(
              context,
              onSuccess: () {
                Navigator.of(context).pop();
                context.goNamed(AppRoute.home.name);
              },
            );
          },
          child: Text(context.loc.signOut),
        ),
      ],
    );
  }
}
