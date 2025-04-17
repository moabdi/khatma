import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/conditional_content.dart';

class KhatmaBarChart extends StatelessWidget {
  final Khatma khatma;
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
    List<KhatmaPartHistory> allParts = getAllParts();

    final start = khatma.startDate;
    Map<DateTime, int> partsGrouped = {};
    String Function(DateTime) labelFormatter =
        (d) => DateFormat('dd/MM/yyyy').format(d);
    String visualizationMode = 'par jour';

    Map<DateTime, int> _groupBy(
      List<KhatmaPartHistory> parts,
      DateTime Function(DateTime) keyFn,
    ) {
      final map = <DateTime, int>{};
      for (final part in parts) {
        final key = keyFn(part.endDate);
        map.update(key, (val) => val + 1, ifAbsent: () => 1);
      }
      return map;
    }

    partsGrouped = _groupBy(allParts, (d) => DateTime(d.year, d.month, d.day));

    if (partsGrouped.length > 30) {
      partsGrouped = _groupBy(allParts, (d) {
        final daysSinceStart = d.difference(start).inDays;
        final weekStart = start.add(Duration(days: (daysSinceStart ~/ 7) * 7));
        return DateTime(weekStart.year, weekStart.month, weekStart.day);
      });
      visualizationMode = 'par semaine';

      if (partsGrouped.length > 20) {
        partsGrouped = _groupBy(allParts, (d) => DateTime(d.year, d.month));
        visualizationMode = 'par mois';

        if (partsGrouped.length > 30) {
          partsGrouped = _groupBy(allParts, (d) => DateTime(d.year));
          labelFormatter = (d) => DateFormat('yyyy').format(d);
          visualizationMode = 'par an';
        } else {
          final years = partsGrouped.keys.map((d) => d.year).toSet();
          labelFormatter = (d) => years.length > 1
              ? DateFormat('MMM yyyy').format(d)
              : DateFormat('MMM').format(d);
        }
      } else {
        final years = partsGrouped.keys.map((d) => d.year).toSet();
        labelFormatter = (d) => years.length > 1
            ? 'Semaine du ${DateFormat('dd/MM/yyyy').format(d)}'
            : 'Semaine du ${DateFormat('dd/MM').format(d)}';
      }
    } else {
      final years = partsGrouped.keys.map((d) => d.year).toSet();
      labelFormatter = (d) => years.length > 1
          ? DateFormat('dd/MM/yyyy').format(d)
          : DateFormat('dd/MM').format(d);
    }

    final sortedEntries = partsGrouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final sortedDates =
        sortedEntries.map((e) => labelFormatter(e.key)).toList();

    final maxToY = sortedEntries.map((e) => e.value).reduce(max).toDouble();

    final barGroups = sortedEntries
        .asMap()
        .entries
        .map((entry) => buildBarChartGroupData(
              entry.key,
              entry.value.value,
              context,
              maxToY,
            ))
        .toList();

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
                Icons.moving,
                size: 20,
                color: AppTheme.primaryColors,
              ),
            ),
            title: Text(title ?? ""),
            subtitle: Text('Visualisation $visualizationMode'),
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

  List<KhatmaPartHistory> getAllParts() {
    List<KhatmaPartHistory> allParts;

    if (khatma.share == null) {
      allParts = khatma.readParts
              ?.where((p) => p.endDate != null)
              .map((p) => KhatmaPartHistory(p.id, p.endDate!))
              .toList() ??
          [];
    } else {
      final sharedParts = <String, List<KhatmaPartHistory>>{};
      for (final part in khatma.readParts ?? []) {
        if (part.userId != null && part.finishedDate != null) {
          sharedParts.putIfAbsent(part.userId!, () => []);
          sharedParts[part.userId!]!.add(
            KhatmaPartHistory(part.id, part.finishedDate!),
          );
        }
      }

      allParts = sharedParts.values.expand((list) => list).toList();
    }
    return allParts;
  }

  BarChartGroupData buildBarChartGroupData(
      int i, int count, BuildContext context, double maxToY) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          // color: Theme.of(context).primaryColor.withOpacity(.5),
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
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index % interval != 0 || index >= sortedDates.length) {
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

class KhatmaPartHistory {
  final int id;
  final DateTime endDate;
  KhatmaPartHistory(
    this.id,
    this.endDate,
  );
}
