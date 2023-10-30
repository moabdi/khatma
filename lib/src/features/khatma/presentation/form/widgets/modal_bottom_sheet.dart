import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
import 'package:khatma/src/themes/theme.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    super.key,
    required this.title,
    required this.child,
  });
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: AppTheme.getTheme().listTileTheme.tileColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBarBottomSheet(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(title, style: AppTheme.getTheme().textTheme.titleLarge),
          ),
          gapH12,
          child,
          gapH20,
        ],
      ),
    );
  }
}
