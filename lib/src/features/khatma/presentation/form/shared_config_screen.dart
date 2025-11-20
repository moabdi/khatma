import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
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
  final _inviteCodeController = TextEditingController();
  final _tagsFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(khatmaFormProvider);
    _config = formData.sharedConfig ?? const SharedConfig.defaults();
    _tagsController.text = _config.tags.join(', ');

    // Pre-fill invite code with generated code if not set
    _inviteCodeController.text = _config.inviteCode ?? _generateInviteCode();
  }

  int _getMaxUnitsBasedOnType() {
    final formData = ref.read(khatmaFormProvider);
    return formData.unit == SplitUnit.hizb ? 60 : 30;
  }

  String _generateInviteCode() {
    // Generate a 6-character alphanumeric code
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(6, (index) => chars[(random + index) % chars.length]).join();
  }

  @override
  void dispose() {
    _tagsController.dispose();
    _inviteCodeController.dispose();
    _tagsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.loc.sharedKhatmaSettings),
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
                    _buildSectionTitle(context.loc.limits),
                    gapH16,
                    _buildLimitsSection(),
                    gapH24,
                    _buildSectionTitle(context.loc.timeSettings),
                    gapH16,
                    _buildTimeSettingsSection(),
                    gapH24,
                    _buildSectionTitle(context.loc.joinSettings),
                    gapH16,
                    _buildJoinMethodSelector(),
                    gapH24,
                    _buildSectionTitle(context.loc.inviteCode),
                    gapH16,
                    _buildInviteCodeField(),
                    gapH24,
                    _buildSectionTitle(context.loc.groupSettings),
                    gapH16,
                    _buildMultipleGroupsSwitch(),
                    gapH24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionTitle(context.loc.tags),
                        Text(
                          '${_config.tags.length}/5',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    gapH8,
                    Text(
                      context.loc.tagInstructions,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    gapH16,
                    _buildTagsSection(),
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

  Widget _buildLimitsSection() {
    final maxUnits = _getMaxUnitsBasedOnType();

    return Card(
      child: Column(
        children: [
          _buildCounterTile(
            title: context.loc.maxPartsToReserve,
            subtitle: context.loc.atSameTime,
            icon: Icons.playlist_add_check,
            value: _config.maxReservationsPerUser,
            maxValue: _config.maxUnitsToRead,
            onChanged: (value) {
              setState(() {
                _config = _config.copyWith(maxReservationsPerUser: value);
              });
            },
          ),
          const Divider(height: 1),
          _buildCounterTile(
            title: context.loc.maxPartsToRead,
            subtitle: context.loc.totalLimitPerUser,
            icon: Icons.book,
            value: _config.maxUnitsToRead,
            maxValue: maxUnits,
            onChanged: (value) {
              setState(() {
                // Ensure maxReservationsPerUser doesn't exceed maxUnitsToRead
                final updatedMaxReservations = _config.maxReservationsPerUser > value
                    ? value
                    : _config.maxReservationsPerUser;
                _config = _config.copyWith(
                  maxUnitsToRead: value,
                  maxReservationsPerUser: updatedMaxReservations,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSettingsSection() {
    const orangeColor = Color(0xFFFF9800);

    return Card(
      child: Column(
        children: [
          _buildCounterTile(
            title: context.loc.warningDelay,
            subtitle: context.loc.daysBeforeReminder,
            icon: Icons.warning_amber,
            value: _config.reservationWarningDays,
            leadingIconColor: orangeColor,
            onChanged: (value) {
              setState(() {
                _config = _config.copyWith(reservationWarningDays: value);
              });
            },
          ),
          const Divider(height: 1),
          _buildCounterTile(
            title: context.loc.expirationDelay,
            subtitle: context.loc.daysBeforeAutoRelease,
            icon: Icons.timer_off,
            value: _config.reservationExpirationDays ?? 0,
            leadingIconColor: orangeColor,
            isOptional: true,
            onChanged: (value) {
              setState(() {
                _config = _config.copyWith(
                  reservationExpirationDays: value == 0 ? null : value,
                );
              });
            },
          ),
          const Divider(height: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: orangeColor.withValues(alpha: 0.15),
              child: Icon(Icons.auto_fix_high, color: orangeColor),
            ),
            title: Text(context.loc.autoReleaseExpired),
            subtitle: Text(context.loc.freeUpExpiredReservedUnits),
            trailing: Switch(
              value: _config.autoReleaseExpiredReservations,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(autoReleaseExpiredReservations: value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required int value,
    required ValueChanged<int> onChanged,
    Color? leadingIconColor,
    bool isOptional = false,
    int minValue = 1,
    int maxValue = 99,
  }) {
    final controller = TextEditingController(text: value == 0 && isOptional ? '' : value.toString());
    final effectiveLeadingIconColor = leadingIconColor ?? context.colorScheme.primary;
    final effectiveBackgroundColor = leadingIconColor != null
        ? leadingIconColor.withValues(alpha: 0.15)
        : context.colorScheme.primaryContainer;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: effectiveBackgroundColor,
        child: Icon(icon, color: effectiveLeadingIconColor),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: context.textTheme.bodySmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: value > (isOptional ? 0 : minValue)
                ? () => onChanged(value - 1)
                : null,
            color: context.colorScheme.primary,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
              onChanged: (text) {
                if (text.isEmpty && isOptional) {
                  onChanged(0);
                } else {
                  final newValue = int.tryParse(text);
                  if (newValue != null && newValue >= (isOptional ? 0 : minValue) && newValue <= maxValue) {
                    onChanged(newValue);
                  }
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: value < maxValue
                ? () => onChanged(value + 1)
                : null,
            color: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildJoinMethodSelector() {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _config.joinMethod == JoinMethod.code
                  ? context.colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RadioListTile<JoinMethod>(
              value: JoinMethod.code,
              groupValue: _config.joinMethod,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _config = _config.copyWith(joinMethod: value);
                  });
                }
              },
              title: Text(
                context.loc.joinByCode,
                style: TextStyle(
                  fontWeight: _config.joinMethod == JoinMethod.code
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
              subtitle: Text(context.loc.joinByCodeDesc),
              secondary: Icon(
                Icons.vpn_key,
                color: _config.joinMethod == JoinMethod.code
                    ? context.colorScheme.primary
                    : null,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: _config.joinMethod == JoinMethod.invitation
                  ? context.colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RadioListTile<JoinMethod>(
              value: JoinMethod.invitation,
              groupValue: _config.joinMethod,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _config = _config.copyWith(joinMethod: value);
                  });
                }
              },
              title: Text(
                context.loc.joinByInvitation,
                style: TextStyle(
                  fontWeight: _config.joinMethod == JoinMethod.invitation
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
              subtitle: Text(context.loc.joinByInvitationDesc),
              secondary: Icon(
                Icons.how_to_reg,
                color: _config.joinMethod == JoinMethod.invitation
                    ? context.colorScheme.primary
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCodeField() {
    return TextFormField(
      controller: _inviteCodeController,
      decoration: InputDecoration(
        labelText: context.loc.inviteCodeLabel,
        helperText: context.loc.inviteCodeHelper,
        prefixIcon: const Icon(Icons.qr_code),
        suffixIcon: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            final newCode = _generateInviteCode();
            _inviteCodeController.text = newCode;
            setState(() {
              _config = _config.copyWith(inviteCode: newCode);
            });
          },
          tooltip: context.loc.generateNewCode,
        ),
      ),
      onChanged: (value) {
        final upperValue = value.toUpperCase();
        if (upperValue != value) {
          _inviteCodeController.value = _inviteCodeController.value.copyWith(
            text: upperValue,
            selection: TextSelection.collapsed(offset: upperValue.length),
          );
        }
        setState(() {
          _config = _config.copyWith(inviteCode: upperValue.isEmpty ? null : upperValue);
        });
      },
    );
  }

  Widget _buildMultipleGroupsSwitch() {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.primaryContainer,
          child: Icon(Icons.groups, color: context.colorScheme.primary),
        ),
        title: Text(context.loc.allowMultipleGroups),
        subtitle: Text(context.loc.allowMultipleGroupsDesc),
        trailing: Switch(
          value: _config.allowMultipleGroups,
          onChanged: (value) {
            setState(() {
              _config = _config.copyWith(allowMultipleGroups: value);
            });
          },
        ),
        onTap: () {
          setState(() {
            _config = _config.copyWith(allowMultipleGroups: !_config.allowMultipleGroups);
          });
        },
      ),
    );
  }

  Widget _buildTagsSection() {
    final canAddMoreTags = _config.tags.length < 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input field for new tags
        TextField(
          controller: _tagsController,
          focusNode: _tagsFocusNode,
          enabled: canAddMoreTags,
          decoration: InputDecoration(
            labelText: context.loc.addTag,
            hintText: canAddMoreTags
                ? context.loc.addTagHint
                : context.loc.maximumTagsReached,
            prefixIcon: const Icon(Icons.label),
            suffixIcon: _tagsController.text.isNotEmpty && canAddMoreTags
                ? IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addTag,
                  )
                : null,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _addTag(),
          onChanged: (value) {
            // Trigger rebuild to show/hide add button
            setState(() {});
          },
        ),
        // Display existing tags as chips below the input
        if (_config.tags.isNotEmpty) gapH16,
        if (_config.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _config.tags.map((tag) {
              return Chip(
                label: Text(tag),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  setState(() {
                    final updatedTags = List<String>.from(_config.tags);
                    updatedTags.remove(tag);
                    _config = _config.copyWith(tags: updatedTags);
                    // Refocus the field after removing a tag
                    _tagsFocusNode.requestFocus();
                  });
                },
              );
            }).toList(),
          ),
      ],
    );
  }

  void _addTag() {
    final tagText = _tagsController.text.trim();

    if (tagText.isEmpty) return;

    // Check if limit reached
    if (_config.tags.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.loc.maximumTagsAllowed),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check if tag already exists
    if (_config.tags.contains(tagText)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.loc.tagAlreadyExists),
          duration: const Duration(seconds: 2),
        ),
      );
      _tagsController.clear();
      _tagsFocusNode.requestFocus();
      return;
    }

    setState(() {
      final updatedTags = List<String>.from(_config.tags);
      updatedTags.add(tagText);
      _config = _config.copyWith(tags: updatedTags);
      _tagsController.clear();

      // Keep focus on the field if we can still add more tags
      if (_config.tags.length < 5) {
        _tagsFocusNode.requestFocus();
      }
    });
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
          child: Text(context.loc.completeSetup),
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
          SnackBar(content: Text(context.loc.failedToSaveKhatmaError(error.toString()))),
        );
      }
    }
  }
}
