import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';

/// Welcome section with title and subtitle
class WelcomeSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final TextAlign textAlign;

  const WelcomeSection({
    super.key,
    this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? context.loc.welcome,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: textAlign,
        ),
        if (subtitle != null || title == null) ...[
          gapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subtitle ??
                    "${context.loc.signInToContinue}, ${context.loc.or}"
                        .capitalize,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: context.theme.disabledColor,
                    ),
                textAlign: textAlign,
              ),
              TextButton(
                onPressed: () => context.goNamed(AppRoute.register.name),
                child: Text(context.loc.signUp),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
