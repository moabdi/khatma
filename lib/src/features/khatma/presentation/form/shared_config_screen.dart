import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/shared_config/shared_config_widgets.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Screen for configuring shared khatma settings
///
/// Uses small, reusable widgets from shared_config/ directory
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final formData = ref.read(khatmaFormProvider);
    _config = formData.sharedConfig ?? const SharedConfig.defaults();
  }

  int _getMaxUnitsBasedOnType() {
    final formData = ref.read(khatmaFormProvider);
    return formData.unit == SplitUnit.hizb ? 60 : 30;
  }

  void _updateConfig(SharedConfig newConfig) {
    setState(() {
      _config = newConfig;
    });
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
                    // Limits Section
                    SectionTitle(context.loc.limits),
                    gapH16,
                    LimitsSection(
                      config: _config,
                      onConfigChanged: _updateConfig,
                      maxUnits: _getMaxUnitsBasedOnType(),
                    ),
                    gapH24,

                    // Time Settings Section
                    SectionTitle(context.loc.timeSettings),
                    gapH16,
                    TimeSettingsSection(
                      config: _config,
                      onConfigChanged: _updateConfig,
                    ),
                    gapH24,

                    // Join Settings Section
                    SectionTitle(context.loc.joinSettings),
                    gapH16,
                    JoinMethodSelector(
                      selectedMethod: _config.joinMethod,
                      onMethodChanged: (method) {
                        _updateConfig(_config.copyWith(joinMethod: method));
                      },
                    ),
                    gapH24,

                    // Invite Code Section
                    SectionTitle(context.loc.inviteCode),
                    gapH16,
                    InviteCodeField(
                      initialCode: _config.inviteCode,
                      onCodeChanged: (code) {
                        _updateConfig(_config.copyWith(inviteCode: code));
                      },
                    ),
                    gapH24,

                    // Group Settings Section
                    SectionTitle(context.loc.groupSettings),
                    gapH16,
                    MultipleGroupsSwitch(
                      value: _config.allowMultipleGroups,
                      onChanged: (value) {
                        _updateConfig(
                          _config.copyWith(allowMultipleGroups: value),
                        );
                      },
                    ),
                    gapH24,

                    // Tags Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle(context.loc.tags),
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
                    TagsManager(
                      tags: _config.tags,
                      onTagsChanged: (tags) {
                        _updateConfig(_config.copyWith(tags: tags));
                      },
                    ),
                    gapH24,
                  ],
                ),
              ),
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
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
          onPressed: _isLoading ? null : () => _handleSave(context),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : Text(context.loc.completeSetup),
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Update the form provider with the new config
      final formData = ref.read(khatmaFormProvider);
      ref.read(khatmaFormProvider.notifier).update(
            formData.copyWith(sharedConfig: _config),
          );

      // Save the khatma and get the saved khatma with ID
      final savedKhatma = await ref.read(khatmaFormProvider.notifier).save();

      if (mounted) {
        // Navigate to success screen
        if (savedKhatma != null && savedKhatma.id != null && _config.inviteCode != null) {
          context.go(
            '/khatma/shared/${savedKhatma.id}/success',
            extra: {
              'joinCode': _config.inviteCode,
              'khatmaName': savedKhatma.name,
            },
          );
        } else {
          context.go('/khatma');
        }
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.loc.failedToSaveKhatmaError(error.toString()),
            ),
          ),
        );
      }
    }
  }
}
