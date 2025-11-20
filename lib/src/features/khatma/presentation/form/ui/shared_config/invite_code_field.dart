import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

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
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      6,
      (index) => chars[(random + index) % chars.length],
    ).join();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
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
      onChanged: (value) {
        final upperValue = value.toUpperCase();
        if (upperValue != value) {
          _controller.value = _controller.value.copyWith(
            text: upperValue,
            selection: TextSelection.collapsed(offset: upperValue.length),
          );
        }
        widget.onCodeChanged(upperValue.isEmpty ? null : upperValue);
      },
    );
  }
}
