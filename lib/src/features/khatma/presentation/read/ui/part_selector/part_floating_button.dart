import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/exceptions/error_code.dart';
import 'package:khatma/src/exceptions/error_handler.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/utils/common.dart';
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

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width * .9, 48),
          ),
          onPressed: () => _onSubmit(context, ref, selectedParts),
          child: Text(
            AppLocalizations.of(context).completeParts(selectedParts.length),
          ),
        );
      },
    );
  }

  void _onSubmit(
      BuildContext context, WidgetRef ref, List<int> selectedParts) async {
    if (khatmaId?.isEmpty ?? true) return;

    try {
      final result = await ref
          .read(khatmaNotifierProvider.notifier)
          .completeParts(khatmaId!, selectedParts);

      if (!context.mounted) return;

      result.handleUI(
        context,
        onSuccess: () {
          Success.showSuccessMessage(
              context,
              AppLocalizations.of(context)
                  .successCompleteParts(selectedParts.length));
          ref.read(khatmaPartsControllerProvider).clear();

          if (result.dataOrNull!.status == KhatmaStatus.completed) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    KhatmaSuccessComplete(khatma: result.dataOrNull!),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        ErrorHandler.handleError(context, ErrorCode.generalUnknown);
      }
    }
  }
}
