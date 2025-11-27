import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/core/app_dialog.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/logic/khatma_details_controller.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/khatma_bottom_action_button.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/khatma_description_card.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/khatma_filter_chips.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/khatma_units_header.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/khatma_units_list.dart';
import 'package:khatma/src/features/khatma/presentation/shared/details/widgets/progress_stats.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Filter options for displaying units
enum UnitFilter {
  all,
  mine,
  reserved,
  free,
  completed,
}

/// Shared khatma details screen with modern design
///
/// Displays:
/// - Description (if available)
/// - Progress statistics
/// - Filterable unit list
/// - Reservation confirmation
class SharedKhatmaScreen extends ConsumerStatefulWidget {
  const SharedKhatmaScreen({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<SharedKhatmaScreen> createState() =>
      _SharedKhatmaScreenState();
}

class _SharedKhatmaScreenState extends ConsumerState<SharedKhatmaScreen> {
  @override
  Widget build(BuildContext context) {
    // Check if user is authenticated
    final currentUser = ref.watch(userProvider);
    final isAuthenticated = currentUser != null && !currentUser.isAnonymous;

    // Prevent non-authenticated users from viewing shared khatmas
    if (!isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.khatma)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                gapH16,
                Text(
                  'Sign in Required',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                gapH8,
                Text(
                  'You must sign in to view shared khatmas',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                gapH24,
                ElevatedButton.icon(
                  onPressed: () {
                    context.goNamed(AppRoute.account.name);
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Watch the khatmas list directly to avoid race conditions with selectedKhatma
    final khatmasAsync = ref.watch(khatmaManagerProvider).khatmas;

    // Show loading state while khatmas are being fetched
    if (khatmasAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.khatma)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Try to find the khatma by ID from the loaded list
    final khatmas = khatmasAsync.valueOrNull ?? [];
    Khatma? khatma;
    try {
      khatma = khatmas.firstWhere((k) => k.id == widget.khatmaId);
    } catch (_) {
      khatma = null;
    }

    // Update selectedKhatma for other features that might need it (but don't rely on it)
    if (khatma != null) {
      final currentSelected = ref.read(khatmaManagerProvider).selectedKhatma;
      if (currentSelected?.id != widget.khatmaId) {
        Future.microtask(() {
          ref.read(khatmaManagerProvider.notifier).selectKhatma(khatma);
        });
      }
    }

    // Handle different khatma states
    if (khatma == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.khatma)),
        body: EmptyPlaceholderWidget(message: context.loc.khatmaNotFound),
      );
    }

    // Only show content for shared khatmas
    if (khatma is! KhatmaShared) {
      return Scaffold(
        appBar: AppBar(title: Text(khatma.name)),
        body: const EmptyPlaceholderWidget(
          message: 'This khatma type is not supported in this view',
        ),
      );
    }

    return _buildContent(khatma);
  }

  Widget _buildContent(KhatmaShared khatma) {
    final state = ref.watch(khatmaDetailsControllerProvider(khatma.id!));
    final controller =
        ref.read(khatmaDetailsControllerProvider(khatma.id!).notifier);

    return Scaffold(
      appBar: _buildAppBar(khatma),
      body: Column(
        children: [
          Expanded(
            child: !state.hasVisibleUnits
                ? _buildEmptyState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description section
                        if (state.khatma.description?.isNotEmpty ?? false) ...[
                          KhatmaDescriptionCard(khatma: state.khatma),
                          gapH16,
                        ],

                        // Progress statistics
                        KhatmaProgressStats(khatma: state.khatma),
                        gapH20,

                        // Section title with clear selection button
                        KhatmaUnitsHeader(
                          unitName: state.khatma.unit.name,
                          hasSelectedUnits: state.hasSelectedUnits,
                          onClearSelection: () => controller.clearSelection(),
                          selectedReservedCount: state.areAllSelectedUnitsReserved
                              ? state.selectedUnits.length
                              : 0,
                          onUnreserveAll: state.areAllSelectedUnitsReserved
                              ? () => _unreserveAllSelected(state, controller)
                              : null,
                        ),
                        gapH12,

                        // Filter chips
                        KhatmaFilterChips(state: state, controller: controller),
                        gapH16,

                        // Units list
                        KhatmaUnitsList(
                          state: state,
                          onUnitTap: (unit) => _toggleUnitReservation(unit, state, controller),
                          onSendReminder: (unit) => _sendReminder(unit, controller),
                          onFreeUnit: (unit) => _freeUnit(unit, controller),
                        ),
                      ],
                    ),
                  ),
          ),

          // Bottom action button - always show but disabled if no selection
          KhatmaBottomActionButton(
            state: state,
            khatma: khatma,
            onAction: (action, selectedUnits) => _performAction(state, controller, khatma.name, action, selectedUnits),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(KhatmaShared khatma) {
    return AppBar(
      title: Text(khatma.name),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.go('/khatma'),
      ),
      actions: [
        // Participants button with pending badge
        Builder(
          builder: (context) {
            final pendingCount = khatma.participants.where((p) => p.isPending).length;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.people_outline),
                  onPressed: () => context.go('/khatma/shared/${khatma.id!}/participants'),
                  tooltip: context.loc.participants,
                ),
                if (pendingCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colorScheme.surface,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withValues(alpha: 0.6),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '$pendingCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        // Settings button (config)
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.go('/khatma/shared/${khatma.id!}/settings'),
          tooltip: context.loc.settings,
        ),
        // Edit button
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: khatma.style.hexColor,
          ),
          onPressed: () => context.go('/khatma/shared/${khatma.id!}/edit'),
          tooltip: context.loc.edit,
        ),
        gapW8,
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            gapH16,
            Text(
              context.loc.noUnitsFound,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            gapH8,
            Text(
              context.loc.tryChangingFilter,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // === Event Handlers ===

  void _toggleUnitReservation(
    Unit unit,
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) {
    // Use the new validation logic
    final error = controller.toggleUnitSelection(unit);

    if (error != null) {
      _showSnackBar(error, isError: true);
    }
  }

  // === Helper Methods ===

  Future<void> _sendReminder(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      // TODO: Implement actual reminder notification system (push notification/email)
      // For now, this is a placeholder that simulates sending a reminder
      // In a real implementation, this would:
      // 1. Send a push notification to the user who reserved the unit
      // 2. Or send an email reminder
      // 3. Update the lastReminderSent timestamp
      // 4. Increment the reminderCount

      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call

      if (mounted) {
        _showSnackBar(context.loc.reminderSentSuccess);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error sending reminder: $e', isError: true);
      }
    }
  }

  Future<void> _freeUnit(
    Unit unit,
    KhatmaDetailsController controller,
  ) async {
    try {
      final currentUser = ref.read(userProvider);
      if (currentUser == null) {
        if (mounted) {
          _showSnackBar(context.loc.userNotLoggedIn, isError: true);
        }
        return;
      }

      final result = await ref
          .read(khatmaManagerProvider.notifier)
          .releaseUnit(
            khatmaId: widget.khatmaId,
            unitNumber: unit.number,
            userId: currentUser.id,
          );

      if (mounted) {
        if (result.isSuccess) {
          _showSnackBar(context.loc.unitFreedSuccess);
        } else {
          _showSnackBar('Error: ${result.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error freeing unit: $e', isError: true);
      }
    }
  }

  Future<void> _unreserveAllSelected(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
  ) async {
    final selectedUnits = state.selectedUnits;
    if (selectedUnits.isEmpty) return;

    // Show confirmation dialog
    final confirmed = await AppDialog.showConfirm(
      context,
      title: context.loc.unreserveUnits(selectedUnits.length),
      message: 'Are you sure you want to unreserve ${selectedUnits.length} selected unit(s)?',
      confirmText: context.loc.unreserve,
      cancelText: context.loc.cancel,
    );

    if (confirmed != true) return;

    try {
      final currentUser = ref.read(userProvider);
      if (currentUser == null) {
        if (mounted) {
          _showSnackBar(context.loc.userNotLoggedIn, isError: true);
        }
        return;
      }

      // Unreserve all selected units
      int successCount = 0;
      int failCount = 0;

      for (final unit in selectedUnits) {
        final result = await ref
            .read(khatmaManagerProvider.notifier)
            .releaseUnit(
              khatmaId: widget.khatmaId,
              unitNumber: unit.number,
              userId: currentUser.id,
            );

        if (result.isSuccess) {
          successCount++;
        } else {
          failCount++;
        }
      }

      // Clear selection after unreserving
      //controller.clearSelection();

      if (mounted) {
        if (failCount == 0) {
          _showSnackBar('Successfully unreserved $successCount unit(s)');
        } else {
          _showSnackBar(
            'Unreserved $successCount unit(s), failed $failCount',
            isError: failCount > 0,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error unreserving units: $e', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? context.colorScheme.error
            : context.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<bool> _showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
    Color? confirmColor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.loc.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(
                backgroundColor: confirmColor ?? context.colorScheme.primary,
              ),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<void> _performAction(
    KhatmaDetailsState state,
    KhatmaDetailsController controller,
    String khatmaName,
    KhatmaActionType actionType,
    List<int> selectedUnits,
  ) async {
    try {
      if (selectedUnits.isEmpty && actionType != KhatmaActionType.join) {
        _showSnackBar(context.loc.pleaseSelectAtLeastOneUnit, isError: true);
        return;
      }

      switch (actionType) {
        case KhatmaActionType.join:
          // Just join without reserving units
          await ref
              .read(khatmaManagerProvider.notifier)
              .joinKhatma(khatmaId: widget.khatmaId, reservedUnits: []);

          if (mounted) {
            _showSnackBar(context.loc.joinedKhatmaSuccessfully(khatmaName));
            context.goNamed(AppRoute.home.name);
          }
          break;

        case KhatmaActionType.reserveAndJoin:
          // Join and reserve selected units
          await ref
              .read(khatmaManagerProvider.notifier)
              .joinKhatma(khatmaId: widget.khatmaId, reservedUnits: selectedUnits);

          if (mounted) {
            _showSnackBar(context.loc.joinedAndReservedUnits(khatmaName, selectedUnits.length));
          }
          break;

        case KhatmaActionType.reserve:
          // Just reserve units (user already in khatma)
          final currentUser = ref.read(userProvider);
          if (currentUser == null) {
            if (mounted) {
              _showSnackBar(context.loc.userNotLoggedIn, isError: true);
            }
            return;
          }

          final reserveResult = await ref
              .read(khatmaManagerProvider.notifier)
              .reserveUnits(
                khatmaId: widget.khatmaId,
                unitNumbers: selectedUnits,
                userId: currentUser.id,
                userName: currentUser.displayName ?? currentUser.email ?? 'User',
              );

          if (mounted) {
            if (reserveResult.isSuccess) {
              _showSnackBar(context.loc.reservedUnitsSuccess(selectedUnits.length));
              //controller.clearSelection();
            } else {
              _showSnackBar('Error: ${reserveResult.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
            }
            // Stay on the same page - don't navigate
          }
          break;

        case KhatmaActionType.unreserve:
          // Unreserve units - show confirmation dialog first
          final confirmed = await _showConfirmationDialog(
            title: context.loc.unreserveUnit,
            message: context.loc.confirmFreeUnit,
            confirmText: context.loc.unreserveUnit,
            confirmColor: Colors.orange.shade700,
          );

          if (!confirmed) return;

          final currentUserForUnreserve = ref.read(userProvider);
          if (currentUserForUnreserve == null) {
            if (mounted) {
              _showSnackBar(context.loc.userNotLoggedIn, isError: true);
            }
            return;
          }

          final unreserveResult = await ref
              .read(khatmaManagerProvider.notifier)
              .releaseUnits(
                khatmaId: widget.khatmaId,
                unitNumbers: selectedUnits,
                userId: currentUserForUnreserve.id,
              );

          if (mounted) {
            if (unreserveResult.isSuccess) {
              _showSnackBar(context.loc.unitFreedSuccess);
              //controller.clearSelection();
            } else {
              _showSnackBar('Error: ${unreserveResult.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
            }
            // Stay on the same page - don't navigate
          }
          break;

        case KhatmaActionType.complete:
          // Complete reserved units
          final currentUserForComplete = ref.read(userProvider);
          if (currentUserForComplete == null) {
            if (mounted) {
              _showSnackBar(context.loc.userNotLoggedIn, isError: true);
            }
            return;
          }

          final completeResult = await ref
              .read(khatmaManagerProvider.notifier)
              .completeUnits(
                khatmaId: widget.khatmaId,
                unitNumbers: selectedUnits,
                userId: currentUserForComplete.id,
              );

          if (mounted) {
            if (completeResult.isSuccess) {
              _showSnackBar(context.loc.successCompleteParts(selectedUnits.length));
              //controller.clearSelection();
            } else {
              _showSnackBar('Error: ${completeResult.errorOrNull?.toString() ?? "Unknown error"}', isError: true);
            }
            // Stay on the same page - don't navigate
          }
          break;
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error: ${e.toString()}', isError: true);
      }
    }
  }
}
