import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

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
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: khatmaColorHexList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final isSelected = color == khatmaColorHexList[index];
          final colorValue = khatmaColorMap[khatmaColorHexList[index]]!;

          return GestureDetector(
            onTap: () => onChanged(khatmaColorHexList[index]),
            child: Container(
              width: 52,
              height: 52,
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
                margin: isSelected
                    ? const EdgeInsets.all(5)
                    : const EdgeInsets.all(5),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colorValue,
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
