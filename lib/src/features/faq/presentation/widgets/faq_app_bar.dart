import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class FaqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;

  const FaqAppBar({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(context.loc.faq),
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: context.loc.refresh,
          onPressed: onRefresh,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
