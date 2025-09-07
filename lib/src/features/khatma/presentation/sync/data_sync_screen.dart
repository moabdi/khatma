// lib/src/features/sync/presentation/data_sync_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/application/khatma_sync_manager.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Data Synchronization Screen - Bottom Sheet Dialog
class DataSyncScreen {
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
      builder: (_) => const _DataSyncContent(),
    );
  }
}

class _DataSyncContent extends ConsumerStatefulWidget {
  const _DataSyncContent();

  @override
  ConsumerState<_DataSyncContent> createState() => _DataSyncContentState();
}

class _DataSyncContentState extends ConsumerState<_DataSyncContent> {
  bool _isPerformingSync = false;
  String? _syncStatus;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final syncManager = ref.watch(syncManagerProvider.notifier);
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

            // Status indicator
            _buildSyncStatus(theme),
            gapH24,

            // Main sync option (Full Sync)
            _buildFullSyncOption(context, theme, syncManager),
            gapH16,

            // Individual sync options
            _buildIndividualSyncOptions(context, theme, syncManager),
            gapH24,

            // Error message if any
            if (_errorMessage != null) _buildErrorMessage(theme),

            // Cancel button
            _buildCancelButton(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
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
      ],
    );
  }

  Widget _buildSyncStatus(ThemeData theme) {
    final syncManager = ref.watch(syncManagerProvider.notifier);
    final lastSync = syncManager.lastSuccessfulSync;
    final isCurrentlySyncing = syncManager.isSyncing || _isPerformingSync;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // Status icon
          if (isCurrentlySyncing)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            )
          else
            Icon(
              lastSync != null ? Icons.check_circle : Icons.sync_problem,
              color: lastSync != null
                  ? Colors.green
                  : theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          gapW12,

          // Status text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrentlySyncing
                      ? (_syncStatus ?? context.loc.syncing)
                      : context.loc.syncStatus,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (!isCurrentlySyncing && lastSync != null)
                  Text(
                    context.loc.lastSyncTime(_formatTime(lastSync)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                if (!isCurrentlySyncing && lastSync == null)
                  Text(
                    context.loc.neverSynced,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullSyncOption(
    BuildContext context,
    ThemeData theme,
    SyncManager syncManager,
  ) {
    final isDisabled = _isPerformingSync || syncManager.isSyncing;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isDisabled
            ? null
            : () => _performSync(
                  context,
                  SyncType.fullSync,
                  context.loc.performingFullSync,
                ),
        icon: Icon(
          Icons.sync,
          size: 20,
        ),
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
          disabledBackgroundColor: theme.colorScheme.surfaceVariant,
          disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildIndividualSyncOptions(
    BuildContext context,
    ThemeData theme,
    SyncManager syncManager,
  ) {
    final isDisabled = _isPerformingSync || syncManager.isSyncing;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Pull from server
          _SyncOptionTile(
            icon: Icons.cloud_download,
            iconColor: Colors.blue,
            title: context.loc.pullFromServer,
            description: context.loc.downloadRemoteChanges,
            onTap: isDisabled
                ? null
                : () => _performSync(
                      context,
                      SyncType.pullOnly,
                      context.loc.downloadingChanges,
                    ),
            isDisabled: isDisabled,
          ),

          Divider(height: 1, indent: 16, endIndent: 16),

          // Push to server
          _SyncOptionTile(
            icon: Icons.cloud_upload,
            iconColor: Colors.orange,
            title: context.loc.pushToServer,
            description: context.loc.uploadLocalChanges,
            onTap: isDisabled
                ? null
                : () => _performSync(
                      context,
                      SyncType.pushOnly,
                      context.loc.uploadingChanges,
                    ),
            isDisabled: isDisabled,
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
              _errorMessage!,
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

  Future<void> _performSync(
    BuildContext context,
    SyncType syncType,
    String statusMessage,
  ) async {
    if (_isPerformingSync) return;

    setState(() {
      _isPerformingSync = true;
      _syncStatus = statusMessage;
      _errorMessage = null;
    });

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

        // Close the bottom sheet after successful sync
        Navigator.of(context).pop();
      }
    } catch (error) {
      setState(() {
        _errorMessage = context.loc.syncFailed(error.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isPerformingSync = false;
          _syncStatus = null;
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

class _SyncOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool isDisabled;

  const _SyncOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: isDisabled
            ? theme.colorScheme.surfaceVariant
            : iconColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: isDisabled
              ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
              : iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: isDisabled
              ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
              : theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        description,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDisabled
              ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
              : theme.colorScheme.onSurface.withOpacity(0.6),
          height: 1.3,
        ),
      ),
      trailing: isDisabled
          ? null
          : Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 16,
            ),
      onTap: onTap,
      enabled: !isDisabled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
