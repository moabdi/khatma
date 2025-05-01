import 'package:flutter/material.dart';
import 'package:khatma/src/features/settings/presentation/recitation_settings.dart';
import 'package:khatma/src/features/settings/presentation/language_setting.dart';
import 'package:khatma/src/features/settings/presentation/notification_settings.dart';
import 'package:khatma/src/features/settings/presentation/theme_settings.dart';
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
              child: _buildMenuItem(
                context,
                icon: Icons.book_sharp,
                title: 'Mushaf',
                iconColor: Colors.brown,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecitationSettings(),
                    ),
                  );
                },
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.language,
                    title: 'Langues',
                    iconColor: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LanguageSettings()),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  _buildMenuItem(
                    context,
                    icon: Icons.brightness_6,
                    title: 'Thème',
                    iconColor: Colors.purpleAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThemePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
