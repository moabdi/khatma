import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        title: const Text('Récitation'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  radius: 40,
                  child: const Icon(
                    Icons.menu_book,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Sélectionnez la récitation que vous souhaitez utiliser",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildRecitationOption(
                  context,
                  recitationName: 'Hafs',
                  recitationKey: 'hafs',
                  icon: Icons.menu_book_outlined,
                  description:
                      "La récitation la plus répandue dans le monde musulman, notamment au Moyen-Orient.",
                ),
                const Divider(),
                _buildRecitationOption(
                  context,
                  recitationName: 'Warsh',
                  recitationKey: 'warsh',
                  icon: Icons.auto_stories,
                  description:
                      "Courante en Afrique du Nord. Légères différences de prononciation et d'orthographe.",
                ),
                const Divider(),
                const SizedBox(height: 32),
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
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(recitationName),
      subtitle: Text(description, style: Theme.of(context).textTheme.bodySmall),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
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
