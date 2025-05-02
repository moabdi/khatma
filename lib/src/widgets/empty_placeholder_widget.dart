import 'package:khatma_ui/components/buttons/primary_button.dart';
import 'package:khatma/src/constants/lottie_asset.dart';
import 'package:khatma/src/i18n/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lottieNoData,
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            gapH16,
            PrimaryButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
