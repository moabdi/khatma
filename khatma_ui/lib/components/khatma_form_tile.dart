import 'package:flutter/material.dart';

class KhatmaFormTile extends StatelessWidget {
  const KhatmaFormTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  final Icon icon;
  final String title;
  final Widget subtitle;
  final GestureTapCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        enabled: enabled,
        leading: icon,
        title: Text(title),
        subtitle: subtitle,
        onTap: onTap,
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
