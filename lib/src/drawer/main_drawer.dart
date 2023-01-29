import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Do something when item 1 is tapped
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Do something when item 2 is tapped
            },
          ),
        ],
      ),
    );
  }
}
