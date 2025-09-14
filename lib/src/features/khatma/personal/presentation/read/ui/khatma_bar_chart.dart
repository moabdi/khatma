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
    final parts = _getAllParts();
    final groupedData = _groupPartsByDate(parts);
    final sortedEntries = groupedData.grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final labelFormatter = groupedData.labelFormatter;
    final maxToY = sortedEntries.map((e) => e.value).reduce(max).toDouble();

    final barGroups = sortedEntries.asMap().entries.map((entry) {
      return _buildBarChartGroupData(
          entry.key, entry.value.value, context, maxToY);
    }).toList();

    final labels = sortedEntries.map((e) => labelFormatter(e.key)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConditionalContent(
          condition: title != null,
          primary: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            dense: true,
            leading: CircleAvatar(
              backgroundColor: context.theme.primaryColor.withAlpha(31),
              radius: 12,
              child: Icon(Icons.moving,
                  size: 20, color: context.theme.primaryColor),
            ),
            title: Text(title ?? ""),
            subtitle: Text('Visualisation ${groupedData.mode}'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChartBuilder(sortedDates: labels, barGroups: barGroups),
        ),
      ],
    );
  }

  List<KhatmaPartHistory> _getAllParts() {
    if (khatma.share == null) {
      return khatma.readParts
              ?.where((p) => p.endDate != null)
              .map((p) => KhatmaPartHistory(p.id, p.endDate!))
              .toList() ??
          [];
    }
    final shared = <String, List<KhatmaPartHistory>>{};
    for (final part in khatma.readParts ?? []) {
      if (part.userId != null && part.finishedDate != null) {
        shared.putIfAbsent(part.userId!, () => []);
        shared[part.userId!]!
            .add(KhatmaPartHistory(part.id, part.finishedDate!));
      }
    }
    return shared.values.expand((list) => list).toList();
  }

  BarChartGroupData _buildBarChartGroupData(
      int i, int count, BuildContext context, double maxToY) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: count.toDouble(),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            color: Theme.of(context).disabledColor,
            toY: max(3, maxToY),
          ),
        ),
      ],
    );
  }

  _GroupedParts _groupPartsByDate(List<KhatmaPartHistory> parts) {
    final start = khatma.startDate;
    String mode = 'par jour';
    String Function(DateTime) formatter =
        (d) => DateFormat('dd/MM/yyyy').format(d);

    Map<DateTime, int> groupBy(
        List<KhatmaPartHistory> parts, DateTime Function(DateTime) fn) {
      final map = <DateTime, int>{};
      for (var part in parts) {
        final key = fn(part.endDate);
        map.update(key, (v) => v + 1, ifAbsent: () => 1);
      }
      return map;
    }

    var grouped = groupBy(parts, (d) => DateTime(d.year, d.month, d.day));
    if (grouped.length > 30) {
      grouped = groupBy(parts, (d) {
        final days = d.difference(start).inDays;
        final weekStart = start.add(Duration(days: (days ~/ 7) * 7));
        return DateTime(weekStart.year, weekStart.month, weekStart.day);
      });
      mode = 'par semaine';

      if (grouped.length > 20) {
        grouped = groupBy(parts, (d) => DateTime(d.year, d.month));
        mode = 'par mois';

        if (grouped.length > 30) {
          grouped = groupBy(parts, (d) => DateTime(d.year));
          formatter = (d) => DateFormat('yyyy').format(d);
          mode = 'par an';
        } else {
          final multipleYears =
              grouped.keys.map((d) => d.year).toSet().length > 1;
          formatter =
              (d) => DateFormat(multipleYears ? 'MMM yyyy' : 'MMM').format(d);
        }
      } else {
        final multipleYears =
            grouped.keys.map((d) => d.year).toSet().length > 1;
        formatter = (d) => multipleYears
            ? 'Semaine du ${DateFormat('dd/MM/yyyy').format(d)}'
            : 'Semaine du ${DateFormat('dd/MM').format(d)}';
      }
    } else {
      final multipleYears = grouped.keys.map((d) => d.year).toSet().length > 1;
      formatter =
          (d) => DateFormat(multipleYears ? 'dd/MM/yyyy' : 'dd/MM').format(d);
    }

    return _GroupedParts(grouped, formatter, mode);
  }
}

class _GroupedParts {
  final Map<DateTime, int> grouped;
  final String Function(DateTime) labelFormatter;
  final String mode;

  _GroupedParts(this.grouped, this.labelFormatter, this.mode);
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
    final interval = _computeInterval(context, sortedDates.length);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final index = value.toInt();
                if (index % interval != 0 || index >= sortedDates.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Text(sortedDates[index],
                        style: const TextStyle(fontSize: 10)),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: barGroups,
        gridData: FlGridData(show: false),
      ),
      swapAnimationDuration: const Duration(milliseconds: 800),
      swapAnimationCurve: Curves.easeOutBack,
    );
  }

  double _computeInterval(BuildContext context, int totalBars) {
    final width = MediaQuery.of(context).size.width;
    final maxLabels = (width / 60).floor();
    final interval = (totalBars / maxLabels).ceilToDouble();
    return interval.clamp(1, totalBars.toDouble());
  }
}

class KhatmaPartHistory {
  final int id;
  final DateTime endDate;

  KhatmaPartHistory(this.id, this.endDate);
}
