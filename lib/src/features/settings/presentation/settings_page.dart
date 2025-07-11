import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.book_sharp,
                ),
                title: Text(context.loc.riwaya),
                onTap: () => context.pushNamed(AppRoute.recitation.name),
              ),
            ),
            gapH8,
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(context.loc.language),
                    onTap: () => context.pushNamed(AppRoute.languages.name),
                  ),
                  ListTile(
                    leading: Icon(Icons.brightness_6),
                    title: Text(context.loc.theme),
                    onTap: () => context.pushNamed(AppRoute.theme.name),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
