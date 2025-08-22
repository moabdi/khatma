import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';

class BackToLogin extends StatelessWidget {
  const BackToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.goNamed(AppRoute.login.name);
      },
      icon: Icon(Icons.arrow_back_ios),
      label: Text(context.loc.backToLogin),
    );
  }
}
