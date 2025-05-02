import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child:
                  Text("Quran", style: Theme.of(context).textTheme.titleMedium),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.book_sharp,
                  color: Colors.brown,
                ),
                title: const Text('Mushaf'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed(AppRoute.recitation.name),
              ),
            ),
            gapH8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text("Apparence",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.blueAccent,
                    ),
                    title: const Text('Langues'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.pushNamed(AppRoute.languages.name),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      color: Colors.purpleAccent,
                    ),
                    title: const Text('Thème'),
                    trailing: const Icon(Icons.chevron_right),
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
