import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/constants/app_sizes.dart';
import 'package:khatma/src/features/home/presentation/header/top_card.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    required this.height,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(.01),
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: AppBar(
        leading: leading,
        actions: actions,
        title: Logo(title: title),
        bottom: PreferredSize(
          preferredSize: preferredSize,
          child: TopCard(height: height / 2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
