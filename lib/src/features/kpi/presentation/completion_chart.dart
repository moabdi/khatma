import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma.dart';
import 'package:khatma/src/features/kpi/presentation/reading_chart.dart';

class CompletionChart extends StatelessWidget {
  const CompletionChart(this.parts, {super.key});

  final List<KhatmaPart> parts;

  @override
  Widget build(BuildContext context) {
    return ReadingChart(
      data: [],
    );
  }
}
