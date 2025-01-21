import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import './share_provider.dart';
import './share_tile.dart';

class ShareOptions extends ConsumerWidget {
  const ShareOptions({super.key, required this.khatmaShare});

  final KhatmaShare khatmaShare;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => gapH8,
          itemCount: ShareVisibility.values.length,
          itemBuilder: (BuildContext context, int index) {
            var visibilityOption = ShareVisibility.values[index];
            return ShareTile(
              selected: khatmaShare.visibility == visibilityOption,
              value: visibilityOption,
              onSelect: (selectedVisibility) {
                ref.read(shareNotifierProvider.notifier).update(
                    khatmaShare.copyWith(visibility: selectedVisibility));
              },
            );
          },
        ),
      ),
    );
  }
}
