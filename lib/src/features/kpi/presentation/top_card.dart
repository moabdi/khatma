import 'package:flutter/material.dart';
import 'package:khatma/src/features/kpi/presentation/reading_chart.dart';
import 'package:khatma/src/themes/theme.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomLeft,
            colors: [
              AppTheme.getTheme().primaryColor.withOpacity(.2),
              AppTheme.getTheme().primaryColor.withOpacity(.7),
            ],
          ),
          //borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ReadingChart(),
            Opacity(
              opacity: 0.2,
              child: Image.asset("assets/images/hifdz.png", fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(
      {required Icon icon, required String title, required int count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppTheme.getTheme().backgroundColor.withOpacity(0.5),
          radius: 25,
          child: icon,
        ),
        Text(
          count.toString(),
          style: AppTheme.getTheme()
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
