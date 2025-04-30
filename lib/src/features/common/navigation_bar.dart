import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedLabelStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 11, fontWeight: FontWeight.w600);

    var unselectedLabelStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 11, fontWeight: FontWeight.w600);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //backgroundColor: Theme.of(context).disabledColor,
      fixedColor: Theme.of(context).primaryColor,
      unselectedLabelStyle: unselectedLabelStyle,
      selectedLabelStyle: selectedLabelStyle,
      items: <BottomNavigationBarItem>[
        item(context,
            icon: Icons.home_filled, label: AppLocalizations.of(context).home),
        item(context,
            icon: FontAwesomeIcons.book,
            label: AppLocalizations.of(context).quran),
        item(context,
            icon: Icons.add_box_outlined,
            label: AppLocalizations.of(context).create),
        item(context, icon: Icons.person, label: "Profil"),
      ],
      onTap: (value) {
        switch (value) {
          case 0:
            context.goNamed(AppRoute.home.name);
            break;
          case 1:
            context.goNamed(
              AppRoute.quran.name,
              pathParameters: {'idSourat': "1", 'idVerset': "1"},
            );
            break;
          case 2:
            context.goNamed(AppRoute.addKhatma.name);
            break;
          case 3:
            context.goNamed(AppRoute.profil.name);
            break;
        }
      },
    );
  }

  void addKhatma(BuildContext context) =>
      context.goNamed(AppRoute.addKhatma.name);

  void openQuran(BuildContext context) {
    return context.goNamed(
      AppRoute.quran.name,
      pathParameters: {'idSourat': "1", 'idVerset': "1"},
    );
  }

  void goHome(BuildContext context) => context.goNamed(AppRoute.home.name);

  BottomNavigationBarItem item(BuildContext context,
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
