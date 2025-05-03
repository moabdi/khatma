import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_color_picker.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_icon_picker.dart';

class KhatmaStyleSelector extends StatefulWidget {
  const KhatmaStyleSelector(
      {super.key, required this.onChanged, required this.style});

  final KhatmaTheme style;
  final ValueChanged<KhatmaTheme> onChanged;
  @override
  State<KhatmaStyleSelector> createState() => _KhatmaStyleSelectorState();
}

class _KhatmaStyleSelectorState extends State<KhatmaStyleSelector> {
  late KhatmaTheme updatedStyle;

  @override
  void initState() {
    updatedStyle = widget.style;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context).icon.colon,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapH4,
        Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: KhatmaIconPicker(
              style: updatedStyle,
              onChanged: (value) => setState(() {
                updatedStyle = updatedStyle.copyWith(icon: value);
              }),
            ),
          ),
        ),
        gapH20,
        Text(
          AppLocalizations.of(context).color.colon,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapH4,
        KhatmaColorPicker(
          color: updatedStyle.color,
          onChanged: (value) => setState(() {
            updatedStyle = updatedStyle.copyWith(color: value);
          }),
        ),
        gapH20,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor:
                    WidgetStateProperty.all(updatedStyle.hexColor)),
            onPressed: () {
              widget.onChanged(updatedStyle);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context).apply),
          ),
        ),
        gapH20,
      ],
    );
  }
}
