import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  CustomDropdownMenu(
      {super.key,
      this.value,
      this.onChanged,
      required this.items,
      this.enabled = true});

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final bool enabled;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: DropdownButton<T>(
          isDense: true,
          elevation: 12,
          menuMaxHeight: 300,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          borderRadius: BorderRadius.circular(25),
          underline: const SizedBox(),
          value: value,
          onChanged: onChanged,
          items: enabled ? items : null,
        ),
      ),
    );
  }
}
