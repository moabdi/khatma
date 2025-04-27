import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour charger le fichier
import 'package:flutter_markdown/flutter_markdown.dart';

class MentionsLegalesPage extends StatefulWidget {
  const MentionsLegalesPage({super.key});

  @override
  _MentionsLegalesPageState createState() => _MentionsLegalesPageState();
}

class _MentionsLegalesPageState extends State<MentionsLegalesPage> {
  String _markdownData = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  // Fonction pour charger le fichier Markdown depuis les assets
  Future<void> _loadMarkdown() async {
    final String fileContent =
        await rootBundle.loadString('assets/docs/mentions_legals.md');
    setState(() {
      _markdownData = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentions légales'),
        centerTitle: true,
      ),
      body: _markdownData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Markdown(
              data: _markdownData,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                h1: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                h2: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                p: Theme.of(context).textTheme.bodyMedium,
              ),
              padding: const EdgeInsets.all(16),
            ),
    );
  }
}
