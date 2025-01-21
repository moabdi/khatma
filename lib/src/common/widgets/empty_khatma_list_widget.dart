import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/routing/app_router.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyKhatmaListWidget extends StatelessWidget {
  const EmptyKhatmaListWidget({super.key, this.message = "Start new Khatma"});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p2),
      child: Column(
        children: [
          InkWell(
            onTap: () => context.goNamed(AppRoute.addKhatma.name),
            child: Card(
              color: Theme.of(context).primaryColor.withOpacity(.6),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    lottieStartReading,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(Sizes.p2),
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                      child: Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
