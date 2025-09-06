import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? leadingColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.titleColor,
    this.subtitleColor,
    this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      leading: Icon(
        icon,
        color: leadingColor,
      ),
      title: Text(
        title,
        style: context.theme.listTileTheme.titleTextStyle!
            .copyWith(color: titleColor, fontSize: 17),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.theme.listTileTheme.subtitleTextStyle!
                  .copyWith(color: subtitleColor, fontSize: 15),
            )
          : null,
      onTap: onTap,
    );
  }
}
