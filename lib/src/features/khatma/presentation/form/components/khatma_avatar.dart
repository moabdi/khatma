import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';

class KhatmaAvatar extends StatelessWidget {
  const KhatmaAvatar({
    super.key,
    required this.style,
  });

  final KhatmaStyle style;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: HexColor(style.color).withOpacity(.2),
      child: Stack(children: [
        Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
                child: getImage(style.icon, color: HexColor(style.color))),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: HexColor(style.color),
            child: const Icon(Icons.brush, size: 12),
          ),
        ),
      ]),
    );
  }
}
