import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField(
      {super.key, required this.value, required this.onChanged});

  final DateTime value;
  final ValueChanged<String> onChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _dateEditingController = TextEditingController();
  final DateTime maxEndDate = DateTime.now().add(const Duration(days: 3600));

  @override
  void initState() {
    super.initState();
    _dateEditingController.text = widget.value.format();
  }

  @override
  void dispose() {
    _dateEditingController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value,
      firstDate: DateTime.now(),
      lastDate: maxEndDate,
    );

    if (picked != null && picked != widget.value) {
      _dateEditingController.text = picked.format();
      widget.onChanged(_dateEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      enableInteractiveSelection: false,
      controller: _dateEditingController,
      onTap: () => _selectDate(context),
      onChanged: widget.onChanged,
      decoration: const InputDecoration(isDense: true),
    );
  }
}
