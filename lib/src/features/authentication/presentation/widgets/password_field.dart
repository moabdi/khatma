import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool submitted;
  final bool obscurePassword;
  final String? confirmPassword;
  final VoidCallback onObscureToggle;
  final VoidCallback? onSubmit;
  final String? Function(String?, bool, BuildContext) validator;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;

  const PasswordField({
    super.key,
    required this.controller,
    this.isLoading = false,
    this.submitted = false,
    this.confirmPassword,
    required this.obscurePassword,
    required this.onObscureToggle,
    this.onSubmit,
    required this.validator,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    final passwordMatch = confirmPassword != null &&
        confirmPassword == controller.text &&
        controller.text.isNotEmpty;

    return TextFormField(
      controller: controller,
      enabled: !isLoading,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: obscurePassword,
      textInputAction: textInputAction,
      validator: (value) => validator(value, submitted, context),
      onFieldSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
      decoration: InputDecoration(
        labelText: labelText ?? context.loc.password,
        hintText: hintText ?? context.loc.yourPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: _buildSuffixIcon(context, passwordMatch),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }

  Widget _buildSuffixIcon(BuildContext context, bool passwordMatch) {
    if (passwordMatch) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: context.successColor,
          ),
          gapH4,
          IconButton(
            onPressed: onObscureToggle,
            icon: Icon(
              obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            tooltip: obscurePassword ? context.loc.show : context.loc.hide,
          ),
        ],
      );
    }

    return IconButton(
      onPressed: onObscureToggle,
      icon: Icon(
        obscurePassword ? Icons.visibility : Icons.visibility_off,
      ),
      tooltip: obscurePassword ? context.loc.show : context.loc.hide,
    );
  }
}

class AnimatedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool submitted;
  final bool obscurePassword;
  final String? confirmPassword; // Only used for confirm password field
  final VoidCallback onObscureToggle;
  final VoidCallback? onSubmit;
  final String? Function(String?, bool, BuildContext)? validator;
  final String? Function(String?, String?, bool, BuildContext)?
      confirmValidator;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;

  const AnimatedPasswordField({
    super.key,
    required this.controller,
    this.isLoading = false,
    this.submitted = false,
    this.confirmPassword, // Pass this only for confirm password field
    required this.obscurePassword,
    required this.onObscureToggle,
    this.onSubmit,
    this.validator, // Use for regular password field
    this.confirmValidator, // Use for confirm password field
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    final isConfirmField = confirmPassword != null;
    final passwordMatch = isConfirmField &&
        confirmPassword == controller.text &&
        controller.text.isNotEmpty;

    return TextFormField(
      controller: controller,
      enabled: !isLoading,
      obscureText: obscurePassword,
      textInputAction: textInputAction,
      validator: (value) {
        if (confirmPassword != null && confirmValidator != null) {
          return confirmValidator!(value, confirmPassword, submitted, context);
        } else if (validator != null) {
          return validator!(value, submitted, context);
        }
        return null;
      },
      onFieldSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
      decoration: InputDecoration(
        labelText: labelText ??
            (isConfirmField
                ? context.loc.confirmPassword
                : context.loc.password),
        hintText: hintText ??
            (isConfirmField
                ? context.loc.confirmWithPassword
                : context.loc.yourPassword),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon:
            _buildAnimatedSuffixIcon(context, passwordMatch, isConfirmField),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }

  Widget _buildAnimatedSuffixIcon(
      BuildContext context, bool passwordMatch, bool isConfirmField) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Show match indicator only for confirm password field
        if (isConfirmField && controller.text.isNotEmpty)
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: Icon(
              passwordMatch ? Icons.check_circle : Icons.error,
              color: passwordMatch ? Colors.green : Colors.red,
              key: ValueKey(passwordMatch),
            ),
          ),
        IconButton(
          onPressed: onObscureToggle,
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ],
    );
  }
}

class SimplePasswordField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmit;
  final String? labelText;
  final String? hintText;
  final TextInputAction textInputAction;

  const SimplePasswordField({
    super.key,
    required this.controller,
    this.onSubmit,
    this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText ?? context.loc.password,
        hintText: hintText ?? context.loc.yourPassword,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }
}
