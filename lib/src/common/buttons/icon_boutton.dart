import 'package:flutter/material.dart';

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
        color: Theme.of(context).primaryColor,
        size: 15,
      ),
      label: Text(label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Theme.of(context).disabledColor,
          shadowColor: Theme.of(context).disabledColor.withOpacity(0.1),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1)),
    );
  }
}
