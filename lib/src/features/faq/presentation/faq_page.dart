import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/faq_entry.dart';
import '../application/faq_provider.dart';
import 'widgets/faq_error_view.dart';
import 'widgets/faq_loading_view.dart';

class FaqPage extends ConsumerStatefulWidget {
  const FaqPage({super.key});

  @override
  ConsumerState<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends ConsumerState<FaqPage> {
  late List<bool> _expanded = [];
  String? _currentLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).languageCode;

    // Reset expansion state when locale changes
    if (_currentLocale != locale) {
      _currentLocale = locale;
      setState(() {
        _expanded = [];
      });
    }
  }

  void _initializeExpansionState(int length) {
    if (_expanded.length != length) {
      _expanded = List.filled(length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final faqAsync = ref.watch(faqProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(locale)),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(faqProvider),
            tooltip: 'Refresh FAQ',
          ),
        ],
      ),
      body: faqAsync.when(
        loading: () => const FaqLoadingView(),
        error: (error, stackTrace) => FaqErrorView(
          message: 'Failed to load FAQ: ${error.toString()}',
        ),
        data: (faqs) {
          if (faqs.isEmpty) {
            return const FaqErrorView(message: 'No FAQ available');
          }

          _initializeExpansionState(faqs.length);
          return _buildFaqList(faqs, theme);
        },
      ),
    );
  }

  Widget _buildFaqList(List<FaqEntry> faqs, ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        materialGapSize: 16,
        elevation: 2,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _expanded[panelIndex] = !_expanded[panelIndex];
          });
        },
        children: List.generate(
          faqs.length,
          (i) => _buildPanel(faqs[i], i, theme),
        ),
      ),
    );
  }

  ExpansionPanel _buildPanel(FaqEntry entry, int index, ThemeData theme) {
    final isCurrentlyExpanded = _expanded[index];

    return ExpansionPanel(
      isExpanded: isCurrentlyExpanded,
      canTapOnHeader: true,
      backgroundColor: theme.colorScheme.surface,
      headerBuilder: (context, isExpanded) {
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
              entry.question,
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
              data: entry.answer,
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
                  _openLink(href);
                }
              },
            ),
          ],
        ),
      ),
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

  Future<void> _openLink(String href) async {
    try {
      final uri = Uri.parse(href);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (mounted) {
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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }
}
