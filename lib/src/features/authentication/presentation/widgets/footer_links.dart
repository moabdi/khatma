import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        children: [
          TextSpan(text: '© ${context.loc.appName} $currentYear | '),
          TextSpan(
            text: context.loc.termsOfService,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.pushNamed(AppRoute.cgu.name),
          ),
          const TextSpan(text: ' | '),
          TextSpan(
            text: context.loc.legalNotices,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.pushNamed(AppRoute.mentionsLegales.name),
          ),
          const TextSpan(text: ' | '),
          TextSpan(
            text: context.loc.privacyPolicy,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => context.pushNamed(AppRoute.declarationDonnees.name),
          ),
        ],
      ),
    );
  }
}
