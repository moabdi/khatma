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
    return BottomNavigationBar(
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
          {context.goNamed(AppRoute.addKhatma.name)}
      },
    );
  }
}
