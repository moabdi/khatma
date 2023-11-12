import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';

class DatePickerListTile extends StatefulWidget {
  const DatePickerListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.leading,
    required this.title,
    this.firstDate,
    this.enabled = true,
  });

  final String title;
  final DateTime value;
  final DateTime? firstDate;
  final Widget leading;
  final bool enabled;
  final ValueChanged<DateTime> onChanged;

  @override
  _DatePickerListTileState createState() => _DatePickerListTileState();
}

class _DatePickerListTileState extends State<DatePickerListTile> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value,
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 10000)),
    );

    if (picked != null && picked != widget.value) {
      widget.onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: widget.enabled,
      dense: true,
      contentPadding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 10),
      minVerticalPadding: 0,
      leading: widget.leading,
      trailing: const Icon(Icons.arrow_right),
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        widget.value.format(),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: widget.enabled
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).dividerColor,
            ),
      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }
}
