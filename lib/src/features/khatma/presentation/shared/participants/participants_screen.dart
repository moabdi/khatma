import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    KhatmaShared? khatma;
    try {
      final foundKhatma = khatmas.firstWhere((k) => k.id == widget.khatmaId);
      if (foundKhatma is KhatmaShared) {
        khatma = foundKhatma;
      }
    } catch (_) {
      khatma = null;
    }

    if (khatma == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.participants)),
        body: Center(
          child: Text(context.loc.khatmaNotFound),
        ),
      );
    }

    final participants = khatma.participants;
    final currentUserId = ref.read(khatmaManagerProvider).selectedKhatma?.creatorId;
    final isCreator = khatma.creatorId == currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.participants),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: participants.isEmpty
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
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: participants.length,
              separatorBuilder: (context, index) => gapH8,
              itemBuilder: (context, index) {
                final participant = participants[index];
                final isCurrentCreator = participant.userId == khatma!.creatorId;

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: participant.userPhotoUrl != null
                          ? NetworkImage(participant.userPhotoUrl!)
                          : null,
                      child: participant.userPhotoUrl == null
                          ? Text(
                              participant.userName.substring(0, 1).toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
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
                        Text(
                          _getRoleLabel(context, participant.role),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: _getRoleColor(context, participant.role),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH4,
                        Text(
                          '${context.loc.completed}: ${participant.completedUnits} units',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: isCreator && !isCurrentCreator
                        ? PopupMenuButton<ParticipantRole>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (role) {
                              _changeParticipantRole(khatma!, participant, role);
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: ParticipantRole.member,
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
                                value: ParticipantRole.moderator,
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
                                value: ParticipantRole.admin,
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
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
    );
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
}
