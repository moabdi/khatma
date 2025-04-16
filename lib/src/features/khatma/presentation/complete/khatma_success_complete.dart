import 'package:flutter/material.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/repeat_enabler_tile.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_bar_chart.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class KhatmaSuccessComplete extends StatelessWidget {
  KhatmaSuccessComplete({
    super.key,
    required this.khatmaHistory,
  });

  final KhatmaHistory khatmaHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          topCard(context),
        ],
      ),
    );
  }

  Container topCard(BuildContext context) {
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
                "You have just finished your khatma in 23 days",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              gapH12,
              Divider(),
              KhatmaBarChart(
                khatma: khatmaHistory,
                title: "Completude",
                subTitle: "Khatma Historique",
              ),
              gapH20,
              Divider(),
              gapH20,
              RepeatEnablerTile(),
              Spacer(),
              PrimaryButton(
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width * .85,
                shadowOffset: 5,
                onPressed: () => {},
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
