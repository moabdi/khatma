import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/date_picker_field.dart';
import 'package:khatma/src/themes/theme.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTheme.getTheme().textTheme.labelSmall,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DatePickerField(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
