import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khatma/src/common_widgets/icon_boutton.dart';
import 'package:khatma/src/drawer/main_drawer.dart';
import 'package:khatma/src/common_widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_list/katmat_grid.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common_widgets/responsive_center.dart';
import 'package:khatma/src/constants/app_sizes.dart';
import 'package:khatma/src/features/kpi/presentation/top_card.dart';
import 'package:khatma/src/themes/theme.dart';

/// Shows the list of khatmas with a search field at the top.
class KhatmatListScreen extends StatefulWidget {
  const KhatmatListScreen({super.key});

  @override
  State<KhatmatListScreen> createState() => _KhatmatListScreenState();
}

class _KhatmatListScreenState extends State<KhatmatListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F5F5F8"),
      drawer: const MainDrawer(),
      appBar: const KAppBar(title: "Home"),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopCard(),
                gapH20,
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Khatma liste",
                      style: AppTheme.getTheme().textTheme.subtitle1,
                    ),
                    CIconButton(
                        icon: FontAwesomeIcons.plus,
                        label: "Nouvelle khatma",
                        onPressed: () => {}),
                  ],
                ),
                const SizedBox(height: 10),
                const KhatmatGrid(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
