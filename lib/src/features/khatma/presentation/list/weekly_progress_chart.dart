import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/bar_simple_chart.dart';

class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text("data"),
      ),
    );
  }
}
