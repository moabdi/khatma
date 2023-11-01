import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/drawer/main_drawer.dart';
import 'package:khatma/src/common/widgets/k_app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/list/katmat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/kpi/presentation/top_card.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

/// Shows the list of khatmas with a search field at the top.
class KhatmatListScreen extends StatelessWidget {
  const KhatmatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MainDrawer(),
      appBar: KAppBar(title: AppLocalizations.of(context).appTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const TopCard(),
              gapH20,
              const Divider(height: 0),
              gapH8,
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#f7fcfd"),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).khatmaList,
                          style: AppTheme.getTheme().textTheme.titleSmall,
                        ),
                        IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppTheme.getTheme()
                                    .primaryColor
                                    .withOpacity(.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.add_circle,
                                color: AppTheme.primaryColors,
                                size: 24,
                              ),
                            ),
                            onPressed: () =>
                                {context.goNamed(AppRoute.khatma.name)}),
                      ],
                    ),
                    gapH8,
                    const KhatmatListView(),
                  ],
                ),
              ),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: AppLocalizations.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: AppLocalizations.of(context).quran,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: AppLocalizations.of(context).create,
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
