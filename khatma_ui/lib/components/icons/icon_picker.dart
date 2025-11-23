import 'dart:math';
import 'package:flutter/material.dart';

/// Grid-based icon picker with selection state
///
/// Displays a grid of icons that can be selected.
/// Supports custom icon resolver function and selection highlighting.
class IconPicker extends StatelessWidget {
  const IconPicker({
    super.key,
    required this.iconKeys,
    required this.selectedIconKey,
    required this.onChanged,
    required this.iconResolver,
    this.highlightColor,
    this.columns,
  });

  final List<String> iconKeys;
  final String selectedIconKey;
  final ValueChanged<String> onChanged;
  final Widget Function(String key, {Color? color, double? size}) iconResolver;
  final Color? highlightColor;
  final int? columns;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = highlightColor ?? theme.colorScheme.primary;

    double screenWidth = MediaQuery.of(context).size.width;
    int columnCount = columns ??
        max(min((screenWidth / 60).floor(), 8), 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: iconKeys.length,
      itemBuilder: (context, index) {
        String key = iconKeys[index];
        bool isSelected = key == selectedIconKey;

        return GestureDetector(
          onTap: () => onChanged(key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: effectiveColor.withValues(alpha: 0.3),
                      width: 3,
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: effectiveColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? effectiveColor.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.05),
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 150),
                  scale: isSelected ? 1.1 : 1.0,
                  child: iconResolver(
                    key,
                    color: isSelected
                        ? effectiveColor
                        : Colors.grey.shade600,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
