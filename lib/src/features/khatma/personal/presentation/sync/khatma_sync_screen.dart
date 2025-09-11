import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/personal/application/khatma_sync_manager.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/personal/data/local/local_khatma_repository.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/khatma_ui.dart';

class SimplifiedSyncContent extends ConsumerStatefulWidget {
  const SimplifiedSyncContent({super.key});

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
  int _itemsToSync = 0;
  bool _isLoadingCounts = true;
  DateTime? _lastSync;

  @override
  void initState() {
    super.initState();
    _loadSyncCounts();
  }

  Future<void> _loadSyncCounts() async {
    try {
      final localRepo = ref.read(localKhatmaRepositoryProvider);
      final [khatmas, history] = await Future.wait([
        localRepo.getKhatmasNeedingSync(),
        localRepo.getHistoryNeedingSync(),
      ]);

      if (mounted) {
        setState(() {
          _itemsToSync = khatmas.length + history.length;
          _isLoadingCounts = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingCounts = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final syncManager = ref.watch(syncManagerProvider.notifier);
    _lastSync = syncManager.lastSuccessfulSync;

    return Card(
      child: ListTile(
        leading: _buildLeadingIcons(theme),
        title: Text(
          _getTitle(context),
          style: theme.listTileTheme.titleTextStyle?.copyWith(
            color: _getTitleColor(theme),
          ),
        ),
        subtitle: Text(_getSubtitle(context)),
        // trailing: _buildTrailing(theme),
        onTap: _syncState == SyncState.idle || _syncState == SyncState.error
            ? _performSync
            : null,
      ),
    );
  }

  Widget _buildLeadingIcon(ThemeData theme) {
    IconData icon;
    Color backgroundColor;
    Color iconColor;

    switch (_syncState) {
      case SyncState.success:
        icon = Icons.check_circle;
        backgroundColor = Colors.green.withOpacity(0.1);
        iconColor = Colors.green;
        break;
      case SyncState.error:
        icon = Icons.error_outline;
        backgroundColor = theme.colorScheme.errorContainer.withOpacity(0.1);
        iconColor = theme.colorScheme.error;
        break;
      case SyncState.syncing:
        icon = Icons.sync;
        backgroundColor = theme.colorScheme.primaryContainer.withOpacity(0.1);
        iconColor = theme.colorScheme.primary;
        break;
      default:
        icon = Icons.cloud_sync_outlined;
        backgroundColor = theme.colorScheme.surfaceVariant;
        iconColor = theme.colorScheme.onSurfaceVariant;
        break;
    }

    return Icon(icon, color: iconColor);
  }

  Widget _buildLeadingIcons(ThemeData theme) {
    if (_syncState == SyncState.syncing) {
      return const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green),
      );
    }
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.green.withOpacity(0.1),
      child: Icon(
        _syncState == SyncState.success
            ? Icons.check
            : _syncState == SyncState.error
                ? Icons.error_outline
                : Icons.sync,
        color: _syncState == SyncState.success
            ? Colors.green
            : _syncState == SyncState.error
                ? theme.colorScheme.error
                : Colors.green,
      ),
    );
  }

  Widget? _buildTrailing(ThemeData theme) {
    if (_syncState == SyncState.error) {
      return Icon(Icons.refresh, color: theme.colorScheme.error);
    }
    return Icon(Icons.arrow_forward_ios, color: Colors.green, size: 16);
  }

  String _getTitle(BuildContext context) {
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

  String _getSubtitle(BuildContext context) {
    if (_syncState == SyncState.syncing) {
      return context.loc.synchronizingPleaseWait;
    }
    if (_syncState == SyncState.error) {
      return _errorMessage ?? context.loc.syncFailed('');
    }
    if (_itemsToSync > 0 && _syncState == SyncState.idle) {
      return context.loc.itemsToSync(_itemsToSync);
    }
    if (_lastSync != null) {
      return context.loc.lastSyncTime(_formatTime(_lastSync!));
    }
    return context.loc.neverSynced;
  }

  Color _getTitleColor(ThemeData theme) {
    switch (_syncState) {
      case SyncState.success:
        return Colors.green;
      case SyncState.error:
        return theme.colorScheme.error;
      default:
        return theme.colorScheme.onSurface;
    }
  }

  Future<void> _performSync() async {
    setState(() {
      _syncState = SyncState.syncing;
      _errorMessage = null;
    });

    try {
      final syncManager = ref.read(syncManagerProvider.notifier);
      await syncManager.forceFullSync();
      await ref.read(khatmaNotifierProvider.notifier).refreshFromLocal();

      if (mounted) {
        setState(() {
          _syncState = SyncState.success;
          _lastSync = DateTime.now();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _syncState = SyncState.error;
          _errorMessage = e.toString();
        });
      }
    } finally {
      _loadSyncCounts();
    }
  }

  String _formatTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return context.loc.justNow;
    if (diff.inHours < 1) return context.loc.minutesAgo(diff.inMinutes);
    if (diff.inDays < 1) return context.loc.hoursAgo(diff.inHours);
    return context.loc.daysAgo(diff.inDays);
  }
}
