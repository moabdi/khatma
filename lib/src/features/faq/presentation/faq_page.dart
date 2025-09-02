import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
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

  void _initializeExpansionState(int length) {
    if (_expanded.length != length) {
      _expanded = List.filled(length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final faqAsync = ref.watch(faqProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.faq),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: context.loc.refresh,
            onPressed: () => ref.invalidate(faqProvider),
          ),
        ],
      ),
      body: faqAsync.when(
        loading: () => const FaqLoadingView(),
        error: (error, _) => FaqErrorView(
          message: '${context.loc.failedToLoadFaq}: $error',
        ),
        data: (faqs) {
          if (faqs.isEmpty) {
            return FaqErrorView(message: context.loc.noFaqAvailable);
          }
          _initializeExpansionState(faqs.length);
          return _buildFaqList(faqs, context);
        },
      ),
    );
  }

  Widget _buildFaqList(List<FaqEntry> faqs, BuildContext context) {
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
          (i) => _buildPanel(faqs[i], i, context),
        ),
      ),
    );
  }

  ExpansionPanel _buildPanel(FaqEntry entry, int index, BuildContext context) {
    final isCurrentlyExpanded = _expanded[index];

    return ExpansionPanel(
      isExpanded: isCurrentlyExpanded,
      canTapOnHeader: true,
      backgroundColor: context.colorScheme.surface,
      headerBuilder: (context, isExpanded) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isExpanded
                    ? context.colorScheme.primary
                    : context.colorScheme.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
                boxShadow: isExpanded
                    ? [
                        BoxShadow(
                          color: context.colorScheme.primary.withOpacity(0.3),
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
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              entry.question,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isExpanded
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurface,
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
                p: context.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: context.colorScheme.onSurface.withOpacity(0.85),
                ),
                h1: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                  height: 1.3,
                ),
                h2: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                  height: 1.3,
                ),
                h3: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
                strong: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                em: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: context.colorScheme.onSurface.withOpacity(0.8),
                ),
                a: TextStyle(
                  color: context.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
                code: TextStyle(
                  backgroundColor: context.colorScheme.surfaceVariant,
                  color: context.colorScheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                codeblockDecoration: BoxDecoration(
                  color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                blockquote: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
                blockquoteDecoration: BoxDecoration(
                  color: context.colorScheme.surfaceVariant.withOpacity(0.3),
                  border: Border(
                    left: BorderSide(
                      color: context.colorScheme.primary,
                      width: 4,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                listBullet: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
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
