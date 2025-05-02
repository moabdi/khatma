import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReadingChart extends StatefulWidget {
  const ReadingChart({super.key, required this.data});
  final List<Point<double>> data;

  @override
  State<ReadingChart> createState() => _ReadingChartState();
}

class _ReadingChartState extends State<ReadingChart> {
  late List<Color> gradientColors;
  late Color gridLineColor;
  late Color borderColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    gradientColors = [
      theme.colorScheme.primary.withOpacity(0.1),
      theme.colorScheme.primary.withOpacity(0.4),
    ];
    gridLineColor = theme.colorScheme.surfaceVariant;
    borderColor = theme.disabledColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 0,
              bottom: 0,
              right: 70,
            ),
            child: LineChart(mainData(widget.data)),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<Point<double>> data) {
    return LineChartData(
      titlesData: FlTitlesData(show: false),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: gridLineColor, strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: gridLineColor, strokeWidth: 1);
        },
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: borderColor),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: data.map((p) => FlSpot(p.x, p.x)).toList(),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (FlSpot flSpot, double padding,
                LineChartBarData barData, int index) {
              return FlDotCirclePainter(
                color: Colors.transparent,
                strokeColor: Colors.transparent,
                radius: 2,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: gradientColors),
          ),
        ),
      ],
    );
  }
}
