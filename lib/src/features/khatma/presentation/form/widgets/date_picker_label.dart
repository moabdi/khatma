import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/date_picker_field.dart';
import 'package:khatma/src/themes/theme.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.dateTime,
    required this.onChanged,
  });

  final String label;
  final DateTime dateTime;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DatePickerField(
              date: dateTime,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
