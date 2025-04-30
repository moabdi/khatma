import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        children: [
          const TextSpan(text: '© Khatma 2025 | '),
          TextSpan(
            text: 'Conditions Générales d\'Utilisation',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.pushNamed(AppRoute.cgu.name),
          ),
          const TextSpan(text: ' | '),
          TextSpan(
            text: 'Mentions Légales',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.pushNamed(AppRoute.mentionsLegales.name),
          ),
          const TextSpan(text: ' | '),
          TextSpan(
            text: 'Déclaration relative à la protection des données',
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
