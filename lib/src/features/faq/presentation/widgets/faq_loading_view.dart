import 'package:flutter/material.dart';

class FaqLoadingView extends StatelessWidget {
  const FaqLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
