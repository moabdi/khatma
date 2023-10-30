import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_color_picker.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_icon_picker.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TopBarBottomSheet(),
          Text(
            AppLocalizations.of(context).chooseColor.withColon,
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapH20,
          KhatmaColorPicker(
            color: updatedStyle.color.toColor(),
            onChanged: (value) => setState(() {
              updatedStyle = updatedStyle.copyWith(color: value.toHex());
            }),
          ),
          gapH20,
          Text(
            AppLocalizations.of(context).chooseIcon.withColon,
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapH20,
          KhatmaIconPicker(style: updatedStyle),
          gapH20,
          const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  widget.onChanged(updatedStyle);
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context).apply),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
