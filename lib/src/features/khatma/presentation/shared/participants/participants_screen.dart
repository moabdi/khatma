import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/application/account_manager.dart';
import 'package:khatma/src/features/khatma/application/khatma_manager.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/khatma_ui.dart';

/// Screen to view and manage participants in a shared khatma
class ParticipantsScreen extends ConsumerStatefulWidget {
  const ParticipantsScreen({
    super.key,
    required this.khatmaId,
  });

  final String khatmaId;

  @override
  ConsumerState<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends ConsumerState<ParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    final khatmasAsync = ref.watch(khatmaManagerProvider).khatmas;

    if (khatmasAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.participants)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final khatmas = khatmasAsync.valueOrNull ?? [];
    KhatmaShared? khatmaTemp;
    try {
      final foundKhatma = khatmas.firstWhere((k) => k.id == widget.khatmaId);
      if (foundKhatma is KhatmaShared) {
        khatmaTemp = foundKhatma;
      }
    } catch (_) {
      khatmaTemp = null;
    }

    if (khatmaTemp == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.participants)),
        body: Center(
          child: Text(context.loc.khatmaNotFound),
        ),
      );
    }

    // Now khatma is guaranteed non-null
    final khatma = khatmaTemp;

    // Sort participants: creator first, then admins, then moderators, then members
    final sortedParticipants = _sortParticipants(khatma.participants, khatma.creatorId ?? '');
    final pendingParticipants = khatma.participants.where((p) => p.isPending).toList();

    final currentUserId = ref.read(khatmaManagerProvider).selectedKhatma?.creatorId;
    final isCreator = khatma.creatorId == currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.participants),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (isCreator && pendingParticipants.isNotEmpty)
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      gapW12,
                      const Text('Approve All'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _approveAllParticipants(khatma, pendingParticipants);
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: context.colorScheme.error, size: 20),
                      gapW12,
                      const Text('Reject All'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _rejectAllParticipants(khatma, pendingParticipants);
                  },
                ),
              ],
            ),
        ],
      ),
      body: sortedParticipants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  gapH16,
                  Text(
                    'No participants yet',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Statistics header
                _buildStatisticsHeader(context, khatma, pendingParticipants.length),
                // Participants list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: sortedParticipants.length,
                    separatorBuilder: (context, index) => gapH8,
                    itemBuilder: (context, index) {
                      final participant = sortedParticipants[index];
                final isCurrentCreator = participant.userId == khatma.creatorId;

                return Card(
                  child: ListTile(
                    leading: _buildParticipantAvatar(participant, isCurrentCreator),
                    title: Row(
                      children: [
                        Text(participant.userName),
                        if (isCurrentCreator) ...[
                          gapW8,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: khatma.style.hexColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Creator',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: khatma.style.hexColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH4,
                        if (participant.isPending)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Pending Approval',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else if (participant.isBlocked)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.error.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Blocked',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          Text(
                            _getRoleLabel(context, participant.role),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: _getRoleColor(context, participant.role),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        gapH4,
                        if (!participant.isPending && !participant.isBlocked)
                          Text(
                            '${context.loc.completed}: ${participant.completedUnits} units',
                            style: context.textTheme.bodySmall,
                          ),
                      ],
                    ),
                    trailing: isCreator && !isCurrentCreator
                        ? _buildTrailingActions(context, khatma, participant)
                        : null,
                  ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTrailingActions(
    BuildContext context,
    KhatmaShared khatma,
    Participant participant,
  ) {
    if (participant.isPending) {
      // Show approve/reject buttons for pending participants
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            color: context.colorScheme.error,
            onPressed: () => _rejectParticipant(khatma, participant),
            tooltip: 'Reject',
          ),
          IconButton(
            icon: const Icon(Icons.check, size: 20),
            color: Colors.green,
            onPressed: () => _approveParticipant(khatma, participant),
            tooltip: 'Approve',
          ),
        ],
      );
    } else if (participant.isBlocked) {
      // Show unblock button for blocked participants
      return IconButton(
        icon: const Icon(Icons.lock_open, size: 20),
        color: Colors.green,
        onPressed: () => _unblockParticipant(khatma, participant),
        tooltip: 'Unblock',
      );
    } else {
      // Show action menu for approved participants
      return PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (action) {
          if (action == 'remove') {
            _removeParticipant(khatma, participant);
          } else {
            final role = ParticipantRole.values.firstWhere(
              (r) => r.name == action,
            );
            _changeParticipantRole(khatma, participant, role);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: ParticipantRole.member.name,
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 20,
                  color: _getRoleColor(context, ParticipantRole.member),
                ),
                gapW12,
                Text(_getRoleLabel(context, ParticipantRole.member)),
              ],
            ),
          ),
          PopupMenuItem(
            value: ParticipantRole.moderator.name,
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 20,
                  color: _getRoleColor(context, ParticipantRole.moderator),
                ),
                gapW12,
                Text(_getRoleLabel(context, ParticipantRole.moderator)),
              ],
            ),
          ),
          PopupMenuItem(
            value: ParticipantRole.admin.name,
            child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  size: 20,
                  color: _getRoleColor(context, ParticipantRole.admin),
                ),
                gapW12,
                Text(_getRoleLabel(context, ParticipantRole.admin)),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'remove',
            child: Row(
              children: [
                Icon(
                  Icons.person_remove,
                  size: 20,
                  color: context.colorScheme.error,
                ),
                gapW12,
                Text(
                  'Remove',
                  style: TextStyle(color: context.colorScheme.error),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  String _getRoleLabel(BuildContext context, ParticipantRole role) {
    switch (role) {
      case ParticipantRole.member:
        return 'Member';
      case ParticipantRole.moderator:
        return 'Moderator';
      case ParticipantRole.admin:
        return 'Admin';
    }
  }

  Color _getRoleColor(BuildContext context, ParticipantRole role) {
    switch (role) {
      case ParticipantRole.member:
        return context.colorScheme.onSurfaceVariant;
      case ParticipantRole.moderator:
        return Colors.blue;
      case ParticipantRole.admin:
        return Colors.orange;
    }
  }

  Future<void> _changeParticipantRole(
    KhatmaShared khatma,
    Participant participant,
    ParticipantRole newRole,
  ) async {
    // Update participant role
    final updatedParticipants = khatma.participants.map((p) {
      if (p.userId == participant.userId) {
        return p.copyWith(role: newRole);
      }
      return p;
    }).toList();

    final updatedKhatma = khatma.copyWith(participants: updatedParticipants);

    // Save to repository
    final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

    if (mounted) {
      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Role updated successfully'),
            backgroundColor: context.colorScheme.primary,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error updating role'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _approveParticipant(
    KhatmaShared khatma,
    Participant participant,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    try {
      final updatedKhatma = khatma.approveParticipant(
        participant.userId,
        currentUser.id,
      );

      // Save to repository
      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${participant.userName} approved'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error approving participant'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _rejectParticipant(
    KhatmaShared khatma,
    Participant participant,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Reject Participant'),
          content: Text('Are you sure you want to reject ${participant.userName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.error,
              ),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      final updatedKhatma = khatma.rejectParticipant(
        participant.userId,
        currentUser.id,
      );

      // Save to repository
      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${participant.userName} rejected'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error rejecting participant'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _removeParticipant(
    KhatmaShared khatma,
    Participant participant,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    // Check if participant has completed units
    final completedUnits = khatma.userCompletedUnits(participant.userId);
    final hasCompletedUnits = completedUnits.isNotEmpty;

    if (hasCompletedUnits) {
      // Show dialog suggesting to block instead
      final action = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Remove Participant'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${participant.userName} has completed ${completedUnits.length} unit(s).',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'It is recommended to block them instead of removing to preserve the history.',
                ),
                const SizedBox(height: 8),
                const Text(
                  'What would you like to do?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop('block'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Block'),
              ),
            ],
          );
        },
      );

      if (action == null) return;

      if (action == 'block') {
        await _blockParticipant(khatma, participant);
      }
    } else {
      // No completed units, show simple confirmation
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Remove Participant'),
            content: Text('Are you sure you want to remove ${participant.userName}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                ),
                child: const Text('Remove'),
              ),
            ],
          );
        },
      );

      if (confirmed != true) return;

      try {
        final updatedKhatma = khatma.removeParticipant(
          participant.userId,
          currentUser.id,
        );

        // Save to repository
        final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

        if (mounted) {
          if (result.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${participant.userName} removed'),
                backgroundColor: context.colorScheme.primary,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Error removing participant'),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    }
  }

  Future<void> _blockParticipant(
    KhatmaShared khatma,
    Participant participant,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    try {
      final updatedKhatma = khatma.blockParticipant(
        participant.userId,
        currentUser.id,
      );

      // Save to repository
      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${participant.userName} blocked'),
              backgroundColor: Colors.orange,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error blocking participant'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _unblockParticipant(
    KhatmaShared khatma,
    Participant participant,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Unblock Participant'),
          content: Text('Are you sure you want to unblock ${participant.userName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Unblock'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      // Find the participant index and change their status back to approved
      final participantIndex = khatma.participants.indexWhere((p) => p.userId == participant.userId);
      if (participantIndex == -1) return;

      final updatedParticipants = List<Participant>.from(khatma.participants);
      updatedParticipants[participantIndex] = participant.copyWith(
        status: ParticipantStatus.approved,
      );

      final updatedKhatma = khatma.copyWith(
        participants: updatedParticipants,
        lastActivityDate: DateTime.now(),
        lastActivityUserId: currentUser.id,
        lastUpdated: DateTime.now(),
        needsSync: true,
      );

      // Save to repository
      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${participant.userName} unblocked'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error unblocking participant'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  // Sort participants by role: creator first, then admins, moderators, members
  List<Participant> _sortParticipants(List<Participant> participants, String creatorId) {
    final sorted = List<Participant>.from(participants);
    sorted.sort((a, b) {
      // Creator always first
      if (a.userId == creatorId) return -1;
      if (b.userId == creatorId) return 1;

      // Then by role (admin > moderator > member)
      final roleOrder = {
        ParticipantRole.admin: 0,
        ParticipantRole.moderator: 1,
        ParticipantRole.member: 2,
      };

      final aOrder = roleOrder[a.role] ?? 3;
      final bOrder = roleOrder[b.role] ?? 3;

      if (aOrder != bOrder) return aOrder.compareTo(bOrder);

      // Same role, sort by name
      return a.userName.compareTo(b.userName);
    });
    return sorted;
  }

  // Build avatar with unique color per user and role-specific styling
  Widget _buildParticipantAvatar(Participant participant, bool isCreator) {
    // Choose color based on role
    Color avatarColor;
    IconData? roleIcon;

    if (isCreator) {
      avatarColor = Colors.amber[700]!;
      roleIcon = Icons.star;
    } else if (participant.role == ParticipantRole.admin) {
      avatarColor = Colors.deepOrange;
      roleIcon = Icons.admin_panel_settings;
    } else if (participant.role == ParticipantRole.moderator) {
      avatarColor = Colors.blue;
      roleIcon = Icons.shield;
    } else {
      // Members get unique color based on userId
      avatarColor = _getUserColor(participant.userId);
      roleIcon = null;
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: avatarColor.withValues(alpha: 0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: avatarColor,
            backgroundImage: participant.userPhotoUrl != null
                ? NetworkImage(participant.userPhotoUrl!)
                : null,
            child: participant.userPhotoUrl == null
                ? Text(
                    participant.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
        // Role badge for creator, admin, and moderator
        if (roleIcon != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: avatarColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Icon(
                roleIcon,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  // Generate unique color based on userId
  Color _getUserColor(String userId) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
      Colors.deepOrange,
      Colors.lightGreen,
      Colors.deepPurple,
    ];

    // Use hashCode to generate consistent color for same user
    final index = userId.hashCode.abs() % colors.length;
    return colors[index];
  }

  // Build statistics header
  Widget _buildStatisticsHeader(BuildContext context, KhatmaShared khatma, int pendingCount) {
    final approvedParticipants = khatma.participants.where((p) => p.isApproved).length;
    final totalUnitsCompleted = khatma.units.where((u) => u.isCompleted).length;
    final totalUnitsReserved = khatma.units.where((u) => u.isReserved).length;
    final progressPercentage = ((totalUnitsCompleted / khatma.totalUnits) * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            khatma.style.hexColor.withValues(alpha: 0.1),
            khatma.style.hexColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: khatma.style.hexColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: khatma.style.hexColor,
                size: 24,
              ),
              gapW12,
              Text(
                'Khatma Progress',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: khatma.style.hexColor,
                ),
              ),
            ],
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                Icons.people,
                '$approvedParticipants',
                'Participants',
                khatma.style.hexColor,
              ),
              _buildStatItem(
                context,
                Icons.check_circle,
                '$totalUnitsCompleted',
                'Completed',
                Colors.green,
              ),
              _buildStatItem(
                context,
                Icons.bookmark,
                '$totalUnitsReserved',
                'Reserved',
                Colors.blue,
              ),
              _buildStatItem(
                context,
                Icons.trending_up,
                '$progressPercentage%',
                'Progress',
                khatma.style.hexColor,
              ),
            ],
          ),
          if (pendingCount > 0) ...[
            gapH12,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hourglass_empty, color: Colors.orange, size: 16),
                  gapW8,
                  Text(
                    '$pendingCount pending approval request${pendingCount > 1 ? 's' : ''}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        gapH4,
        Text(
          value,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Approve all pending participants
  Future<void> _approveAllParticipants(
    KhatmaShared khatma,
    List<Participant> pendingParticipants,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    try {
      KhatmaShared updatedKhatma = khatma;
      for (final participant in pendingParticipants) {
        updatedKhatma = updatedKhatma.approveParticipant(
          participant.userId,
          currentUser.id,
        );
      }

      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Approved ${pendingParticipants.length} participant(s)'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error approving participants'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }

  // Reject all pending participants
  Future<void> _rejectAllParticipants(
    KhatmaShared khatma,
    List<Participant> pendingParticipants,
  ) async {
    final currentUser = ref.read(userProvider);
    if (currentUser == null) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Reject All Participants'),
          content: Text('Are you sure you want to reject ${pendingParticipants.length} pending participant(s)?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.error,
              ),
              child: const Text('Reject All'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      KhatmaShared updatedKhatma = khatma;
      for (final participant in pendingParticipants) {
        updatedKhatma = updatedKhatma.rejectParticipant(
          participant.userId,
          currentUser.id,
        );
      }

      final result = await ref.read(khatmaManagerProvider.notifier).save(updatedKhatma);

      if (mounted) {
        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Rejected ${pendingParticipants.length} participant(s)'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error rejecting participants'),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.colorScheme.error,
          ),
        );
      }
    }
  }
}
