import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';

class DatePickerListTile extends StatefulWidget {
  const DatePickerListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.leading,
    required this.title,
  });

  final String title;
  final DateTime value;
  final Icon leading;
  final ValueChanged<DateTime> onChanged;

  @override
  _DatePickerListTileState createState() => _DatePickerListTileState();
}

class _DatePickerListTileState extends State<DatePickerListTile> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 10000)),
    );

    if (picked != null && picked != widget.value) {
      widget.onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).disabledColor,
      ),
      child: ListTile(
        dense: true,
        title: Text(widget.title),
        subtitle: Text(widget.value.format()),
        onTap: () {
          _selectDate(context);
        },
        leading: widget.leading,
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
