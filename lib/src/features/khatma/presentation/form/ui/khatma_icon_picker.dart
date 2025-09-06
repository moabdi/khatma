import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_images.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

class KhatmaIconPicker extends StatelessWidget {
  const KhatmaIconPicker({
    super.key,
    required this.style,
    required this.onChanged,
  });

  final KhatmaTheme style;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns =
        max(min((screenWidth / 60).floor(), 8), 3); // Better column calculation

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevent scrolling conflicts
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0, // Ensure perfect squares
      ),
      padding: const EdgeInsets.all(16),
      itemCount: imagesNames.length,
      itemBuilder: (context, index) {
        String key = imagesNames[index];
        bool isSelected = key == style.icon;
        Color themeColor = HexColor(style.color);

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
                      color: themeColor.withOpacity(0.3),
                      width: 3,
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: themeColor.withOpacity(0.2),
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
                    ? themeColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.05),
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 150),
                  scale: isSelected ? 1.1 : 1.0,
                  child: getIcon(
                    key,
                    color: isSelected ? themeColor : Colors.grey.shade600,
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
