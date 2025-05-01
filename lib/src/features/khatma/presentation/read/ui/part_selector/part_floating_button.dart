import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/constants/snack_bars.dart';
import 'package:khatma/src/features/khatma/presentation/extentions/khatma_extention.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/buttons/primary_button.dart';
import 'package:khatma/src/features/khatma/presentation/read/khatma_complete_screen.dart';
import 'package:khatma/src/features/khatma/presentation/read/logic/khatma_parts_controller.dart';

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
    return Consumer(
      builder: (context, ref, child) {
        final selectedParts = ref.watch(khatmaPartsControllerProvider);
        if (selectedParts.isEmpty) return const SizedBox.shrink();

        return PrimaryButton(
          color: color,
          width: MediaQuery.of(context).size.width * .9,
          shadowOffset: 10,
          onPressed: () => _onSubmit(context, ref, selectedParts),
          text:
              AppLocalizations.of(context).completeParts(selectedParts.length),
        );
      },
    );
  }

  void _onSubmit(BuildContext context, WidgetRef ref, List<int> selectedParts) {
    final snackBar = buildSnackBar(
      context,
      Text(AppLocalizations.of(context)
          .successCompleteParts(selectedParts.length)),
    );

    ref
        .read(khatmaPartsControllerProvider.notifier)
        .completeParts(khatmaId!)
        .then((khatma) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (khatma.isCompleted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KhatmaSuccessComplete(khatma: khatma),
          ),
        );
      }
    });
  }
}
