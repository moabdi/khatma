import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:khatma/src/features/faq/presentation/extentions/markdown_style_extension.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqContent extends StatelessWidget {
  final String answer;
  final Animation<double> animation;

  const FaqContent({
    super.key,
    required this.answer,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: context.colorScheme.outline.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            MarkdownBody(
              data: answer,
              // Using the extension method
              styleSheet: context.faqMarkdownStyleSheet,
              onTapLink: (text, href, title) {
                if (href != null) {
                  _openLink(href, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openLink(String href, BuildContext context) async {
    try {
      final uri = Uri.parse(href);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (context.mounted) {
          _showLinkErrorSnackBar(href, context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }

  void _showLinkErrorSnackBar(String href, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open: $href'),
        action: SnackBarAction(
          label: 'Copy',
          onPressed: () {
            Clipboard.setData(ClipboardData(text: href));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Link copied to clipboard')),
            );
          },
        ),
      ),
    );
  }
}
