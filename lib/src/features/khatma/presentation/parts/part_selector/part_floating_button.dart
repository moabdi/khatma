import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/features/khatma/presentation/parts/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:lottie/lottie.dart';

class PartFloatingButton extends ConsumerWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
    required this.color,
  });
  final String? khatmaId;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedParts = ref.watch(khatmaPartsControllerProvider);
    return CollectionUtils.isEmpty(selectedParts)
        ? Container()
        : PrimaryButton(
            width: MediaQuery.of(context).size.width * .9,
            shadowOffset: 10,
            onPressed: () => _onSubmit(context, ref, selectedParts),
            text: AppLocalizations.of(context)
                .completeParts(selectedParts.length),
          );
  }

  _onSubmit(BuildContext context, WidgetRef ref, List<int> selectedParts) {
    final snackBar = buildSnackBar(context, selectedParts);
    ref
        .read(khatmaPartsControllerProvider.notifier)
        .completeParts(khatmaId!)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(snackBar));
  }

  SnackBar buildSnackBar(BuildContext context, List<int> selectedParts) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Lottie.asset(
            'assets/lottie/check.json',
            width: 35,
            height: 35,
            fit: BoxFit.fill,
            repeat: false,
          ),
          gapW12,
          Text(AppLocalizations.of(context)
              .successCompleteParts(selectedParts.length)),
        ],
      ),
    );
  }
}
