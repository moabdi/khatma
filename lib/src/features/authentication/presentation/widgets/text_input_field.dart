import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool submitted;
  final String? Function(String?, bool, BuildContext) validator;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;
  final VoidCallback? onFieldSubmitted;
  final int minLength;
  final int? maxLength;
  final IconButton? suffixIcon;

  const TextInputField({
    super.key,
    required this.controller,
    this.isLoading = false,
    this.submitted = false,
    required this.validator,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.minLength = 2,
    this.maxLength = 50,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: !isLoading,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.name,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')), // No double spaces
        LengthLimitingTextInputFormatter(maxLength),
      ],
      validator: (value) => validator(value, submitted, context),
      maxLength: maxLength,
      onFieldSubmitted:
          onFieldSubmitted != null ? (_) => onFieldSubmitted!() : null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.person_outline),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }
}
