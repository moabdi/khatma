import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khatma/src/common_widgets/icon_boutton.dart';
import 'package:khatma/src/drawer/main_drawer.dart';
import 'package:khatma/src/common_widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_list/katmat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/constants/app_sizes.dart';
import 'package:khatma/src/features/kpi/presentation/top_card.dart';
import 'package:khatma/src/themes/theme.dart';

/// Shows the list of khatmas with a search field at the top.
class KhatmatListScreen extends StatelessWidget {
  const KhatmatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F5F5F8"),
      drawer: const MainDrawer(),
      appBar: const KAppBar(title: "Home"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
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
              const KhatmatListView(),
            ],
          ),
        ),
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
