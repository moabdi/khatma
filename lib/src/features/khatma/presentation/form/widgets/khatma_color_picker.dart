import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaColorPicker extends StatelessWidget {
  const KhatmaColorPicker({
    super.key,
    this.color = Colors.transparent,
    required this.onChanged,
  });

  final Color? color;
  final ValueChanged<Color> onChanged;

  static List<Color> colors = <Color>[
    Colors.transparent,
    AppTheme.getTheme().primaryColor,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.blueGrey,
    Colors.black,
  ];

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
        itemCount: KhatmaColorPicker.colors.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: CircleAvatar(
              maxRadius: 10,
              minRadius: 5,
              backgroundImage: index == 0
                  ? const AssetImage('assets/images/forbidden.png')
                  : null,
              backgroundColor: KhatmaColorPicker.colors[index],
              child: KhatmaColorPicker.colors[index] == color
                  ? const Icon(Icons.check)
                  : null,
            ),
            onTap: () => onChanged(KhatmaColorPicker.colors[index]),
          ),
        ),
      ),
    );
  }

  int calculateColumns(BuildContext context, int factor) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / factor).floor();

    return columns > 0 ? columns : 1;
  }
}
