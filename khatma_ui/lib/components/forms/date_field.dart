import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date picker field with calendar icon
///
/// A TextFormField that opens a date picker when tapped.
/// Supports optional validation, clear button, and custom date range.
class DatePickerFormField extends StatelessWidget {
  const DatePickerFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onDateSelected,
    this.isRequired = true,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'dd/MM/yyyy',
    this.requiredErrorMessage = 'Please select a date',
  });

  final TextEditingController controller;
  final String labelText;
  final ValueChanged<DateTime?> onDateSelected;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dateFormat;
  final String requiredErrorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = controller.text.isNotEmpty;

    return TextFormField(
      controller: controller,
      readOnly: true,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: hasValue && !isRequired
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  onDateSelected(null);
                },
              )
            : IconButton(
                icon: const Icon(Icons.event),
                onPressed: () => _selectDate(context),
              ),
      ),
      validator: isRequired
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return requiredErrorMessage;
              }
              return null;
            }
          : null,
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _parseDate(controller.text) ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat(dateFormat).format(selectedDate);
      controller.text = formattedDate;
      onDateSelected(selectedDate);
    }
  }

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat(dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
