import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/components/top_bar_bottom_sheet.dart';

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
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
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
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                gapH20,
                child,
                gapH20,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
