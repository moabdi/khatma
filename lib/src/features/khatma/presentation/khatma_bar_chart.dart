import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';

class KhatmaBarChart extends StatelessWidget {
  final KhatmaHistory khatma;

  const KhatmaBarChart({super.key, required this.khatma});

  @override
  Widget build(BuildContext context) {
    final List<KhatmaPartHistory> allParts = khatma.map(
      private: (p) => p.parts,
      shared: (s) => s.parts.values.expand((list) => list).toList(),
    );

    final Map<String, int> partsPerDay = {};
    for (final part in allParts) {
      final dateStr = DateFormat('yyyy-MM-dd').format(part.endDate);
      partsPerDay.update(dateStr, (val) => val + 1, ifAbsent: () => 1);
    }

    final sortedDates = partsPerDay.keys.toList()..sort();
    final List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < sortedDates.length; i++) {
      final count = partsPerDay[sortedDates[i]]!;
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: count.toDouble(), color: Colors.teal),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📖 Khatma Progress Chart',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= sortedDates.length) {
                        return const SizedBox.shrink();
                      }
                      final date = sortedDates[index];
                      return Text(
                        DateFormat('MM/dd').format(DateTime.parse(date)),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
              barGroups: barGroups,
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
