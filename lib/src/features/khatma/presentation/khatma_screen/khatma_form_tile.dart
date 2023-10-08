import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaFormTile extends StatelessWidget {
  const KhatmaFormTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: icon,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_right),
    );
  }
}
