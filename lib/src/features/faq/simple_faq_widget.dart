// lib/src/features/faq/widgets/simple_faq_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class SimpleFaqWidget extends StatefulWidget {
  const SimpleFaqWidget({super.key});

  @override
  State<SimpleFaqWidget> createState() => _SimpleFaqWidgetState();
}

class _SimpleFaqWidgetState extends State<SimpleFaqWidget> {
  final List<bool> _isExpanded = List.generate(10, (index) => false);
  String _faqContent = '';
  bool _isLoading = true;
  String? _currentLocale;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).languageCode;

    if (_currentLocale != locale) {
      _currentLocale = locale;
      _loadFaqContent(locale);
    }
  }

  Future<void> _loadFaqContent(String locale) async {
    setState(() => _isLoading = true);

    final fileName = _getFaqFileName(locale);

    try {
      final content = await rootBundle.loadString('assets/faq/$fileName');
      setState(() {
        _faqContent = content;
        _isLoading = false;
      });
    } catch (e) {
      try {
        final fallbackContent =
            await rootBundle.loadString('assets/faq/faq_en.md');
        setState(() {
          _faqContent = fallbackContent;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _faqContent =
              '# Error loading FAQ content\n\nPlease check if FAQ files exist in assets/faq/ directory.';
          _isLoading = false;
        });
      }
    }
  }

  String _getFaqFileName(String locale) {
    switch (locale) {
      case 'ar':
        return 'faq_ar.md';
      case 'fr':
        return 'faq_fr.md';
      default:
        return 'faq_en.md';
    }
  }

  List<Map<String, String>> _parseFaqContent() {
    final faqs = <Map<String, String>>[];
    final lines = _faqContent.split('\n');

    String? currentQuestion;
    List<String> currentAnswer = [];

    for (String line in lines) {
      if (line.startsWith('# ') && line.length > 2) {
        // Save previous FAQ if exists
        if (currentQuestion != null && currentAnswer.isNotEmpty) {
          faqs.add({
            'question': currentQuestion,
            'answer': currentAnswer.join('\n').trim(),
          });
        }

        // Start new FAQ
        currentQuestion = line.substring(2).trim();
        currentAnswer = [];
      } else if (currentQuestion != null) {
        currentAnswer.add(line);
      }
    }

    // Add the last FAQ
    if (currentQuestion != null && currentAnswer.isNotEmpty) {
      faqs.add({
        'question': currentQuestion,
        'answer': currentAnswer.join('\n').trim(),
      });
    }

    return faqs;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(locale)),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildFaqList(theme),
    );
  }

  Widget _buildFaqList(ThemeData theme) {
    final faqs = _parseFaqContent();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ExpansionPanelList(
        elevation: 2,
        expandedHeaderPadding: const EdgeInsets.all(0),
        materialGapSize: 16,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded[index] = isExpanded;
          });
        },
        children: List.generate(
          faqs.length,
          (index) => _buildExpansionPanel(faqs[index], index, theme),
        ),
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(
    Map<String, String> faq,
    int index,
    ThemeData theme,
  ) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isExpanded
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
                boxShadow: isExpanded
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              faq['question']!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isExpanded
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const SizedBox(height: 16),
            MarkdownBody(
              data: faq['answer']!,
              styleSheet: MarkdownStyleSheet(
                p: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withOpacity(0.85),
                ),
                h1: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  height: 1.3,
                ),
                h2: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                  height: 1.3,
                ),
                h3: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                strong: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                em: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
                a: TextStyle(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
                code: TextStyle(
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  color: theme.colorScheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                codeblockDecoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                blockquote: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
                blockquoteDecoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  border: Border(
                    left: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 4,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                listBullet: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTapLink: (text, href, title) {
                if (href != null) {
                  _launchUrl(href);
                }
              },
            ),
          ],
        ),
      ),
      isExpanded: _isExpanded[index],
      canTapOnHeader: true,
      backgroundColor: theme.colorScheme.surface,
    );
  }

  String _getTitle(String locale) {
    switch (locale) {
      case 'ar':
        return 'الأسئلة الشائعة';
      case 'fr':
        return 'Questions fréquemment posées';
      default:
        return 'Frequently Asked Questions';
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open: $url'),
              action: SnackBarAction(
                label: 'Copy',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied to clipboard')),
                  );
                },
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }
}
