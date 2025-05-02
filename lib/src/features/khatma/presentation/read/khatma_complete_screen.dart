import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma_ui/components/buttons/primary_button.dart';
import 'package:khatma/src/constants/lottie_asset.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/repeat_enabler_tile.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/khatma_bar_chart.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class KhatmaSuccessComplete extends ConsumerWidget {
  KhatmaSuccessComplete({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          topCard(context, ref),
        ],
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
                "Congratulations",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              gapH8,
              Text(
                "You have just finished your khatma in ${khatma.endDate!.timeAgoSince(khatma.startDate)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              gapH12,
              Divider(),
              KhatmaBarChart(
                khatma: khatma,
                title: "Completude",
                subTitle: "Khatma Historique",
              ),
              gapH20,
              Divider(),
              gapH20,
              RepeatKhatmaTile(
                enabled: khatma.repeat,
                onChanged: (value) {},
              ),
              Spacer(),
              PrimaryButton(
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width * .85,
                shadowOffset: 5,
                onPressed: () {
                  ref.read(khatmaListProvider.notifier).complete(
                        khatma.id!,
                        khatma.repeat,
                      );

                  context.goNamed(AppRoute.home.name);
                },
                text: "Terminate",
              ),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
