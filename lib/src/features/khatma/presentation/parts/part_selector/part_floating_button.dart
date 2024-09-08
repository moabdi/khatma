import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/snack_bars.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';

class PartFloatingButton extends StatelessWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
    required this.color,
  });
  final String? khatmaId;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedParts = ref.watch(khatmaPartsControllerProvider);
      return CollectionUtils.isEmpty(selectedParts)
          ? Container()
          : PrimaryButton(
              color: color,
              width: MediaQuery.of(context).size.width * .9,
              shadowOffset: 10,
              onPressed: () => _onSubmit(context, ref, selectedParts),
              text: AppLocalizations.of(context)
                  .completeParts(selectedParts.length),
            );
    });
  }

  _onSubmit(BuildContext context, WidgetRef ref, List<int> selectedParts) {
    final snackBar = buildSnackBar(
      context,
      Text(AppLocalizations.of(context)
          .successCompleteParts(selectedParts.length)),
    );

    ref
        .read(khatmaPartsControllerProvider.notifier)
        .completeParts(khatmaId!)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
