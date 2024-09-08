import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/extensions/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_color_picker.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_icon_picker.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaStyleSelector extends StatefulWidget {
  const KhatmaStyleSelector(
      {super.key, required this.onChanged, required this.style});

  final KhatmaStyle style;
  final ValueChanged<KhatmaStyle> onChanged;
  @override
  State<KhatmaStyleSelector> createState() => _KhatmaStyleSelectorState();
}

class _KhatmaStyleSelectorState extends State<KhatmaStyleSelector> {
  late KhatmaStyle updatedStyle;

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
          style: AppTheme.getTheme().textTheme.bodyLarge,
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
          style: AppTheme.getTheme().textTheme.bodyLarge,
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
