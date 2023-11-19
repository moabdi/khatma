import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final Color? color;
  final bool? isSelected;
  final Function(Color)? onTap;

  const ColorSelector({
    Key? key,
    this.color,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color _selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        ListTile(title: Text('Colour')),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              List<Color> colorList = [
                Colors.blue,
                Colors.purple,
                Colors.pink,
                Colors.teal,
                Colors.orange,
              ];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = colorList[index];
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: colorList[index],
                    shape: BoxShape.circle,
                    border: _selectedColor == colorList[index]
                        ? Border.all(color: Colors.black, width: 3)
                        : null,
                  ),
                  width: 40,
                  height: 40,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
