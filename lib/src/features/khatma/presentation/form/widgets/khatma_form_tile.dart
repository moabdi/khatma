import 'package:flutter/material.dart';

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
  final Widget subtitle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: subtitle,
      onTap: onTap,
      trailing: const Icon(Icons.arrow_right),
    );
  }
}
