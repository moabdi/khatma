import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/domain/khatma_extention.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimatedKhatmaChart extends StatefulWidget {
  final Khatma khatma;

  const AnimatedKhatmaChart({Key? key, required this.khatma}) : super(key: key);

  @override
  State<AnimatedKhatmaChart> createState() => _AnimatedKhatmaChartState();
}

class _AnimatedKhatmaChartState extends State<AnimatedKhatmaChart> {
  double _previousPercent = 0.0;

  @override
  void didUpdateWidget(covariant AnimatedKhatmaChart oldWidget) {
    if (oldWidget.khatma.completionPercent != widget.khatma.completionPercent) {
      _previousPercent = oldWidget.khatma.completionPercent;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
          begin: _previousPercent, end: widget.khatma.completionPercent),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, _) {
        return CircularPercentIndicator(
          radius: 20.0,
          lineWidth: 4,
          percent: value,
          center: Text(
            "${(value * 100).toStringAsFixed(0)}%",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
          ),
          progressColor: widget.khatma.style.hexColor,
          backgroundColor: widget.khatma.style.hexColor.withOpacity(.2),
        );
      },
    );
  }
}
