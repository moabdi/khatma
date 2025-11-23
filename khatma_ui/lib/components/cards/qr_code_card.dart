import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// QR code display card
///
/// Displays a QR code in a styled card with optional title.
/// Can be reused anywhere a QR code needs to be displayed for sharing.
class QRCodeCard extends StatelessWidget {
  const QRCodeCard({
    super.key,
    required this.data,
    this.title,
    this.size = 200.0,
    this.errorMessage = 'Error generating QR code',
  });

  final String data;
  final String? title;
  final double size;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
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

            // QR Code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: QrImageView(
                data: data,
                version: QrVersions.auto,
                size: size,
                backgroundColor: Colors.white,
                errorStateBuilder: (context, error) {
                  return Center(
                    child: Text(
                      errorMessage,
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
