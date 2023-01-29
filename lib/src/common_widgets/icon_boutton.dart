import 'package:flutter/material.dart';
import 'package:khatma_app/src/themes/theme.dart';

class CIconButton extends StatelessWidget {
  const CIconButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.enabled = true,
      this.icon});
  final String label;
  final VoidCallback onPressed;
  final bool enabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enabled == true ? onPressed : null,
      icon: Icon(
        icon,
        color: AppTheme.getTheme().primaryColor,
        size: 15,
      ),
      label: Text(label,
          style: AppTheme.getTheme().textTheme.subtitle2!.copyWith(
              color: AppTheme.getTheme().primaryColor,
              fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppTheme.getTheme().disabledColor,
          shadowColor: AppTheme.getTheme().disabledColor.withOpacity(0.1),
          backgroundColor: AppTheme.getTheme().primaryColor.withOpacity(0.1)),
    );
  }
}
