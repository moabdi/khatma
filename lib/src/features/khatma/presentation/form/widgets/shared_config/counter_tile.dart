import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatma/src/themes/theme.dart';

/// A reusable counter tile with +/- buttons and direct input
///
/// Can be used for any numeric setting with min/max bounds
class CounterTile extends StatelessWidget {
  const CounterTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.leadingIconColor,
    this.isOptional = false,
    this.minValue = 1,
    this.maxValue = 99,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final int value;
  final ValueChanged<int> onChanged;
  final Color? leadingIconColor;
  final bool isOptional;
  final int minValue;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: value == 0 && isOptional ? '' : value.toString(),
    );
    final effectiveLeadingIconColor =
        leadingIconColor ?? context.colorScheme.primary;
    final effectiveBackgroundColor = leadingIconColor != null
        ? leadingIconColor!.withValues(alpha: 0.15)
        : context.colorScheme.primaryContainer;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: effectiveBackgroundColor,
        child: Icon(icon, color: effectiveLeadingIconColor),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: context.textTheme.bodySmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: value > (isOptional ? 0 : minValue)
                ? () => onChanged(value - 1)
                : null,
            color: context.colorScheme.primary,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
              onChanged: (text) {
                if (text.isEmpty && isOptional) {
                  onChanged(0);
                } else {
                  final newValue = int.tryParse(text);
                  if (newValue != null &&
                      newValue >= (isOptional ? 0 : minValue) &&
                      newValue <= maxValue) {
                    onChanged(newValue);
                  }
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
            color: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
