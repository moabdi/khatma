import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour charger le fichier
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String _markdownData = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  // Fonction pour charger le fichier Markdown depuis les assets
  Future<void> _loadMarkdown() async {
    final String fileContent =
        await rootBundle.loadString('assets/docs/about_us.md');
    setState(() {
      _markdownData = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abous Us'),
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
