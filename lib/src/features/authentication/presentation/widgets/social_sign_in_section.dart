import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Social sign-in section with divider and buttons (Google & Anonymous only)
class SocialSignInSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAnonymousSignIn;
  final bool showGoogle;
  final bool showAnonymous;

  const SocialSignInSection({
    super.key,
    this.isLoading = false,
    this.onGoogleSignIn,
    this.onAnonymousSignIn,
    this.showGoogle = true,
    this.showAnonymous = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (showGoogle && onGoogleSignIn != null) {
      buttons.add(GoogleSignInButton(
        isLoading: isLoading,
        onPressed: onGoogleSignIn!,
      ));
    }

    if (showAnonymous && onAnonymousSignIn != null) {
      if (buttons.isNotEmpty) buttons.add(gapH16);
      buttons.add(AnonymousSignInButton(
        isLoading: isLoading,
        onPressed: onAnonymousSignIn!,
      ));
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [...buttons],
    );
  }
}

/// Social divider widget
class SocialDivider extends StatelessWidget {
  final String? text;

  const SocialDivider({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text ?? context.loc.or),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

/// Google sign-in button
class GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Image.asset(
        'assets/logo-google.png',
        height: 20,
        width: 20,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.login, size: 20),
      ),
      label: Text(context.loc.continueWithGoogle),
    );
  }
}

/// Anonymous sign-in button
class AnonymousSignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const AnonymousSignInButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: const Icon(Icons.person_outline, size: 20),
      label: Text(context.loc.continueAsGuest),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[300]!),
        foregroundColor: Colors.grey[700],
      ),
    );
  }
}
