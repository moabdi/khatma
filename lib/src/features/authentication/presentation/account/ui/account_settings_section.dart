import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';
import '../ui/settings_tile.dart';
import 'edit_profile_dialog.dart';
import 'change_password_dialog.dart';
import 'email_verification_handler.dart';
import 'token_refresh_handler.dart';

class AccountSettingsSection extends ConsumerWidget {
  final dynamic user;

  const AccountSettingsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Verification
          if (!user.isAnonymous && !user.emailVerified)
            Column(
              children: [
                SettingsTile(
                  icon: Icons.mark_email_unread_outlined,
                  title: context.loc.verifyEmail,
                  subtitle: context.loc.confirmEmailAddress,
                  leadingColor: context.warningColor,
                  onTap: () =>
                      EmailVerificationHandler.sendVerification(context, ref),
                ),
                dividerH0_5T0_5,
              ],
            ),
          // Edit Profile
          SettingsTile(
            icon: Icons.edit_outlined,
            title: context.loc.editProfile,
            subtitle: context.loc.changeDisplayName,
            onTap: () => EditProfileDialog.show(context, ref, user.displayName),
          ),
          dividerH0_5T0_5,
          // Change Password
          if (!user.isAnonymous)
            SettingsTile(
              icon: Icons.lock_outline,
              title: context.loc.changePassword,
              subtitle: context.loc.updateYourPassword,
              onTap: () => ChangePasswordDialog.show(context, ref),
            ),

          dividerH0_5T0_5,
          // Refresh Token
          SettingsTile(
            icon: Icons.refresh_outlined,
            title: context.loc.refreshData,
            subtitle: context.loc.updateAccountInformation,
            onTap: () => TokenRefreshHandler.refresh(context, ref),
          ),
        ],
      ),
    );
  }
}
