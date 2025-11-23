import 'package:flutter/material.dart';

/// Text field for displaying/generating codes
///
/// A TextFormField with a refresh button for generating new codes.
/// Perfect for invite codes, referral codes, or any generated text.
class CodeField extends StatelessWidget {
  const CodeField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onGenerate,
    this.readOnly = true,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final VoidCallback onGenerate;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontFamily: 'monospace',
            letterSpacing: 2,
          ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.qr_code),
        suffixIcon: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onGenerate,
          tooltip: 'Generate new code',
        ),
      ),
      validator: validator,
    );
  }
}
