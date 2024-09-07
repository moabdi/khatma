import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:khatma/src/common/providers/linear_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/constants/app_sizes.dart';
import 'package:khatma/src/features/common/top_card.dart';

/// Custom [AppBar] widget that is reused by the [KhatmatListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          Image.asset(
            "assets/images/khatma/khatma.png",
            width: 32,
          ),
          gapW12,
          AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              ColorizeAnimatedText(
                title ?? "",
                textStyle: Theme.of(context).textTheme.titleMedium!,
                colors: [Colors.yellowAccent, Theme.of(context).primaryColor],
              ),
            ],
          ),
        ],
      ),
      leading: leading,
      actions: actions,
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Consumer(
            builder: (context, ref, _) {
              return ref.read(boolNotifierProvider)
                  ? LinearProgressIndicator()
                  : TopCard();
            },
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300.0);
}
