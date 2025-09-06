import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ProfileHeader extends StatelessWidget {
  final AppUser? user;

  const ProfileHeader({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with verification indicator
        Stack(
          children: [
            user == null
                ? CircleAvatar(
                    backgroundColor: context.colorScheme.primary,
                    radius: 50,
                    child: Icon(
                      Icons.person_outline,
                      color: context.colorScheme.onPrimary,
                      size: 50,
                    ),
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundColor: user!.email?.isNotEmpty == true
                        ? context.colorScheme.primary.withAlpha(50)
                        : Colors.grey.shade300,
                    child: user?.email?.isNotEmpty == true
                        ? Text(
                            user!.email![0].toUpperCase(),
                            style: context.textTheme.displaySmall!.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          )
                        : user!.isAnonymous
                            ? const Icon(
                                Icons.flutter_dash,
                                size: 50,
                              )
                            : const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                  ),

            // Verification indicator for logged users
            if (user != null && !user!.isAnonymous)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: user!.emailVerified
                        ? context.colorScheme.primary
                        : context.warningColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    user!.emailVerified ? Icons.check : Icons.warning,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),

        gapH12,

        // User Name/Email
        Text(
          _getDisplayName(context, user),
          style: context.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),

        gapH4,

        // User Status/Username
        Text(
          _getSubtitle(context, user),
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getDisplayName(BuildContext context, user) {
    if (user == null) {
      return context.loc.noAccountYet;
    }

    // Use display name if available, otherwise use email
    if (user.displayName?.isNotEmpty == true) {
      return user.displayName!;
    }

    return user.email ?? context.loc.user;
  }

  String _getSubtitle(BuildContext context, user) {
    if (user == null) {
      return context.loc.createAccountToStart;
    }

    if (user.isAnonymous) {
      return '@${context.loc.anonymous.toLowerCase()}';
    }

    // Show email if it's different from display name
    if (user.displayName?.isNotEmpty == true && user.email != null) {
      return user.email!;
    }

    // Show user type
    return user.emailVerified
        ? context.loc.verifiedUser
        : context.loc.unverifiedUser;
  }
}
