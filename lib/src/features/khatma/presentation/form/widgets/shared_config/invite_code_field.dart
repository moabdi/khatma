import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/utils/code_generator.dart';

/// Text field for entering/generating invite codes
///
/// Can be reused in any screen that needs invite code management
class InviteCodeField extends StatefulWidget {
  const InviteCodeField({
    super.key,
    required this.initialCode,
    required this.onCodeChanged,
  });

  final String? initialCode;
  final ValueChanged<String?> onCodeChanged;

  @override
  State<InviteCodeField> createState() => _InviteCodeFieldState();
}

class _InviteCodeFieldState extends State<InviteCodeField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialCode ?? _generateInviteCode(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _generateInviteCode() {
    return CodeGenerator.generate6CharCode();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: context.loc.inviteCodeLabel,
        helperText: context.loc.inviteCodeHelper,
        prefixIcon: const Icon(Icons.qr_code),
        suffixIcon: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            final newCode = _generateInviteCode();
            _controller.text = newCode;
            widget.onCodeChanged(newCode);
          },
          tooltip: context.loc.generateNewCode,
        ),
      ),
    );
  }
}
