import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/conditional_content.dart';

class KhatmaBarChart extends StatelessWidget {
  final KhatmaHistory khatma;
  final String? title;
  final String? subTitle;

  const KhatmaBarChart({
    super.key,
    required this.khatma,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final List<KhatmaPartHistory> allParts = khatma.map(
      private: (p) => p.parts,
      shared: (s) => s.parts.values.expand((list) => list).toList(),
    );

    final Map<String, int> partsPerDay = {};
    final start = khatma.startDate;
    final end = khatma.endDate;
    final durationInDays = end.difference(start).inDays;

    final bool groupByDay = durationInDays <= 15;

    for (final part in allParts) {
      final dateStr = groupByDay
          ? DateFormat('dd/MM').format(part.endDate)
          : DateFormat('MMM').format(part.endDate);

      partsPerDay.update(dateStr, (val) => val + 1, ifAbsent: () => 1);
    }

    final sortedDates = partsPerDay.keys.toList()..sort();
    final List<BarChartGroupData> barGroups = [];
    final maxCount = partsPerDay.values.reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < sortedDates.length; i++) {
      final count = partsPerDay[sortedDates[i]]!;
      double maxToY = maxCount.toDouble();

      barGroups.add(
        buildBarChartGroupData(i, count, context, maxToY),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConditionalContent(
          condition: title != null,
          primary: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            dense: true,
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColors.withOpacity(.12),
              radius: 12,
              child: Icon(
                Icons.history_rounded,
                size: 20,
                color: AppTheme.primaryColors,
              ),
            ),
            title: Text(title ?? ""),
            subtitle: Text(subTitle ?? ""),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child:
              BarChartBuilder(sortedDates: sortedDates, barGroups: barGroups),
        ),
      ],
    );
  }

  BarChartGroupData buildBarChartGroupData(
      int i, int count, BuildContext context, double maxToY) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: count.toDouble(),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            color: AppTheme.getTheme().disabledColor,
            toY: max(3, maxToY.toDouble()),
          ),
        ),
      ],
    );
  }
}

class BarChartBuilder extends StatelessWidget {
  const BarChartBuilder({
    super.key,
    required this.sortedDates,
    required this.barGroups,
  });

  final List<String> sortedDates;
  final List<BarChartGroupData> barGroups;

  @override
  Widget build(BuildContext context) {
    final interval = computeInterval(context, sortedDates.length);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(value.toString());
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index % interval != 0) {
                  return const SizedBox.shrink();
                }
                final date = sortedDates[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      date,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: barGroups,
        gridData: FlGridData(show: false),
      ),
    );
  }

  double computeInterval(BuildContext context, int totalBars) {
    final width = MediaQuery.of(context).size.width;

    final maxLabels = (width / 60).floor();
    final interval = (totalBars / maxLabels).ceilToDouble();

    return interval.clamp(1, totalBars.toDouble());
  }
}
