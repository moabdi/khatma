import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingListTile(),
    );
  }
}
