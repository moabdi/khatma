import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedLabelStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 14, fontWeight: FontWeight.w600);

    var unselectedLabelStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        );
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: context.colorScheme.primary,
      unselectedLabelStyle: unselectedLabelStyle,
      selectedLabelStyle: selectedLabelStyle,
      items: <BottomNavigationBarItem>[
        item(context, icon: Icons.home_filled, label: context.loc.home),
        item(context, icon: FontAwesomeIcons.book, label: context.loc.quran),
        item(context, icon: Icons.add_box_outlined, label: context.loc.create),
        item(context, icon: Icons.person, label: context.loc.profile),
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
