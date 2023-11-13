import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';

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
      height: 55,
      width: double.infinity,
      child: Card(
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: khatmaColorHexList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => onChanged(khatmaColorHexList[index]),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: color == khatmaColorHexList[index]
                        ? Border.all(
                            color: Theme.of(context).primaryColor, width: 3)
                        : null,
                  ),
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: khatmaColorMap[khatmaColorHexList[index]],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
