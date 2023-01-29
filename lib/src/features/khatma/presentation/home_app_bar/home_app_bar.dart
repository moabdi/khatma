import 'package:khatma_app/src/common_widgets/text_or_empty.dart';
import 'package:khatma_app/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Custom [AppBar] widget that is reused by the [KhatmatListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          right: 10,
        ),
        child: AppBar(
          title: TextOrEmpty(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Perform action for back button
            },
          ),
          actions: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.description),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.bar_chart),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
