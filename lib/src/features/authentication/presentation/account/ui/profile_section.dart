import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/presentation/account/ui/status_badge.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

class ProfileSection extends StatelessWidget {
  final dynamic user;

  const ProfileSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 40,
            backgroundColor: context.theme.primaryColor.withOpacity(0.1),
            child: Text(
              user.email?.isNotEmpty == true
                  ? user.email![0].toUpperCase()
                  : 'U',
              style: context.textTheme.headlineLarge!
                  .copyWith(color: context.theme.primaryColor),
            ),
          ),
          Text(
            user.displayName.toString().capitalize,
            style: context.textTheme.titleLarge,
          ),

          if (user.email != null) ...[
            gapH8,
            // Email Verification Status
            StatusBadge.forEmailVerification(
              isVerified: user.emailVerified,
              verifiedText: user.email.toString(),
              unverifiedText: user.email.toString(),
              isCompact: false,
            )
          ],

          // Account Type
          gapH8,
          Text(
            user.isAnonymous
                ? context.loc.guestAccount
                : context.loc.userAccount,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.theme.disabledColor,
                ),
          ),
        ],
      ),
    );
  }
}
