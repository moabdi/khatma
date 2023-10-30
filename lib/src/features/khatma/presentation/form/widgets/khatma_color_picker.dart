import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaColorPicker extends StatelessWidget {
  const KhatmaColorPicker({
    super.key,
    this.color,
    required this.onChanged,
  });

  final String? color;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = max(min((screenWidth / 45).floor(), 12), 1);

    return Flexible(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        shrinkWrap: true,
        itemCount: khatmaColorHexList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => onChanged(khatmaColorHexList[index]),
            child: CircleAvatar(
              maxRadius: 10,
              minRadius: 5,
              backgroundImage: index == 0
                  ? const AssetImage('assets/images/forbidden.png')
                  : null,
              backgroundColor: khatmaColorHexList[index].toColor(),
              child: khatmaColorHexList[index] == color
                  ? index == 0
                      ? Container(color: Colors.white70)
                      : const Icon(Icons.check)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
