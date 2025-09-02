// lib/src/features/settings/presentation/about_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/features/settings/data/about_service.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutContentAsync = ref.watch(aboutContentProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.aboutUs),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Show cache status in debug mode
          if (aboutContentAsync.hasError)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.invalidate(aboutContentProvider);
              },
              tooltip: 'Reload content',
            ),
        ],
      ),
      body: aboutContentAsync.when(
        data: (aboutContent) => _buildContent(context, aboutContent),
        loading: () => _buildLoading(context),
        error: (error, stackTrace) => _buildError(context, ref, error),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AboutContent aboutContent) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show locale fallback warning if needed
          if (aboutContent.locale != Localizations.localeOf(context))
            _buildLocaleWarning(context, aboutContent.locale),

          // Main markdown content
          MarkdownBody(
            data: aboutContent.content,
            onTapLink: (text, href, title) => _launchUrl(href),
            styleSheet: _buildMarkdownStyle(context),
            selectable: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLocaleWarning(BuildContext context, String actualLocale) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.p12),
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.translate,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: Sizes.p8),
          Expanded(
            child: Text(
              'Content displayed in ${actualLocale.toUpperCase()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: Sizes.p16),
          Text(
            'Loading...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: Sizes.p16),
            Text(
              'Unable to load content',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.p8),
            Text(
              'Error: ${error.toString()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.p24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(aboutContentProvider);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: Sizes.p12),
                TextButton(
                  onPressed: () {
                    _launchUrl('mailto:support@khatma.app');
                  },
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MarkdownStyleSheet _buildMarkdownStyle(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return MarkdownStyleSheet.fromTheme(theme).copyWith(
      // Headers with Khatma styling
      h1: textTheme.headlineLarge?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      h2: textTheme.headlineSmall?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      h3: textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      h4: textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),

      // Body text
      p: textTheme.bodyMedium?.copyWith(
        fontSize: 16,
        height: 1.6,
        color: theme.colorScheme.onSurface,
      ),

      // Quranic verses with special styling
      blockquote: textTheme.bodyLarge?.copyWith(
        fontStyle: FontStyle.italic,
        color: theme.primaryColor.withOpacity(0.9),
        fontSize: 18,
        height: 1.8,
        fontWeight: FontWeight.w500,
      ),
      blockquoteDecoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: theme.primaryColor,
            width: 4,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.all(Sizes.p16),

      // Lists
      listBullet: textTheme.bodyMedium?.copyWith(
        color: theme.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      // Links (email, etc.)
      a: textTheme.bodyMedium?.copyWith(
        color: theme.primaryColor,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w500,
      ),

      // Horizontal rules
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) return;

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
