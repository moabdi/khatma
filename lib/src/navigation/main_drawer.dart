import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Do something when item 1 is tapped
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Do something when item 2 is tapped
            },
          ),
        ],
      ),
    );
  }
}
