import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Dynamic password requirements that update in real-time while typing
class DynamicPasswordRequirements extends StatelessWidget {
  final String password;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final EdgeInsets? padding;
  final bool showTitle;
  final bool showStrengthIndicator;

  const DynamicPasswordRequirements(
      {super.key,
      required this.password,
      this.backgroundColor,
      this.borderColor,
      this.titleColor,
      this.padding,
      this.showTitle = true,
      this.showStrengthIndicator = true});

  @override
  Widget build(BuildContext context) {
    // final bgColor = backgroundColor ?? Colors.transparent;
    // final bColor = borderColor ?? Colors.blue.shade200;
    final tColor = titleColor ?? Colors.blue.shade700;

    return Card(
      //color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // side: BorderSide(color: bColor),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTitle) ...[
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: tColor,
                  ),
                  gapW8,
                  Text(
                    context.loc.passwordRequirements,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: tColor,
                    ),
                  ),
                ],
              ),
              gapH8,
            ],
            _PasswordRequirementItem(
              text: context.loc.atLeast8CharsCriterion,
              isValid: _hasMinLength(password),
            ),
            _PasswordRequirementItem(
              text: context.loc.oneUppercaseCriterion,
              isValid: _hasUppercase(password),
            ),
            _PasswordRequirementItem(
              text: context.loc.oneLowercaseCriterion,
              isValid: _hasLowercase(password),
            ),
            _PasswordRequirementItem(
              text: context.loc.oneDigitCriterion,
              isValid: _hasDigit(password),
            ),
            gapH12,
            if (showStrengthIndicator)
              PasswordStrengthIndicator(
                password: password,
                showLabel: false,
              )
          ],
        ),
      ),
    );
  }

  // Validation helpers
  bool _hasMinLength(String password) => password.length >= 8;
  bool _hasUppercase(String password) => RegExp(r'[A-Z]').hasMatch(password);
  bool _hasLowercase(String password) => RegExp(r'[a-z]').hasMatch(password);
  bool _hasDigit(String password) => RegExp(r'\d').hasMatch(password);
}

/// Individual requirement item with dynamic check/cross icon
class _PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const _PasswordRequirementItem({
    required this.text,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isValid ? Icons.check_circle : Icons.radio_button_unchecked,
              key: ValueKey(isValid),
              size: 16,
              color: isValid ? Colors.green.shade600 : Colors.grey.shade500,
            ),
          ),
          gapW8,
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 13,
                color: isValid ? Colors.green.shade700 : Colors.grey.shade600,
                fontWeight: isValid ? FontWeight.w500 : FontWeight.normal,
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact version without card wrapper
class CompactPasswordRequirements extends StatelessWidget {
  final String password;
  final Color? validColor;
  final Color? invalidColor;

  const CompactPasswordRequirements({
    super.key,
    required this.password,
    this.validColor,
    this.invalidColor,
  });

  @override
  Widget build(BuildContext context) {
    final valid = validColor ?? Colors.green.shade600;
    final invalid = invalidColor ?? Colors.grey.shade500;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CompactRequirementItem(
          text: context.loc.atLeast8CharsCriterion,
          isValid: password.length >= 8,
          validColor: valid,
          invalidColor: invalid,
        ),
        _CompactRequirementItem(
          text: context.loc.oneUppercaseCriterion,
          isValid: RegExp(r'[A-Z]').hasMatch(password),
          validColor: valid,
          invalidColor: invalid,
        ),
        _CompactRequirementItem(
          text: context.loc.oneLowercaseCriterion,
          isValid: RegExp(r'[a-z]').hasMatch(password),
          validColor: valid,
          invalidColor: invalid,
        ),
        _CompactRequirementItem(
          text: context.loc.oneDigitCriterion,
          isValid: RegExp(r'\d').hasMatch(password),
          validColor: valid,
          invalidColor: invalid,
        ),
      ],
    );
  }
}

class _CompactRequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;
  final Color validColor;
  final Color invalidColor;

  const _CompactRequirementItem({
    required this.text,
    required this.isValid,
    required this.validColor,
    required this.invalidColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            size: 14,
            color: isValid ? validColor : invalidColor,
          ),
          gapW4,
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isValid ? validColor : invalidColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress bar showing password strength
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final double height;
  final BorderRadius? borderRadius;
  final bool showLabel;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.height = 6,
    this.borderRadius,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);
    final color = _getStrengthColor(strength);
    final label = _getStrengthLabel(strength, context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(height / 2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: strength / 4,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          borderRadius ?? BorderRadius.circular(height / 2),
                    ),
                  ),
                ),
              ),
            ),
            if (showLabel) ...[
              gapW8,
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]
          ],
        ),
      ],
    );
  }

  int _calculateStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'\d').hasMatch(password)) strength++;
    return strength;
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return Colors.red.shade400;
      case 2:
        return Colors.orange.shade400;
      case 3:
        return Colors.yellow.shade600;
      case 4:
        return Colors.green.shade500;
      default:
        return Colors.grey.shade400;
    }
  }

  String _getStrengthLabel(int strength, BuildContext context) {
    switch (strength) {
      case 0:
      case 1:
        return context.loc.passwordStrengthWeak;
      case 2:
        return context.loc.passwordStrengthMedium;
      case 3:
        return context.loc.passwordStrengthGood;
      case 4:
        return context.loc.passwordStrengthStrong;
      default:
        return '';
    }
  }
}
