import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/ui/khatma_color_picker.dart';
import 'package:khatma/src/features/khatma/personal/presentation/form/ui/khatma_icon_picker.dart';
import 'package:khatma/src/utils/common.dart';

class KhatmaStyleSelector extends StatefulWidget {
  const KhatmaStyleSelector({
    super.key,
    required this.onChanged,
    required this.style,
  });

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
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH8,
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p12),
            child: KhatmaColorPicker(
              color: updatedStyle.color,
              onChanged: (value) => setState(() {
                updatedStyle = updatedStyle.copyWith(color: value);
              }),
            ),
          ),
        ),
        Divider(height: 3),
        gapH8,
        Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            child: KhatmaIconPicker(
              style: updatedStyle,
              onChanged: (value) => setState(() {
                updatedStyle = updatedStyle.copyWith(icon: value);
              }),
            ),
          ),
        ),
        gapH20,

        // Bouton appliquer
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: updatedStyle.hexColor,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              widget.onChanged(updatedStyle);
              Navigator.pop(context);
            },
            child: Text(
              l10n.apply,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        gapH12,
      ],
    );
  }
}
