import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class ReadingChart extends StatefulWidget {
  const ReadingChart({super.key});

  @override
  State<ReadingChart> createState() => _ReadingChartState();
}

class _ReadingChartState extends State<ReadingChart> {
  List<Color> gradientColors = [
    AppTheme.getTheme().backgroundColor.withOpacity(0.1),
    AppTheme.getTheme().backgroundColor.withOpacity(0.4),
  ];

  final dataMain = const [
    FlSpot(0, 3),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
    FlSpot(12, 3),
    FlSpot(13, 2),
    FlSpot(14, 5),
    FlSpot(15, 3.1),
    FlSpot(16, 4),
    FlSpot(17, 3),
    FlSpot(18, 0),
  ];

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
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: false,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.getTheme().backgroundColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.getTheme().backgroundColor,
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: AppTheme.getTheme().disabledColor),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: dataMain,
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
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
