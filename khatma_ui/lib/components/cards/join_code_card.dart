import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Join code display card with copy functionality
///
/// Displays a shareable code in a styled card with copy-to-clipboard functionality.
/// Perfect for displaying invitation codes, referral codes, or any shareable text.
class JoinCodeCard extends StatelessWidget {
  const JoinCodeCard({
    super.key,
    required this.code,
    this.title,
    this.copyButtonLabel = 'Copy Code',
    this.copiedMessage = 'Code copied!',
  });

  final String code;
  final String? title;
  final String copyButtonLabel;
  final String copiedMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              gapH12,
            ],

            // Code display
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                code,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: theme.colorScheme.primary,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            gapH16,

            // Copy button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _copyCode(context),
                icon: const Icon(Icons.copy, size: 18),
                label: Text(copyButtonLabel),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(copiedMessage),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
