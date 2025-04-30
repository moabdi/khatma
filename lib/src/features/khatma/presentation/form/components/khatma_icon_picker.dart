import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

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
    int columns = max(min((screenWidth / 60).floor(), 10), 1);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: imagesNames.length,
      itemBuilder: (context, index) {
        String key = imagesNames[index];
        return InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => onChanged(key),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: key == style.icon
                  ? HexColor(style.color).withOpacity(.5)
                  : Colors.transparent,
              child: getIcon(key, color: HexColor(style.color), size: 26),
            ),
          ),
        );
      },
    );
  }
}
