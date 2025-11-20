import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onDateSelected,
    this.isRequired = true,
    this.firstDate,
    this.lastDate,
  });

  final TextEditingController controller;
  final String labelText;
  final ValueChanged<DateTime?> onDateSelected;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;

    return TextFormField(
      controller: controller,
      readOnly: true,
      style: Theme.of(context).textTheme.bodyLarge,
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
                return 'Please select a date';
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
      final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      controller.text = formattedDate;
      onDateSelected(selectedDate);
    }
  }

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
