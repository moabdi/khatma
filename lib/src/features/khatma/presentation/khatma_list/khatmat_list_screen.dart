import 'package:khatma_app/src/features/khatma/presentation/khatma_list/top_khatma_card.dart';
import 'package:khatma_app/src/features/khatma/presentation/home_app_bar/home_app_bar.dart';
import 'package:khatma_app/src/features/khatma/presentation/khatma_list/katmat_grid.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/common_widgets/responsive_center.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';

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
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p12),
            child: Column(
              children: const[
                SizedBox(height: 10),
                TopKhatmaCard(),
                SizedBox(height: 50),
                KhatmatGrid(),
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
