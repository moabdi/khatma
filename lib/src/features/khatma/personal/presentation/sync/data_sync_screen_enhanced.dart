// lib/src/features/sync/presentation/data_sync_screen_enhanced.dart
// Enhanced version with better state management
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/personal/application/khatma_sync_manager.dart';
import 'package:khatma/src/features/khatma/personal/application/sync_status_provider.dart';
import 'package:khatma/src/features/khatma/personal/presentation/sync/widgets/sync_status_indicator.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Enhanced Data Synchronization Screen with better state management
class DataSyncScreenEnhanced {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      barrierColor: Theme.of(context).disabledColor.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _DataSyncEnhancedContent(),
    );
  }
}

class _DataSyncEnhancedContent extends ConsumerStatefulWidget {
  const _DataSyncEnhancedContent();

  @override
  ConsumerState<_DataSyncEnhancedContent> createState() =>
      _DataSyncEnhancedContentState();
}

class _DataSyncEnhancedContentState
    extends ConsumerState<_DataSyncEnhancedContent> {
  String? _lastError;

  @override
  Widget build(BuildContext context) {
    final syncStatus = ref.watch(syncStatusNotifierProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        left: 20,
        right: 20,
        top: 8,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context, theme),
            gapH24,

            // Enhanced status indicator
            _buildEnhancedSyncStatus(theme, syncStatus),
            gapH24,

            // Sync actions
            _buildSyncActions(context, theme, syncStatus),
            gapH24,

            // Error message if any
            if (_lastError != null) _buildErrorMessage(theme),

            // Cancel button
            _buildCancelButton(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.dataSynchronization,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              gapH8,
              Text(
                context.loc.chooseSyncMethod,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        const SyncStatusIndicator(compact: true),
      ],
    );
  }

  Widget _buildEnhancedSyncStatus(ThemeData theme, SyncStatus status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SyncStatusIndicator(compact: false, showText: true),
              const Spacer(),
              if (status.lastSuccessfulSync != null)
                Text(
                  _formatTime(status.lastSuccessfulSync!),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
            ],
          ),
          if (status.consecutiveFailures > 0) ...[
            gapH8,
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: theme.colorScheme.error,
                ),
                gapW8,
                Expanded(
                  child: Text(
                    context.loc.syncFailureCount(status.consecutiveFailures),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSyncActions(
    BuildContext context,
    ThemeData theme,
    SyncStatus status,
  ) {
    final isDisabled = status.isSyncing;

    return Column(
      children: [
        // Full Sync - Primary Action
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                isDisabled ? null : () => _performSync(SyncType.fullSync),
            icon: Icon(Icons.sync, size: 20),
            label: Text(
              context.loc.fullSync,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),

        gapH16,

        // Individual actions
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed:
                    isDisabled ? null : () => _performSync(SyncType.pullOnly),
                icon: Icon(Icons.cloud_download, size: 18),
                label: Text(context.loc.pullFromServer),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            gapW12,
            Expanded(
              child: OutlinedButton.icon(
                onPressed:
                    isDisabled ? null : () => _performSync(SyncType.pushOnly),
                icon: Icon(Icons.cloud_upload, size: 18),
                label: Text(context.loc.pushToServer),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorMessage(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.error.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 20,
          ),
          gapW12,
          Expanded(
            child: Text(
              _lastError!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          context.loc.cancel,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _performSync(SyncType syncType) async {
    setState(() => _lastError = null);

    try {
      final syncManager = ref.read(syncManagerProvider.notifier);
      final statusNotifier = ref.read(syncStatusNotifierProvider.notifier);

      // Set operation status
      String operationText;
      switch (syncType) {
        case SyncType.fullSync:
          operationText = context.loc.performingFullSync;
          break;
        case SyncType.pullOnly:
          operationText = context.loc.downloadingChanges;
          break;
        case SyncType.pushOnly:
          operationText = context.loc.uploadingChanges;
          break;
        case SyncType.smartSync:
          operationText = context.loc.syncing;
          break;
      }

      statusNotifier.setCurrentOperation(operationText);

      // Perform sync
      switch (syncType) {
        case SyncType.fullSync:
          await syncManager.forceFullSync();
          break;
        case SyncType.pullOnly:
          await syncManager.forcePullFromRemote();
          break;
        case SyncType.pushOnly:
          await syncManager.forcePushToRemote();
          break;
        case SyncType.smartSync:
          await syncManager.performSmartSync();
          break;
      }

      // Clear operation status
      statusNotifier.clearCurrentOperation();

      // Show success feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.syncCompleted),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pop();
      }
    } catch (error) {
      ref.read(syncStatusNotifierProvider.notifier).clearCurrentOperation();

      if (mounted) {
        setState(() {
          _lastError = context.loc.syncFailed(error.toString());
        });
      }
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return context.loc.justNow;
    } else if (difference.inHours < 1) {
      return context.loc.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return context.loc.hoursAgo(difference.inHours);
    } else {
      return context.loc.daysAgo(difference.inDays);
    }
  }
}
