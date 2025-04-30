import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/read/components/khatma_bar_chart.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class BarChartSample extends StatefulWidget {
  BarChartSample({
    super.key,
    required this.title,
    required this.subTitle,
    required this.khatma,
    this.barBackgroundColor = Colors.grey,
    this.barColor = Colors.blue,
    this.touchedBarColor = Colors.orange,
  });

  final Khatma khatma;
  final String title;
  final String subTitle;

  final Color barBackgroundColor;
  final Color barColor;
  final Color touchedBarColor;

  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  gapW12,
                  CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(.12),
                    radius: 12,
                    child: Center(
                      child: Icon(
                        Icons.trending_up,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              gapH2,
              Text(
                widget.subTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).dividerColor),
              ),
              gapH8,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: KhatmaBarChart(khatma: widget.khatma),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
