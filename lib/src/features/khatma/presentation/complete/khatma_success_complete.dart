import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';
import 'package:khatma/src/common/widgets/bar_simple_chart.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_bar_chart.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class KhatmaSuccessComplete extends StatelessWidget {
  KhatmaSuccessComplete({super.key});

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
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 12, 31),
      userId: 'abdi',
      parts: _generateRandomParts(),
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
              gapH8,
              Text(
                "You have just finished you 1 khatma",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              gapH12,
              DottedLine(dashLength: 10),
              KhatmaBarChart(
                khatma: privateKhatma,
                title: "Progress",
                subTitle: "SubTitle",
              ),
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

  final random = Random();

  List<KhatmaPartHistory> _generateRandomParts() {
    final List<KhatmaPartHistory> parts = [];
    final startDate = DateTime(2025, 1, 1);
    final endDate = DateTime(2025, 12, 31);

    // Générer un nombre aléatoire de parties par mois
    for (int month = 1; month <= 12; month++) {
      int numParts = random.nextInt(10) +
          1; // Nombre aléatoire de parties (1 à 10 par mois)
      for (int i = 0; i < numParts; i++) {
        // Créer une date aléatoire dans le mois courant
        int day = random
            .nextInt(DateTime(month == 12 ? 12 : month + 1, month + 1, 0).day);
        DateTime randomDate = DateTime(2025, month, day + 1);

        // Ajouter une partie pour cette date
        parts.add(KhatmaPartHistory(id: i + 1, endDate: randomDate));
      }
    }

    // Trier les parties par date pour s'assurer que tout est dans l'ordre chronologique
    parts.sort((a, b) => a.endDate.compareTo(b.endDate));

    return parts;
  }
}
