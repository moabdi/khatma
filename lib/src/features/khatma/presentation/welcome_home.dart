import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(51),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(context.loc.noKhatmaYet,
              style: Theme.of(context).textTheme.headlineSmall),
          gapH8,
          Text(context.loc.createKhatmaToStart,
              style: Theme.of(context).textTheme.bodyMedium),
          gapH24,
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: Colors.black,
              ),
              onPressed: () {
                context.goNamed(AppRoute.addKhatma.name);
              },
              child: Text(context.loc.add),
            ),
          ),
          gapH16,
          Image.asset(
            'assets/images/welcome.png',
            height: 250,
          ),
        ],
      ),
    );
  }
}
