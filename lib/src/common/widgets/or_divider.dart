import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Ou', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
