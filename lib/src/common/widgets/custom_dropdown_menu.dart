import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  CustomDropdownMenu(
      {super.key, this.value, this.onChanged, required this.items});

  final T? value;
  final Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: DropdownButton<T>(
          menuMaxHeight: 300,
          isDense: true,
          focusColor: Theme.of(context).primaryColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          elevation: 12,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          value: value,
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }
}
