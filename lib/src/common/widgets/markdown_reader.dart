import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class MarkdownReaderPage extends StatelessWidget {
  final String title;
  final String assetPath;

  const MarkdownReaderPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  Future<String> _loadMarkdown() async {
    return await rootBundle.loadString(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: _loadMarkdown(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement du document.'));
          } else {
            return Markdown(
              data: snapshot.data!,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                textAlign: WrapAlignment.start,
                p: const TextStyle(fontSize: 16, height: 1.5),
              ),
            );
          }
        },
      ),
    );
  }
}
