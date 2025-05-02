import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';

class BackToLogin extends StatelessWidget {
  const BackToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.goNamed(AppRoute.login.name);
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
      label: const Text(
        'Retour à la page de connexion',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
