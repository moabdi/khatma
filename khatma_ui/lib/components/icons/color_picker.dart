import 'package:flutter/material.dart';

/// Horizontal scrolling color picker
///
/// Displays a horizontal list of color circles for selection.
/// Perfect for theme or color customization UIs.
class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onChanged,
    this.height = 70.0,
    this.circleSize = 52.0,
    this.spacing = 12.0,
  });

  final List<Color> colors;
  final Color? selectedColor;
  final ValueChanged<Color> onChanged;
  final double height;
  final double circleSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: colors.length,
        separatorBuilder: (context, index) => SizedBox(width: spacing),
        itemBuilder: (BuildContext context, int index) {
          final color = colors[index];
          final isSelected = selectedColor == color;

          return GestureDetector(
            onTap: () => onChanged(color),
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Colors.grey.shade300,
                        width: 3,
                      )
                    : null,
              ),
              child: Container(
                margin: const EdgeInsets.all(5),
                width: circleSize - 10,
                height: circleSize - 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Horizontal scrolling color picker with hex color strings
///
/// Similar to ColorPicker but works with hex color strings.
/// Useful when colors are stored as hex strings in data.
class HexColorPicker extends StatelessWidget {
  const HexColorPicker({
    super.key,
    required this.colorHexMap,
    required this.selectedHex,
    required this.onChanged,
    this.height = 70.0,
    this.circleSize = 52.0,
    this.spacing = 12.0,
  });

  final Map<String, Color> colorHexMap;
  final String? selectedHex;
  final ValueChanged<String> onChanged;
  final double height;
  final double circleSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final hexKeys = colorHexMap.keys.toList();

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: hexKeys.length,
        separatorBuilder: (context, index) => SizedBox(width: spacing),
        itemBuilder: (BuildContext context, int index) {
          final hexKey = hexKeys[index];
          final color = colorHexMap[hexKey]!;
          final isSelected = selectedHex == hexKey;

          return GestureDetector(
            onTap: () => onChanged(hexKey),
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Colors.grey.shade300,
                        width: 3,
                      )
                    : null,
              ),
              child: Container(
                margin: const EdgeInsets.all(5),
                width: circleSize - 10,
                height: circleSize - 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
