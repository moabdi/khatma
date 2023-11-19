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
    return Card(
      elevation: 0.1,
      color: Theme.of(context).dividerColor,
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: subtitle,
        onTap: onTap,
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
