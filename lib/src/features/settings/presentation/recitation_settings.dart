import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/settings/application/setting_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

class RecitationSettings extends ConsumerWidget {
  const RecitationSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        ref,
                        recitationName: context.loc.hafs,
                        recitationKey: 'hafs',
                        icon: Icons.menu_book_outlined,
                        description: context.loc.hafsDescription,
                      ),
                      gapH2,
                      Divider(height: 1),
                      gapH2,
                      _buildRecitationOption(
                        context,
                        ref,
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
    BuildContext context,
    WidgetRef ref, {
    required String recitationName,
    required String recitationKey,
    required IconData icon,
    required String description,
  }) {
    final isSelected = ref.watch(settingsProvider).riwaya == recitationKey;

    return ListTile(
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      title: Text(recitationName),
      subtitle: Text(description),
      selected: isSelected,
      onTap: () {
        ref.read(settingsProvider.notifier).updateRiwaya(recitationKey);
      },
    );
  }
}
