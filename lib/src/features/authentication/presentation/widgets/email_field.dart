import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool submitted;
  final String? Function(String?, bool, BuildContext) validator;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;
  final VoidCallback? onFieldSubmitted;

  const EmailField({
    super.key,
    required this.controller,
    this.isLoading = false,
    this.submitted = false,
    required this.validator,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: !isLoading,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      validator: (value) => validator(value, submitted, context),
      onFieldSubmitted:
          onFieldSubmitted != null ? (_) => onFieldSubmitted!() : null,
      decoration: InputDecoration(
        labelText: labelText ?? context.loc.email,
        hintText: hintText ?? context.loc.emailHint,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }
}
