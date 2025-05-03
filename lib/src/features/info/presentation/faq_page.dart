import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late Future<String> _faqContent;

  @override
  void initState() {
    super.initState();
    _faqContent = _loadFAQ();
  }

  Future<String> _loadFAQ() async {
    return await rootBundle.loadString('assets/docs/faq.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _faqContent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No FAQs available.'));
            } else {
              final faqText = snapshot.data!;
              final faqList = faqText.split('\n# ').skip(1).toList();

              return ListView(
                children: faqList.map((faq) {
                  final parts = faq.split('\n');
                  final question = parts.first;
                  final answer = parts.sublist(1).join('\n');

                  return ExpansionTile(
                    title: Text(question),
                    children: [
                      Container(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(26),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MarkdownBody(data: answer),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
