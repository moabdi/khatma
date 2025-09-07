// lib/src/features/sync/presentation/widgets/sync_status_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/application/sync_status_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

/// Reusable sync status indicator widget
class SyncStatusIndicator extends ConsumerWidget {
  final bool compact;
  final bool showText;

  const SyncStatusIndicator({
    super.key,
    this.compact = false,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncStatusNotifierProvider);
    final theme = Theme.of(context);

    if (compact) {
      return _buildCompactIndicator(context, theme, syncStatus);
    }

    return _buildFullIndicator(context, theme, syncStatus);
  }

  Widget _buildCompactIndicator(
    BuildContext context,
    ThemeData theme,
    SyncStatus status,
  ) {
    IconData icon;
    Color color;

    if (status.isSyncing) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: theme.colorScheme.primary,
        ),
      );
    } else if (status.hasCriticalError) {
      icon = Icons.sync_problem;
      color = theme.colorScheme.error;
    } else if (status.hasWarning) {
      icon = Icons.warning;
      color = Colors.orange;
    } else if (status.isHealthy && status.lastSuccessfulSync != null) {
      icon = Icons.cloud_done;
      color = Colors.green;
    } else {
      icon = Icons.cloud_off;
      color = theme.colorScheme.onSurfaceVariant;
    }

    return Icon(icon, color: color, size: 16);
  }

  Widget _buildFullIndicator(
    BuildContext context,
    ThemeData theme,
    SyncStatus status,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getStatusColor(theme, status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getStatusColor(theme, status).withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status.isSyncing)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _getStatusColor(theme, status),
              ),
            )
          else
            Icon(
              _getStatusIcon(status),
              color: _getStatusColor(theme, status),
              size: 16,
            ),
          if (showText) ...[
            const SizedBox(width: 8),
            Text(
              _getStatusText(context, status),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(theme, status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getStatusIcon(SyncStatus status) {
    if (status.hasCriticalError) return Icons.sync_problem;
    if (status.hasWarning) return Icons.warning;
    if (status.isHealthy && status.lastSuccessfulSync != null)
      return Icons.cloud_done;
    return Icons.cloud_off;
  }

  Color _getStatusColor(ThemeData theme, SyncStatus status) {
    if (status.isSyncing) return theme.colorScheme.primary;
    if (status.hasCriticalError) return theme.colorScheme.error;
    if (status.hasWarning) return Colors.orange;
    if (status.isHealthy && status.lastSuccessfulSync != null)
      return Colors.green;
    return theme.colorScheme.onSurfaceVariant;
  }

  String _getStatusText(BuildContext context, SyncStatus status) {
    if (status.isSyncing) {
      return status.currentOperation ?? context.loc.syncing;
    }
    if (status.hasCriticalError) return context.loc.syncError;
    if (status.hasWarning) return context.loc.syncWarning;
    if (status.isHealthy && status.lastSuccessfulSync != null) {
      return context.loc.syncUpToDate;
    }
    return context.loc.neverSynced;
  }
}
