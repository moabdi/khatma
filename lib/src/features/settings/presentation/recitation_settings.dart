import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/khatma_ui.dart';

class RecitationSettings extends StatefulWidget {
  const RecitationSettings({super.key});

  @override
  _RecitationSettingsState createState() => _RecitationSettingsState();
}

class _RecitationSettingsState extends State<RecitationSettings> {
  String? _selectedRecitation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.recitation),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  context.loc.chooseRiwaya,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                gapH12,
                Card(
                  child: Column(
                    children: [
                      _buildRecitationOption(
                        context,
                        recitationName: context.loc.hafs,
                        recitationKey: 'hafs',
                        icon: Icons.menu_book_outlined,
                        description: context.loc.hafsDescription,
                      ),
                      dividerH0_5T0_5,
                      _buildRecitationOption(
                        context,
                        recitationName: context.loc.warsh,
                        recitationKey: 'warsh',
                        icon: Icons.auto_stories,
                        description: context.loc.warshDescription,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecitationOption(
    BuildContext context, {
    required String recitationName,
    required String recitationKey,
    required IconData icon,
    required String description,
  }) {
    final isSelected = _selectedRecitation == recitationKey;

    return ListTile(
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      title: Text(recitationName),
      subtitle: Text(description),
      tileColor: isSelected ? context.theme.primaryColor.withAlpha(26) : null,
      onTap: () {
        setState(() {
          _selectedRecitation = recitationKey;
        });

        // Navigate to the respective recitation page
        context.goNamed(recitationKey);
      },
    );
  }
}
