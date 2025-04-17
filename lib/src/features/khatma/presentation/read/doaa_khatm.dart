import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class DoaaKhatm extends StatefulWidget {
  @override
  _DoaaKhatmState createState() => _DoaaKhatmState();
}

class _DoaaKhatmState extends State<DoaaKhatm> {
  String _markdownContent = '';

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  Future<void> loadMarkdown() async {
    final String content =
        await rootBundle.loadString('assets/docs/khatma-doaa.md');
    setState(() {
      _markdownContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " 🌙✨ دعاء ختم القرآن الكريم ✨🌙",
        ),
        centerTitle: true,
      ),
      body: _markdownContent.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Markdown(
                data: _markdownContent,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: TextStyle(fontSize: 18, height: 1.6),
                ),
              ),
            ),
    );
  }
}
