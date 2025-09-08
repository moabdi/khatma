// lib/src/features/sync/presentation/simplified_sync_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/application/khatma_sync_manager.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Simplified Data Synchronization Screen with single sync option
class SimplifiedSyncScreen {
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
      builder: (_) => const SimplifiedSyncContent(),
    );
  }
}

class SimplifiedSyncContent extends ConsumerStatefulWidget {
  const SimplifiedSyncContent();

  @override
  ConsumerState<SimplifiedSyncContent> createState() =>
      _SimplifiedSyncContentState();
}

enum SyncState {
  idle,
  syncing,
  success,
  error,
}

class _SimplifiedSyncContentState extends ConsumerState<SimplifiedSyncContent> {
  SyncState _syncState = SyncState.idle;
  String? _errorMessage;
  int _khatmasToSync = 0;
  int _historyToSync = 0;
  bool _isLoadingCounts = true;

  @override
  void initState() {
    super.initState();
    _loadSyncCounts();
  }

  Future<void> _loadSyncCounts() async {
    try {
      final localRepo = ref.read(localKhatmaRepositoryProvider);
      final [khatmasToSync, historyToSync] = await Future.wait([
        localRepo.getKhatmasNeedingSync(),
        localRepo.getHistoryNeedingSync(),
      ]);

      if (mounted) {
        setState(() {
          _khatmasToSync = khatmasToSync.length;
          _historyToSync = historyToSync.length;
          _isLoadingCounts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingCounts = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncManager = ref.watch(syncManagerProvider.notifier);
    final theme = Theme.of(context);

    return _buildSyncListTile(context, theme);
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
          context.loc.synchronizeYourData,
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

  Widget _buildSyncListTile(BuildContext context, ThemeData theme) {
    final totalItemsToSync = _khatmasToSync + _historyToSync;
    final isDisabled = _syncState == SyncState.syncing;

    return Card(
      elevation: _syncState == SyncState.success ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: _syncState == SyncState.success
            ? BorderSide(color: Colors.green.withOpacity(0.3), width: 1)
            : BorderSide.none,
      ),
      color: _syncState == SyncState.success
          ? Colors.green.withOpacity(0.05)
          : null,
      child: ListTile(
        dense: true,
        leading: _buildLeadingIcon(theme, totalItemsToSync, isDisabled),
        title: Text(
          _getSyncTitle(context),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: _getTitleColor(theme, isDisabled),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _buildSubtitle(context, theme, totalItemsToSync),
        ),
        trailing: _buildTrailingIcon(theme),
        onTap:
            isDisabled || _syncState == SyncState.success ? null : _performSync,
        enabled: !isDisabled && _syncState != SyncState.success,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(
      ThemeData theme, int totalItemsToSync, bool isDisabled) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: _getLeadingBackgroundColor(theme, isDisabled),
          child: Icon(
            _getLeadingIconData(),
            color: _getLeadingIconColor(theme, isDisabled),
            size: 20,
          ),
        ),
        // Badge for count
        if (_shouldShowBadge(totalItemsToSync))
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getBadgeColor(),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 1,
                ),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                _getBadgeText(totalItemsToSync),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Color _getLeadingBackgroundColor(ThemeData theme, bool isDisabled) {
    switch (_syncState) {
      case SyncState.success:
        return Colors.green.withOpacity(0.1);
      case SyncState.error:
        return theme.colorScheme.errorContainer.withOpacity(0.1);
      case SyncState.syncing:
      case SyncState.idle:
        return isDisabled
            ? theme.colorScheme.surfaceVariant
            : Colors.green.withOpacity(0.1);
    }
  }

  IconData _getLeadingIconData() {
    switch (_syncState) {
      case SyncState.success:
        return Icons.check_circle;
      case SyncState.error:
        return Icons.error_outline;
      case SyncState.syncing:
      case SyncState.idle:
        return Icons.sync;
    }
  }

  Color _getLeadingIconColor(ThemeData theme, bool isDisabled) {
    switch (_syncState) {
      case SyncState.success:
        return Colors.green;
      case SyncState.error:
        return theme.colorScheme.error;
      case SyncState.syncing:
      case SyncState.idle:
        return isDisabled
            ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
            : Colors.green;
    }
  }

  bool _shouldShowBadge(int totalItemsToSync) {
    return (_syncState == SyncState.idle &&
            (!_isLoadingCounts && totalItemsToSync > 0)) ||
        (_syncState == SyncState.idle && _isLoadingCounts);
  }

  Color _getBadgeColor() {
    return Colors.green;
  }

  String _getBadgeText(int totalItemsToSync) {
    if (_isLoadingCounts) return "...";
    return totalItemsToSync.toString();
  }

  String _getSyncTitle(BuildContext context) {
    switch (_syncState) {
      case SyncState.success:
        return context.loc.syncCompleted;
      case SyncState.error:
        return context.loc.syncFailed('');
      case SyncState.syncing:
        return context.loc.syncing;
      case SyncState.idle:
        return context.loc.synchronizeData;
    }
  }

  Color _getTitleColor(ThemeData theme, bool isDisabled) {
    switch (_syncState) {
      case SyncState.success:
        return Colors.green;
      case SyncState.error:
        return theme.colorScheme.error;
      case SyncState.syncing:
      case SyncState.idle:
        return isDisabled
            ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
            : theme.colorScheme.onSurface;
    }
  }

  Widget _buildSubtitle(
      BuildContext context, ThemeData theme, int totalItemsToSync) {
    final subtitleText = _getSubtitleText(context, totalItemsToSync);
    final subtitleColor = _getSubtitleColor(theme);

    return Text(
      subtitleText,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: subtitleColor,
        height: 1.3,
      ),
    );
  }

  String _getSubtitleText(BuildContext context, int totalItemsToSync) {
    switch (_syncState) {
      case SyncState.success:
        return context.loc.allDataSynchronized;
      case SyncState.error:
        return _errorMessage ?? context.loc.syncFailed('');
      case SyncState.syncing:
        return 'Synchronizing your data, please wait...';
      case SyncState.idle:
        return _buildIdleSubtitle(context, totalItemsToSync);
    }
  }

  String _buildIdleSubtitle(BuildContext context, int totalItemsToSync) {
    if (_isLoadingCounts) {
      return context.loc.synchronizeUploadAndDownload;
    }

    if (totalItemsToSync == 0) {
      return context.loc.checkForUpdatesAndSync;
    }

    final parts = <String>[];
    if (_khatmasToSync > 0) {
      parts.add(context.loc.khatmasCount(_khatmasToSync));
    }
    if (_historyToSync > 0) {
      parts.add(context.loc.historyCount(_historyToSync));
    }

    return "${parts.join(' • ')} ${context.loc.toUpload}";
  }

  Color _getSubtitleColor(ThemeData theme) {
    switch (_syncState) {
      case SyncState.success:
        return Colors.green.withOpacity(0.8);
      case SyncState.error:
        return theme.colorScheme.error;
      case SyncState.syncing:
        return theme.colorScheme.onSurface.withOpacity(0.6);
      case SyncState.idle:
        return theme.colorScheme.onSurface.withOpacity(0.6);
    }
  }

  Widget? _buildTrailingIcon(ThemeData theme) {
    switch (_syncState) {
      case SyncState.syncing:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.green,
          ),
        );
      case SyncState.success:
        return Icon(
          Icons.check,
          color: Colors.green,
          size: 20,
        );
      case SyncState.error:
        return Icon(
          Icons.refresh,
          color: theme.colorScheme.error,
          size: 20,
        );
      case SyncState.idle:
        return Icon(
          Icons.arrow_forward_ios,
          color: Colors.green,
          size: 16,
        );
    }
  }

  Widget _buildActionButton(BuildContext context, ThemeData theme) {
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
          _syncState == SyncState.success
              ? context.loc.close
              : context.loc.cancel,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _performSync() async {
    if (_syncState == SyncState.syncing) return;

    setState(() {
      _syncState = SyncState.syncing;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    try {
      final syncManager = ref.read(syncManagerProvider.notifier);
      await syncManager.forceFullSync();
      await ref.read(khatmaNotifierProvider.notifier).refreshFromLocal();

      if (mounted) {
        setState(() {
          _syncState = SyncState.success;
        });

        // Refresh counts after successful sync

        await _loadSyncCounts();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _syncState = SyncState.error;
          _errorMessage = error.toString();
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
