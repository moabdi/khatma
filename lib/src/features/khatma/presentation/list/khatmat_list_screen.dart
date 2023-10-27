import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/widgets/icon_boutton.dart';
import 'package:khatma/src/drawer/main_drawer.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/list/katmat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/kpi/presentation/top_card.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:go_router/go_router.dart';

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
                    style: AppTheme.getTheme().textTheme.titleMedium,
                  ),
                  CIconButton(
                      icon: FontAwesomeIcons.plus,
                      label: "Nouvelle khatma",
                      onPressed: () => {context.goNamed(AppRoute.khatma.name)}),
                ],
              ),
              gapH20,
              //ThemeTextStyle(),
              gapH20,
              const KhatmatListView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.getTheme().disabledColor,
        unselectedLabelStyle:
            AppTheme.getTheme().textTheme.labelSmall!.copyWith(fontSize: 10),
        selectedLabelStyle:
            AppTheme.getTheme().textTheme.labelSmall!.copyWith(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Mushaf',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
        ],
        onTap: (value) => {
          if (value == 0)
            {context.goNamed(AppRoute.home.name)}
          else if (value == 1)
            {
              context.goNamed(
                AppRoute.quran.name,
                pathParameters: {'idSourat': "1", 'idVerset': "1"},
              ),
            }
          else if (value == 2)
            {context.goNamed(AppRoute.khatma.name)}
        },
      ),
    );
  }
}

class ThemeTextStyle extends StatelessWidget {
  const ThemeTextStyle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Display Large Text",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            "Display Medium Text",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "Display Small Text",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            "Headline Medium Text",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Headline Small Text",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            "Title Large Text",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Title Medium Text",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Title Small Text",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            "Body Large Text",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Body Medium Text",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Label Large Text",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            "Body Small Text",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            "Label Small Text",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
