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
      height: 60,
      width: double.infinity,
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: khatmaColorHexList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  splashColor:
                      khatmaColorMap[khatmaColorHexList[index]]!.withAlpha(26),
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => onChanged(khatmaColorHexList[index]),
                  child: Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: color == khatmaColorHexList[index]
                          ? Border.all(
                              color: Theme.of(context).primaryColor, width: 3)
                          : null,
                    ),
                    width: 50,
                    height: 50,
                    child: Container(
                      width: 42,
                      height: 42,
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
      ),
    );
  }
}
