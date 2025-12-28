import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// A reusable widget that displays a login required message with a sign-in button.
///
/// This widget is used across the app to prompt users to sign in when they try
/// to access features that require authentication.
///
/// Example usage:
/// ```dart
/// if (!isAuthenticated) {
///   return const LoginRequiredWidget();
/// }
/// ```
class LoginRequiredScreen extends StatelessWidget {
  const LoginRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lock icon
            Icon(
              Icons.lock_outline,
              size: 64,
              color: colorScheme.primary,
            ),
            gapH16,

            // Title
            Text(
              context.loc.loginRequiredTitle,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            gapH8,

            // Message
            Text(
              context.loc.loginRequiredMessage,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            gapH24,

            // Sign in button
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.goNamed(AppRoute.login.name);
                },
                icon: const Icon(Icons.login),
                label: Text(context.loc.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
