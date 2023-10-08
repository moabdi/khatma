import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/date_picker_field.dart';
import 'package:khatma/src/themes/theme.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.context,
    required this.label,
    required this.dateTime,
    required this.onChanged,
  });

  final BuildContext context;
  final String label;
  final DateTime dateTime;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            height: 40,
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
