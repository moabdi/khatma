import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField(
      {super.key, required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<String> onChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _dateEditingController = TextEditingController();
  final DateTime maxEndDate = DateTime.now().add(const Duration(days: 3600));

  @override
  void initState() {
    super.initState();
    _dateEditingController.text = _dateFormat.format(widget.date);
  }

  @override
  void dispose() {
    _dateEditingController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime.now(),
      lastDate: maxEndDate,
    );

    if (picked != null && picked != widget.date) {
      _dateEditingController.text = _dateFormat.format(picked);
      widget.onChanged(_dateEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateEditingController,
      onTap: () => _selectDate(context),
      onChanged: widget.onChanged,
      decoration: const InputDecoration(
        isDense: true,
      ),
    );
  }
}
