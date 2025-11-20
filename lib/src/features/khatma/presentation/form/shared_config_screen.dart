import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class SharedKhatmaConfigScreen extends ConsumerStatefulWidget {
  const SharedKhatmaConfigScreen({super.key});

  @override
  ConsumerState<SharedKhatmaConfigScreen> createState() =>
      _SharedKhatmaConfigScreenState();
}

class _SharedKhatmaConfigScreenState
    extends ConsumerState<SharedKhatmaConfigScreen> {
  late SharedConfig _config;
  final _formKey = GlobalKey<FormState>();
  final _tagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(khatmaFormProvider);
    _config = formData.sharedConfig ?? const SharedConfig.defaults();
    _tagsController.text = _config.tags.join(', ');
  }

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shared Khatma Settings'),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Reservation Limits'),
                    gapH16,
                    _buildMaxReservationsField(),
                    gapH16,
                    _buildMaxUnitsToReadField(),
                    gapH24,
                    _buildSectionTitle('Time Limits'),
                    gapH16,
                    _buildWarningDaysField(),
                    gapH16,
                    _buildExpirationDaysField(),
                    gapH16,
                    _buildAutoReleaseSwitch(),
                    gapH24,
                    _buildSectionTitle('Join Settings'),
                    gapH16,
                    _buildJoinMethodSelector(),
                    gapH16,
                    _buildInviteCodeField(),
                    gapH24,
                    _buildSectionTitle('Group Settings'),
                    gapH16,
                    _buildMultipleGroupsSwitch(),
                    gapH24,
                    _buildSectionTitle('Tags'),
                    gapH8,
                    Text(
                      'Add tags to categorize your khatma (comma-separated)',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    gapH16,
                    _buildTagsField(),
                    gapH24,
                  ],
                ),
              ),
            ),
          ),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.primary,
      ),
    );
  }

  Widget _buildMaxReservationsField() {
    return TextFormField(
      initialValue: _config.maxReservationsPerUser.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Max parts to reserve at same time',
        helperText: 'Maximum units a user can reserve simultaneously',
        prefixIcon: const Icon(Icons.playlist_add_check),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        final num = int.tryParse(value);
        if (num == null || num < 1) {
          return 'Must be at least 1';
        }
        return null;
      },
      onChanged: (value) {
        final num = int.tryParse(value);
        if (num != null) {
          setState(() {
            _config = _config.copyWith(maxReservationsPerUser: num);
          });
        }
      },
    );
  }

  Widget _buildMaxUnitsToReadField() {
    return TextFormField(
      initialValue: _config.maxUnitsToRead.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Max parts authorized to read',
        helperText: 'Total maximum units a user can read in this khatma',
        prefixIcon: const Icon(Icons.book),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        final num = int.tryParse(value);
        if (num == null || num < 1) {
          return 'Must be at least 1';
        }
        return null;
      },
      onChanged: (value) {
        final num = int.tryParse(value);
        if (num != null) {
          setState(() {
            _config = _config.copyWith(maxUnitsToRead: num);
          });
        }
      },
    );
  }

  Widget _buildWarningDaysField() {
    return TextFormField(
      initialValue: _config.reservationWarningDays.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Warning delay (days)',
        helperText: 'Days before sending a reminder for reserved units',
        prefixIcon: const Icon(Icons.warning_amber),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        final num = int.tryParse(value);
        if (num == null || num < 1) {
          return 'Must be at least 1';
        }
        return null;
      },
      onChanged: (value) {
        final num = int.tryParse(value);
        if (num != null) {
          setState(() {
            _config = _config.copyWith(reservationWarningDays: num);
          });
        }
      },
    );
  }

  Widget _buildExpirationDaysField() {
    return TextFormField(
      initialValue: _config.reservationExpirationDays?.toString() ?? '',
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Expiration delay (days) - Optional',
        helperText: 'Days before auto-releasing reserved units (leave empty for no expiration)',
        prefixIcon: const Icon(Icons.timer_off),
        suffixIcon: _config.reservationExpirationDays != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _config = _config.copyWith(
                      reservationExpirationDays: null,
                    );
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            _config = _config.copyWith(reservationExpirationDays: null);
          });
        } else {
          final num = int.tryParse(value);
          if (num != null && num > 0) {
            setState(() {
              _config = _config.copyWith(reservationExpirationDays: num);
            });
          }
        }
      },
    );
  }

  Widget _buildAutoReleaseSwitch() {
    return SwitchListTile(
      value: _config.autoReleaseExpiredReservations,
      onChanged: (value) {
        setState(() {
          _config = _config.copyWith(autoReleaseExpiredReservations: value);
        });
      },
      title: const Text('Auto-release expired reservations'),
      subtitle: const Text('Automatically free up expired reserved units'),
      secondary: const Icon(Icons.auto_fix_high),
    );
  }

  Widget _buildJoinMethodSelector() {
    return Card(
      child: Column(
        children: [
          RadioListTile<JoinMethod>(
            value: JoinMethod.code,
            groupValue: _config.joinMethod,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _config = _config.copyWith(joinMethod: value);
                });
              }
            },
            title: const Text('Join by code'),
            subtitle: const Text('Anyone with the code can join instantly'),
            secondary: const Icon(Icons.vpn_key),
          ),
          RadioListTile<JoinMethod>(
            value: JoinMethod.invitation,
            groupValue: _config.joinMethod,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _config = _config.copyWith(joinMethod: value);
                });
              }
            },
            title: const Text('Join by invitation'),
            subtitle: const Text('Users must request and be approved to join'),
            secondary: const Icon(Icons.how_to_reg),
          ),
          RadioListTile<JoinMethod>(
            value: JoinMethod.both,
            groupValue: _config.joinMethod,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _config = _config.copyWith(joinMethod: value);
                });
              }
            },
            title: const Text('Both methods'),
            subtitle: const Text('Allow both code and invitation-based joining'),
            secondary: const Icon(Icons.people),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCodeField() {
    return TextFormField(
      initialValue: _config.inviteCode ?? '',
      decoration: InputDecoration(
        labelText: 'Invite Code (Optional)',
        helperText: 'Custom code for users to join. Leave empty for auto-generated',
        prefixIcon: const Icon(Icons.qr_code),
        suffixIcon: _config.inviteCode != null && _config.inviteCode!.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _config = _config.copyWith(inviteCode: null);
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          _config = _config.copyWith(
            inviteCode: value.isEmpty ? null : value.toUpperCase(),
          );
        });
      },
    );
  }

  Widget _buildMultipleGroupsSwitch() {
    return SwitchListTile(
      value: _config.allowMultipleGroups,
      onChanged: (value) {
        setState(() {
          _config = _config.copyWith(allowMultipleGroups: value);
        });
      },
      title: const Text('Allow multiple groups'),
      subtitle: const Text('Users can participate in multiple groups simultaneously'),
      secondary: const Icon(Icons.groups),
    );
  }

  Widget _buildTagsField() {
    return TextFormField(
      controller: _tagsController,
      decoration: InputDecoration(
        labelText: 'Tags',
        hintText: 'e.g., Ramadan, Family, Community',
        prefixIcon: const Icon(Icons.label),
        helperText: 'Tags help organize and find khatmas',
      ),
      maxLines: 2,
      onChanged: (value) {
        final tags = value
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList();
        setState(() {
          _config = _config.copyWith(tags: tags);
        });
      },
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _handleSave(context),
          child: const Text('Complete Setup'),
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      // Update the form provider with the new config
      final formData = ref.read(khatmaFormProvider);
      ref.read(khatmaFormProvider.notifier).update(
            formData.copyWith(sharedConfig: _config),
          );

      // Save the khatma
      await ref.read(khatmaFormProvider.notifier).save();

      if (mounted) {
        // Navigate to the shared khatma read screen
        final savedKhatma = ref.read(khatmaFormProvider);
        if (savedKhatma.id != null) {
          context.go('/khatma/shared/${savedKhatma.id}');
        } else {
          context.go('/khatma');
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save khatma: $error')),
        );
      }
    }
  }
}
