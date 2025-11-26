import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

class KhatmaDescriptionCard extends StatelessWidget {
  const KhatmaDescriptionCard({
    super.key,
    required this.khatma,
  });

  final KhatmaShared khatma;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDescriptionBottomSheet(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 20,
              color: context.colorScheme.primary,
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.khatmaDescription,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  gapH4,
                  Text(
                    khatma.description ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            gapW8,
            Icon(
              Icons.chevron_right,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showDescriptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: context.colorScheme.primary,
                      ),
                      gapW12,
                      Expanded(
                        child: Text(
                          context.loc.khatmaDescription,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  gapH16,
                  const Divider(),
                  gapH16,
                  // Description content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Text(
                        khatma.description ?? '',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
