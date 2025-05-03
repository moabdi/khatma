import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_extention.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimatedFlashyChart extends StatefulWidget {
  final Khatma khatma;

  const AnimatedFlashyChart({super.key, required this.khatma});

  @override
  State<AnimatedFlashyChart> createState() => _AnimatedFlashyChartState();
}

class _AnimatedFlashyChartState extends State<AnimatedFlashyChart>
    with SingleTickerProviderStateMixin {
  double _oldPercent = 0.0;
  bool _flash = false;
  double _scale = 1.0;

  @override
  void didUpdateWidget(covariant AnimatedFlashyChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.khatma.completionPercent != widget.khatma.completionPercent) {
      _oldPercent = oldWidget.khatma.completionPercent;
      _triggerFlash();
    }
  }

  void _triggerFlash() async {
    setState(() {
      _flash = true;
      _scale = 1.1;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => _flash = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _flash ? Colors.amber.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: _oldPercent,
            end: widget.khatma.completionPercent,
          ),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
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
        ),
      ),
    );
  }
}
