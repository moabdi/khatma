import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaStyleSelector extends StatefulWidget {
  const KhatmaStyleSelector({super.key, required this.onChanged, this.style});

  final KhatmaStyle? style;
  final ValueChanged<String> onChanged;

  @override
  State<KhatmaStyleSelector> createState() => _KhatmaStyleSelectorState();
}

class _KhatmaStyleSelectorState extends State<KhatmaStyleSelector> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  List<Color> colors = [
    Colors.red.shade400,
    Colors.pink,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    int columns = calculateColumns(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TopBarBottomSheet(),
          gapH20,
          Text("Choose Color:"),
          gapH20,
          Flexible(
            child: GridView.builder(
              //physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns > 10 ? 10 : columns,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: colors[index],
                  // child: Icon(Icons.check),
                ),
              ),
            ),
          ),
          gapH20,
          Text(
            "Choose Icon:",
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapH20,
          _buildImagesAndIcons(columns),
        ],
      ),
    );
  }

  Flexible _buildImagesAndIcons(int columns) {
    return Flexible(
      child: GridView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns > 9 ? 9 : columns,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: imagesNames.length,
        itemBuilder: (context, index) {
          String key = imagesNames[index];
          return InkWell(
            onTap: () {
              widget.onChanged(key);
              Navigator.pop(context);
            },
            child: Container(
              color: key == widget.style?.icon
                  ? AppTheme.getTheme().primaryColor
                  : AppTheme.getTheme().disabledColor,
              padding: const EdgeInsets.all(15),
              child: FittedBox(child: getImage(key)),
            ),
          );
        },
      ),
    );
  }

  int calculateColumns(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / 60).floor();

    return columns > 0 ? columns : 1;
  }
}
