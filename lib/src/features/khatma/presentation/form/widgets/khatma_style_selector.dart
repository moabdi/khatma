import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaStyleSelector extends StatefulWidget {
  const KhatmaStyleSelector({super.key, required this.onChanged, this.style});

  final KhatmaStyle? style;
  final ValueChanged<KhatmaStyle> onChanged;

  @override
  State<KhatmaStyleSelector> createState() => _KhatmaStyleSelectorState();
}

class _KhatmaStyleSelectorState extends State<KhatmaStyleSelector> {
  static List<Color> colors = <Color>[
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

  late KhatmaStyle updatedStyle;

  @override
  void initState() {
    updatedStyle = widget.style ??
        KhatmaStyle(
            color: AppTheme.getTheme().primaryColor.toHex(),
            icon: "khatma.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int columnsIcons = calculateColumns(context, 60);
    int columnsColors = calculateColumns(context, 45);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TopBarBottomSheet(),
          Text("Choose Color:",
              style: AppTheme.getTheme().textTheme.titleSmall),
          gapH20,
          _buildColor(columnsColors),
          gapH20,
          Text(
            "Choose Icon:",
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapH20,
          _buildImagesAndIcons(columnsIcons),
          gapH20,
          const Divider(),
          buildSave(),
        ],
      ),
    );
  }

  Flexible _buildColor(int columnsColors) {
    return Flexible(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnsColors > 12 ? 12 : columnsColors,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        shrinkWrap: true,
        itemCount: colors.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: CircleAvatar(
              maxRadius: 10,
              minRadius: 5,
              backgroundColor: colors[index],
              child: colors[index].toHex() == updatedStyle.color
                  ? const Icon(Icons.check)
                  : null,
            ),
            onTap: () => setState(() => updatedStyle =
                updatedStyle.copyWith(color: colors[index].toHex())),
          ),
        ),
      ),
    );
  }

  Flexible _buildImagesAndIcons(int columns) {
    return Flexible(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns > 10 ? 10 : columns,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: imagesNames.length,
        itemBuilder: (context, index) {
          String key = imagesNames[index];
          return InkWell(
            onTap: () {
              setState(() {
                updatedStyle = updatedStyle.copyWith(icon: key);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: key == updatedStyle.icon
                    ? HexColor(updatedStyle.color).withOpacity(.2)
                    : Colors.grey.shade50,
                child: getImage(key,
                    color: HexColor(updatedStyle.color), size: 26),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildSave() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
            widget.onChanged(updatedStyle);
            Navigator.pop(context);
          },
          child: const Text('Apply'),
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
