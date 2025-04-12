import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_bar_chart.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

import '../list/weekly_progress_chart.dart';

class KhatmaSuccessComplete extends StatelessWidget {
  const KhatmaSuccessComplete({super.key});

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
    final privateKhatma = KhatmaHistory.private(
      id: 'khatma_001',
      unit: SplitUnit.juzz,
      startDate: DateTime(2025, 4, 1),
      endDate: DateTime(2025, 4, 30),
      userId: 'abdi',
      parts: [
        KhatmaPartHistory(id: 1, endDate: DateTime(2025, 4, 1)),
        KhatmaPartHistory(id: 2, endDate: DateTime(2025, 4, 2)),
        KhatmaPartHistory(id: 3, endDate: DateTime(2025, 4, 2)),
        KhatmaPartHistory(id: 4, endDate: DateTime(2025, 4, 3)),
        KhatmaPartHistory(id: 5, endDate: DateTime(2025, 4, 4)),
        KhatmaPartHistory(id: 6, endDate: DateTime(2025, 4, 6)),
      ],
    );

    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              lottieSuccessAsset,
              Text(
                "Congratulations",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              gapH12,
              Text(
                "You have just finished you 1 khatma",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              gapH12,
              DottedLine(dashLength: 10),
              Spacer(),
              KhatmaBarChart(khatma: privateKhatma),
              WeeklyProgressChart(),
              Spacer(),
              PrimaryButton(
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width * .8,
                shadowOffset: 5,
                onPressed: () => {},
                text: "Done",
              ),
              gapH16,
              TextButton(
                onPressed: () => {},
                child: Text("Close"),
              ),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}
