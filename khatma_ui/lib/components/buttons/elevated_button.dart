import 'package:flutter/material.dart';

class KElevatedButton extends StatelessWidget {
  const KElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.enabled = false,
    this.width = double.infinity,
  });

  final Widget? child;
  final VoidCallback? onPressed;
  final bool enabled;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: enabled ? () => onPressed : null,
        child: child,
      ),
    );
  }
}
