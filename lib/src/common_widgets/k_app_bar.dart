import 'package:flutter/services.dart';
import 'package:khatma/src/common_widgets/text_or_empty.dart';
import 'package:khatma/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/themes/theme.dart';

/// Custom [AppBar] widget that is reused by the [KhatmatListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class KAppBar extends ConsumerWidget with PreferredSizeWidget {
  const KAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: AppBar(
        title: TextOrEmpty(title),
        leading: leading,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
