import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

/// Radio selector for choosing join method (code or invitation)
///
/// Can be reused in any screen that needs to configure access control
class JoinMethodSelector extends StatelessWidget {
  const JoinMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  final JoinMethod selectedMethod;
  final ValueChanged<JoinMethod> onMethodChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildMethodOption(
            context: context,
            method: JoinMethod.code,
            icon: Icons.vpn_key,
            title: context.loc.joinByCode,
            subtitle: context.loc.joinByCodeDesc,
          ),
          _buildMethodOption(
            context: context,
            method: JoinMethod.invitation,
            icon: Icons.how_to_reg,
            title: context.loc.joinByInvitation,
            subtitle: context.loc.joinByInvitationDesc,
          ),
        ],
      ),
    );
  }

  Widget _buildMethodOption({
    required BuildContext context,
    required JoinMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedMethod == method;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<JoinMethod>(
        value: method,
        groupValue: selectedMethod,
        onChanged: (value) {
          if (value != null) {
            onMethodChanged(value);
          }
        },
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        subtitle: Text(subtitle),
        secondary: Icon(
          icon,
          color: isSelected ? context.colorScheme.primary : null,
        ),
      ),
    );
  }
}
