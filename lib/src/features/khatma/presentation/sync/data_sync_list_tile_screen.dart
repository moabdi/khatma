// lib/src/features/sync/presentation/data_sync_list_tile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/application/khatma_sync_manager.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Data Synchronization Screen with ListTile design
class DataSyncListTileScreen {
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
      builder: (_) => const _DataSyncListTileContent(),
    );
  }
}

class _DataSyncListTileContent extends ConsumerStatefulWidget {
  const _DataSyncListTileContent();

  @override
  ConsumerState<_DataSyncListTileContent> createState() =>
      _DataSyncListTileContentState();
}

class _DataSyncListTileContentState
    extends ConsumerState<_DataSyncListTileContent> {
  SyncType? _currentSyncOperation;
  String? _lastError;

  @override
  Widget build(BuildContext context) {
    final syncManager = ref.watch(syncManagerProvider.notifier);
    final theme = Theme.of(context);
    final isAnySyncing = _currentSyncOperation != null || syncManager.isSyncing;

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
            _buildHeader(context, theme, syncManager),
            gapH24,

            // Sync Options as ListTiles
            _buildSyncListTiles(context, theme, isAnySyncing),
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

  Widget _buildHeader(
      BuildContext context, ThemeData theme, SyncManager syncManager) {
    final lastSync = syncManager.lastSuccessfulSync;
    final hasFailures = syncManager.consecutiveFailures > 0;

    return Column(
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
        if (lastSync != null || hasFailures) ...[
          gapH12,
          _buildQuickStatus(theme, lastSync, hasFailures),
        ],
      ],
    );
  }

  Widget _buildQuickStatus(
      ThemeData theme, DateTime? lastSync, bool hasFailures) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: hasFailures
            ? theme.colorScheme.errorContainer.withOpacity(0.1)
            : theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasFailures
              ? theme.colorScheme.error.withOpacity(0.3)
              : theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasFailures ? Icons.error_outline : Icons.check_circle,
            size: 16,
            color: hasFailures ? theme.colorScheme.error : Colors.green,
          ),
          gapW8,
          Text(
            hasFailures
                ? context.loc.syncError
                : lastSync != null
                    ? context.loc.lastSyncTime(_formatTime(lastSync))
                    : context.loc.neverSynced,
            style: theme.textTheme.bodySmall?.copyWith(
              color: hasFailures
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncListTiles(
      BuildContext context, ThemeData theme, bool isAnySyncing) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Pull from Server (Blue)
          _SyncListTile(
            icon: Icons.cloud_download,
            iconColor: Colors.blue,
            title: context.loc.pullFromServer,
            subtitle: context.loc.downloadRemoteChanges,
            syncType: SyncType.pullOnly,
            isLoading: _currentSyncOperation == SyncType.pullOnly,
            isDisabled: isAnySyncing,
            onTap: () => _performSync(SyncType.pullOnly),
          ),

          Divider(height: 1, indent: 16, endIndent: 16),

          // Push to Server (Orange)
          _SyncListTile(
            icon: Icons.cloud_upload,
            iconColor: Colors.orange,
            title: context.loc.pushToServer,
            subtitle: context.loc.uploadLocalChanges,
            syncType: SyncType.pushOnly,
            isLoading: _currentSyncOperation == SyncType.pushOnly,
            isDisabled: isAnySyncing,
            onTap: () => _performSync(SyncType.pushOnly),
          ),

          Divider(height: 1, indent: 16, endIndent: 16),

          // Full Sync (Green)
          _SyncListTile(
            icon: Icons.sync,
            iconColor: Colors.green,
            title: context.loc.fullSync,
            subtitle: context.loc.performBothUploadAndDownload,
            syncType: SyncType.fullSync,
            isLoading: _currentSyncOperation == SyncType.fullSync,
            isDisabled: isAnySyncing,
            onTap: () => _performSync(SyncType.fullSync),
          ),
        ],
      ),
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
    if (_currentSyncOperation != null) return;
    // Visual delay for better UX

    setState(() {
      _currentSyncOperation = syncType;
      _lastError = null;
    });

    await Future.delayed(const Duration(milliseconds: 1300));

    try {
      final syncManager = ref.read(syncManagerProvider.notifier);

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

      await ref.read(khatmaNotifierProvider.notifier).refreshFromLocal();

      // Show success feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.syncCompleted),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _lastError = context.loc.syncFailed(error.toString());
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _currentSyncOperation = null;
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

class _SyncListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final SyncType syncType;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onTap;

  const _SyncListTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.syncType,
    required this.isLoading,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = isDisabled && !isLoading
        ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
        : iconColor;

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: isDisabled && !isLoading
            ? theme.colorScheme.surfaceVariant
            : iconColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: effectiveIconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: isDisabled && !isLoading
              ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
              : theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDisabled && !isLoading
              ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
              : theme.colorScheme.onSurface.withOpacity(0.6),
          height: 1.3,
        ),
      ),
      trailing: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: iconColor,
              ),
            )
          : isDisabled
              ? null
              : Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 16,
                ),
      onTap: isDisabled ? null : onTap,
      enabled: !isDisabled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
