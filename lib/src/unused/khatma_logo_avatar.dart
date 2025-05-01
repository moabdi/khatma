import 'package:flutter/material.dart';

class KhatmaLogoAvatar extends StatelessWidget {
  const KhatmaLogoAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).disabledColor,
      radius: 50,
      backgroundImage: const AssetImage('assets/khatma.png'),
    );
  }
}
