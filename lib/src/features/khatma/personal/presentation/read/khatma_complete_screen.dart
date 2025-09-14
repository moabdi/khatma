import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/constants/lottie_asset.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/ui/khatma_bar_chart.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_dividers.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class KhatmaSuccessComplete extends ConsumerWidget {
  KhatmaSuccessComplete({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            topCard(context, ref),
          ],
        ),
      ),
    );
  }

  Container topCard(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              lottieSuccessAsset,
              Text(
                context.loc.congratulations,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              gapH8,
              Text(
                context.loc.khatmaFinishedMessage(
                    khatma.endDate!.timeAgoSince(khatma.startDate)),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              gapH12,
              Divider(),
              KhatmaBarChart(
                khatma: khatma,
                title: context.loc.completion,
                subTitle: context.loc.khatmaHistory,
              ),
              gapH20,
              dividerH1T1,
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoute.home.name);
                  },
                  child: Text(context.loc.terminate),
                ),
              ),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
