import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? loadingColor;
  final double? width;
  final double height;

  const ActionButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.loadingColor,
    this.width,
    this.height = 48,
  });

  factory ActionButton.primary({
    required String text,
    bool isLoading = false,
    VoidCallback? onPressed,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? loadingColor,
    double? width,
    double height = 48,
  }) {
    return ActionButton(
      text: text,
      isLoading: isLoading,
      onPressed: onPressed,
      isPrimary: true,
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      loadingColor: loadingColor,
      width: width,
      height: height,
    );
  }

  /// Factory for secondary button (outlined)
  factory ActionButton.secondary({
    required String text,
    bool isLoading = false,
    VoidCallback? onPressed,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? loadingColor,
    double? width,
    double height = 48,
  }) {
    return ActionButton(
      text: text,
      isLoading: isLoading,
      onPressed: onPressed,
      isPrimary: false,
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      loadingColor: loadingColor,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildButtonChild(context);

    if (isPrimary) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      );
    } else {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      );
    }
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            loadingColor ??
                (isPrimary
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}
