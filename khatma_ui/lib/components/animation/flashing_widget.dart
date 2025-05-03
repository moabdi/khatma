import 'package:flutter/material.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

class FlashingListTile extends StatefulWidget {
  final Widget child;
  final Duration flashDuration;
  final Color color;

  const FlashingListTile(
      {super.key,
      required this.child,
      this.flashDuration = const Duration(milliseconds: 1000),
      this.color = Colors.amber});

  @override
  State<FlashingListTile> createState() => _FlashingListTileState();
}

class _FlashingListTileState extends State<FlashingListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.flashDuration,
    );

    _colorAnimation = ColorTween(
      begin: widget.color.applyOpacity(0.6),
      end: Colors.transparent,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) => Container(
        color: _colorAnimation.value,
        child: widget.child,
      ),
    );
  }
}
